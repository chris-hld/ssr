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

<source name="track 17" model="point">
      <port>17</port>
      <position x="-1.5" y="2"/>
    </source>
    <source name="track 18" model="point">
      <port>18</port>
      <position x="-0.5" y="2"/>
    </source>
    <source name="track 19" model="point">
      <port>19</port>
      <position x="0.5" y="2"/>
    </source>
    <source name="track 20" model="point">
      <port>20</port>
      <position x="1.5" y="2"/>
    </source>
   <source name="track 21" model="point">
      <port>21</port>
      <position x="-1.5" y="1"/>
    </source>
   <source name="track 22" model="point">
      <port>22</port>
      <position x="-0.5" y="1"/>
    </source>
   <source name="track 23" model="point">
      <port>23</port>
      <position x="0.5" y="1"/>
    </source>
   <source name="track 24" model="point">
      <port>24</port>
      <position x="1.5" y="1"/>
    </source>
<source name="track 25" model="point">
      <port>25</port>
      <position x="-1.5" y="3"/>
    </source>
   <source name="track 26" model="point">
      <port>26</port>
      <position x="-0.5" y="3"/>
    </source>
   <source name="track 27" model="point">
      <port>27</port>
      <position x="0.5" y="3"/>
    </source>
   <source name="track 28" model="point">
      <port>28</port>
      <position x="1.5" y="3"/>
    </source>
	<source name="track 29" model="point">
      <port>29</port>
      <position x="-1.5" y="0"/>
    </source>
   <source name="track 30" model="point">
      <port>30</port>
      <position x="-0.5" y="0"/>
    </source>
   <source name="track 31" model="point">
      <port>31</port>
      <position x="0.5" y="0"/>
    </source>
   <source name="track 32" model="point">
      <port>32</port>
      <position x="1.5" y="0"/>
    </source>

	    <source name="track 33" model="point">
      <port>33</port>
      <position x="-1.5" y="2"/>
    </source>
    <source name="track 34" model="point">
      <port>34</port>
      <position x="-0.5" y="2"/>
    </source>
    <source name="track 35" model="point">
      <port>35</port>
      <position x="0.5" y="2"/>
    </source>
    <source name="track 36" model="point">
      <port>36</port>
      <position x="1.5" y="2"/>
    </source>
   <source name="track 37" model="point">
      <port>37</port>
      <position x="-1.5" y="1"/>
    </source>
   <source name="track 38" model="point">
      <port>38</port>
      <position x="-0.5" y="1"/>
    </source>
   <source name="track 39" model="point">
      <port>39</port>
      <position x="0.5" y="1"/>
    </source>
   <source name="track 40" model="point">
      <port>40</port>
      <position x="1.5" y="1"/>
    </source>
<source name="track 41" model="point">
      <port>41</port>
      <position x="-1.5" y="3"/>
    </source>
   <source name="track 42" model="point">
      <port>42</port>
      <position x="-0.5" y="3"/>
    </source>
   <source name="track 43" model="point">
      <port>43</port>
      <position x="0.5" y="3"/>
    </source>
   <source name="track 44" model="point">
      <port>44</port>
      <position x="1.5" y="3"/>
    </source>
	<source name="track 45" model="point">
      <port>45</port>
      <position x="-1.5" y="0"/>
    </source>
   <source name="track 46" model="point">
      <port>46</port>
      <position x="-0.5" y="0"/>
    </source>
   <source name="track 47" model="point">
      <port>47</port>
      <position x="0.5" y="0"/>
    </source>
   <source name="track 48" model="point">
      <port>48</port>
      <position x="1.5" y="0"/>
    </source>

	    <source name="track 49" model="point">
      <port>49</port>
      <position x="-1.5" y="2"/>
    </source>
    <source name="track 50" model="point">
      <port>50</port>
      <position x="-0.5" y="2"/>
    </source>
    <source name="track 51" model="point">
      <port>51</port>
      <position x="0.5" y="2"/>
    </source>
    <source name="track 52" model="point">
      <port>52</port>
      <position x="1.5" y="2"/>
    </source>
  

    
  </scene_setup>
</asdf>
