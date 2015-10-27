<?xml version="1.0" encoding="utf-8"?>
<asdf>
  <header>
    <name>Scene for use with a DAW</name>
    <description>
      This scene is made in order to connect a digital audio
      work station (DAW) like Ardour to the SSR.
      Start the SSR with the appropriate prefix of the JACK
      ports of the DAW you are using, e.g.

      ssr-binaural --input-prefix="DAW_JACK_OUTPUT_PORT_PREFIX" daw_scene.asd

      Each virtual source then represents one track in the
      DAW.
    </description>
  </header>

  <scene_setup>
    <source name="track 1" model="point">
      <port>1</port>
      <position x="-1.5" y="2"/>
    </source>
    <source name="track 2" model="point">
      <port>2</port>
      <position x="-0.5" y="2"/>
    </source>
    <source name="track 3" model="point">
      <port>3</port>
      <position x="0.5" y="2"/>
    </source>
    <source name="track 4" model="point">
      <port>4</port>
      <position x="1.5" y="2"/>
    </source>
   <source name="track 5" model="point">
      <port>5</port>
      <position x="-1.5" y="1"/>
    </source>
   <source name="track 6" model="point">
      <port>6</port>
      <position x="-0.5" y="1"/>
    </source>
   <source name="track 7" model="point">
      <port>7</port>
      <position x="0.5" y="1"/>
    </source>
   <source name="track 8" model="point">
      <port>8</port>
      <position x="1.5" y="1"/>
    </source>
<source name="track 9" model="point">
      <port>9</port>
      <position x="-1.5" y="3"/>
    </source>
   <source name="track 10" model="point">
      <port>10</port>
      <position x="-0.5" y="3"/>
    </source>
   <source name="track 11" model="point">
      <port>11</port>
      <position x="0.5" y="3"/>
    </source>
   <source name="track 12" model="point">
      <port>12</port>
      <position x="1.5" y="3"/>
    </source>
<source name="track 13" model="point">
      <port>13</port>
      <position x="-1.5" y="0"/>
    </source>
   <source name="track 14" model="point">
      <port>14</port>
      <position x="-0.5" y="0"/>
    </source>
   <source name="track 15" model="point">
      <port>15</port>
      <position x="0.5" y="0"/>
    </source>
   <source name="track 16" model="point">
      <port>16</port>
      <position x="1.5" y="0"/>
    </source>

    
  </scene_setup>
</asdf>
