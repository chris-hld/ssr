/******************************************************************************
 * Copyright © 2012-2014 Institut für Nachrichtentechnik, Universität Rostock *
 * Copyright © 2006-2012 Quality & Usability Lab,                             *
 *                       Telekom Innovation Laboratories, TU Berlin           *
 *                                                                            *
 * This file is part of the SoundScape Renderer (SSR).                        *
 *                                                                            *
 * The SSR is free software:  you can redistribute it and/or modify it  under *
 * the terms of the  GNU  General  Public  License  as published by the  Free *
 * Software Foundation, either version 3 of the License,  or (at your option) *
 * any later version.                                                         *
 *                                                                            *
 * The SSR is distributed in the hope that it will be useful, but WITHOUT ANY *
 * WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
 * FOR A PARTICULAR PURPOSE.                                                  *
 * See the GNU General Public License for more details.                       *
 *                                                                            *
 * You should  have received a copy  of the GNU General Public License  along *
 * with this program.  If not, see <http://www.gnu.org/licenses/>.            *
 *                                                                            *
 * The SSR is a tool  for  real-time  spatial audio reproduction  providing a *
 * variety of rendering algorithms.                                           *
 *                                                                            *
 * http://spatialaudio.net/ssr                           ssr@spatialaudio.net *
 ******************************************************************************/

/// @file
/// Audio player using ecasound (implementation).

#include <jack/jack.h> // for jack_client_name_size()
#include <algorithm>

#include "audioplayer.h"
#include "maptools.h"
#include "ssr_global.h"
#include "apf/stringtools.h"
#include "apf/sndfiletools.h"
#include "posixpathtools.h"


using maptools::get_item;


/// delete the file map.
AudioPlayerRTA::~AudioPlayerRTA()
{
  if (!_file_map.empty())
  {
    maptools::purge(_file_map);
    VERBOSE2("AudioPlayer dtor: file map deleted.");
  }
  else
  {
    VERBOSE2("AudioPlayer dtor.");
  }
}


void AudioPlayerRTA::open_audio_file(const std::string& audio_file_name, bool loop)
{
  auto registered_file = get_item(_file_map, audio_file_name);
  if (registered_file != nullptr)
  {
    VERBOSE2("AudioPlayer: Input file '" + audio_file_name
        + "' already registered.");
  }
  else // file not yet registered
  {
    auto temp = Soundfile::create(audio_file_name, loop);
    if (!temp)
    {
      WARNING("AudioPlayer: Initialization of soundfile '" + audio_file_name
          + "' failed!");
    }

    // Memory Leak?
    _file_map[audio_file_name] = temp.release();
  }
}


std::string AudioPlayerRTA::get_port_name(const std::string& audio_file_name,
    int channel, bool loop)
{
  assert(channel >= 0);
  auto registered_file = get_item(_file_map, audio_file_name);

  if (channel > registered_file->get_channels())
  {
  //try: open_audio_file(audio_file_name, loop);
    ERROR("AudioPlayer: Channel " << channel << " doesn't exist in '"
        + audio_file_name + "'!");
    return "";
  }

  return registered_file->get_client_name() + ":"
    + registered_file->get_output_prefix() + "_" + apf::str::A2S(channel);
}

/** _.
 * @param audio_file_name the audio file you want to know the length of.
 * @warning If the file wasn't loaded before, 0 is returned!
 **/
long int AudioPlayerRTA::get_file_length(const std::string& audio_file_name) const
{
  const Soundfile* const file = get_item(_file_map, audio_file_name);
  return file ? file->get_length() : 0;
}

int AudioPlayerRTA::get_channel_no(const std::string& audio_file_name) const
{
  const Soundfile* const file = get_item(_file_map, audio_file_name);
  return file ? file->get_channels() : 0;
}


AudioPlayerRTA::Soundfile::ptr_t AudioPlayerRTA::Soundfile::create(
    const std::string& filename, bool loop)
{
  ptr_t sndfile_ptr; // temp = NULL
  try
  {
    sndfile_ptr.reset(new Soundfile(filename, loop));
  }
  catch(soundfile_error& e)
  {
    ERROR(e.what());
  }
  return sndfile_ptr;
}

AudioPlayerRTA::Soundfile::Soundfile(const std::string& filename, bool loop) throw (soundfile_error) :
  _output_prefix("outport"),
  _filename(filename),
  _client_name(""),
  _channels(0)
{
  // TODO.
  _sndfile = SndfileHandle (_filename) ;

  // Show some info
  std::cout << "Reading file: " << _filename << std::endl;
  std::cout << "File format: " << _sndfile.format() << std::endl;
  std::cout << "PCM 16 BIT: " << (SF_FORMAT_WAV | SF_FORMAT_PCM_16) << std::endl;
  std::cout << "Samples in file: " << _sndfile.frames() << std::endl;
  std::cout << "Samplerate " << _sndfile.samplerate() << std::endl;
  std::cout << "Channels: " << _sndfile.channels() << std::endl;

  _channels = _sndfile.channels();
  _sample_rate = _sndfile.samplerate();
  _length_samples = _sndfile.frames();
  _sample_format = _sndfile.format();

  _client_name = _filename;

}

AudioPlayerRTA::Soundfile::~Soundfile()
{
  // TODO: check.
  VERBOSE2("AudioPlayer::Soundfile: '" + _filename + "' disconnected.");
}

int AudioPlayerRTA::Soundfile::get_channels() const
{
  return _channels;
}

std::string AudioPlayerRTA::Soundfile::get_client_name() const
{
  return _client_name;
}

std::string AudioPlayerRTA::Soundfile::get_output_prefix() const
{
  return _output_prefix;
}

long int AudioPlayerRTA::Soundfile::get_length() const
{
  return _length_samples;
}


// int AudioPlayerRTA::Soundfile::init_channels(const std::string& filename)
// {
//   AudioPlayerRTA::Soundfile tmp_file(filename, false);
//   return tmp_file._channels;
// }

// std::string AudioPlayerRTA::Soundfile::init_format(const std::string& filename)
// {
//   AudioPlayerRTA::Soundfile tmp_file(filename, false);
//   return tmp_file._sample_format;
// }



// Call
int fplay( void *outputBuffer, void *inputBuffer, unsigned int nBufferFrames,
         double streamTime, RtAudioStreamStatus status, void *userData )
{


  int16_t *buffer = (int16_t *) outputBuffer;
  // TODO
  // ok, i know this is not the best way to do file i/o in the audio thread, but 
  // this is just for demonstration purposes ... 
  SndfileHandle *sndfile = reinterpret_cast<SndfileHandle*>(userData);

  // Error handling !
  if ( status ){
    std::cout << "Stream underflow detected!" << std::endl;
  }


  // 'readf()' frames
  // 'read()' Samples !
  // ! Frames != Samples
  sndfile->readf(buffer, nBufferFrames);

  return 0;
}

// TODO: Could throw
bool AudioPlayerRTA::Soundfile::init_RTA_stream()
{
  if ( _rta.getDeviceCount() < 1 ) {
    std::cout << "\nNo audio devices found!\n";
    return 0;
  }

  // Determine the number of devices available
  unsigned int devices = _rta.getDeviceCount();
  // Scan through devices for various capabilities
  RtAudio::DeviceInfo info;
  std::string renderer_name =  "BinauralRenderer";
  int rendererID = -1;
  for ( unsigned int i=0; i<devices; i++ ) {
    info = _rta.getDeviceInfo( i );
    if ( info.probed == true ) {
      VERBOSE3("Probing device = " + info.name);
      // Search for Renderer and set rendererID
      rendererID = info.name == renderer_name ? i : -1;
    }
  }
  if (rendererID == -1)
    ERROR("No renderer found");

  // Output params
  RtAudio::StreamParameters rtaParameters;
  rtaParameters.deviceId = rendererID;
  rtaParameters.nChannels = _channels;
  rtaParameters.firstChannel = 0;

  RtAudio::StreamOptions rtaOptions;
  rtaOptions.flags = RTAUDIO_JACK_DONT_CONNECT;
  // TODO : clean filename
  rtaOptions.streamName = _client_name;
  unsigned int sampleRate = _sample_rate;
  // TODO
  unsigned int bufferFrames = 1024;

  try {
    _rta.openStream( &rtaParameters, NULL, RTAUDIO_SINT16,
                    sampleRate, &bufferFrames, &fplay, (void *)&_sndfile, &rtaOptions);
    VERBOSE2("Audio file stream opened.");
    //JackClient::connect_ports(_client_name, renderer_name);
  }
  catch ( RtAudioError& e ) {
    e.printMessage();
    return 0;
  }
  return 1;
}

void AudioPlayerRTA::Soundfile::start()
{
    if (!_is_RTA_stream){
      _is_RTA_stream = init_RTA_stream();
    }

    _rta.startStream();
}

void AudioPlayerRTA::Soundfile::stop()
{
  _rta.stopStream();
}

double AudioPlayerRTA::Soundfile::get_time()
{  // TODO
  return _rta.getStreamTime();
}

void AudioPlayerRTA::Soundfile::set_time(double time)
{  // TODO
  _rta.setStreamTime(time);
}


void AudioPlayerRTA::start_all_streams(){
  // TODO: Check if empty!! segfault
  for(const auto& fileIt : _file_map)
  {
    VERBOSE2("START file: " + fileIt.first);
    fileIt.second->start();
  }
}

/* void AudioPlayerRTA::connect_all_streams(const auto _renderer){
TODO
} */

const AudioPlayerRTA::soundfile_map_t AudioPlayerRTA::get_file_map() const {
  return _file_map;
}



void AudioPlayerRTA::stop_all_streams(){
  for(const auto& fileIt : _file_map)
  {
    VERBOSE2("STOP file: " + fileIt.first);
    fileIt.second->stop();
  }
}


// Settings for Vim (http://www.vim.org/), please do not remove:
// vim:softtabstop=2:shiftwidth=2:expandtab:textwidth=80:cindent
// vim:fdm=expr:foldexpr=getline(v\:lnum)=~'/\\*\\*'&&getline(v\:lnum)!~'\\*\\*/'?'a1'\:getline(v\:lnum)=~'\\*\\*/'&&getline(v\:lnum)!~'/\\*\\*'?'s1'\:'='
