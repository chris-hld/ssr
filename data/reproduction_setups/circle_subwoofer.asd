<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="asdf2html.xsl"?>
<asdf xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:noNamespaceSchemaLocation="asdf.xsd">
  <header>
    <name>Loudspeaker Ring</name>
  </header>

  <reproduction_setup>
    <circular_array number="56">
      <first>
        <!-- about 3 meters diameter -->
        <position x="1.5" y="0"/>
        <orientation azimuth="-180"/>
      </first>
    </circular_array>
	
    <!-- skip 7 output channels of the soundcard -->
    <skip number="7"/>
	
	    <!-- The following loudspeaker is a subwoofer at output channel 64 -->
    <loudspeaker model="subwoofer">
      <position x="1" y="0"/>
      <orientation azimuth="180"/> <!-- angles are not limited to 0..360 -->
    </loudspeaker>

  </reproduction_setup>
</asdf>
