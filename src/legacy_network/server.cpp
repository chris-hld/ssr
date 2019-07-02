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
/// Server class (implementation).

#include <functional>
#include "server.h"
#include "ssr_global.h"  // for VERBOSE2()
#include "legacy_xmlsceneprovider.h"  // for LegacyXmlSceneProvider

using ssr::legacy_network::Server;

Server::Server(api::Publisher& controller
    , LegacyXmlSceneProvider& scene_provider
    , int port, char end_of_message_character)
  : _controller(controller)
  , _scene_provider(scene_provider)
  , _io_service()
  , _acceptor(_io_service
      , asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
  , _network_thread(0)
  , _end_of_message_character(end_of_message_character)
{}

Server::~Server()
{
  this->stop();
}

void
Server::start_accept()
{
  // lock accept_mutex (not necessary)
  // std::lock_guard<std::mutex> lock(accept_mutex);

  Connection::pointer new_connection = Connection::create(_io_service
      , _controller, _end_of_message_character);

  _acceptor.async_accept(new_connection->socket()
      , std::bind(&Server::handle_accept, this, new_connection
      , std::placeholders::_1));

  // accept_mutex released when lock goes out of scope
}

void
Server::handle_accept(Connection::pointer new_connection
    , const asio::error_code &error)
{
  if (!error)
  {
    // A hack to mimic the old behavior of the legacy network interface:
    new_connection->write(_scene_provider.get_scene_as_XML());
    new_connection->start();
    VERBOSE2("Network connection accepted.");

    start_accept();
  }
}

void
Server::start()
{
  _network_thread = new std::thread(std::bind(&Server::run, this));
  VERBOSE2("Created network thread.");
}

void
Server::stop()
{
  VERBOSE2("Stopping network thread ...");
  if (_network_thread)
  {
    _io_service.stop();
    _network_thread->join();
  }
  VERBOSE2("Network thread stopped.");
}

void
Server::run()
{
  start_accept();
  _io_service.run();
}
