/* src/config.h.  Generated from config.h.in by configure.  */
/* src/config.h.in.  Generated from configure.ac by autoheader.  */

/* Ambisonics Amplitude Panning renderer */
#define ENABLE_AAP 1

/* all renderers (use --enable-xyz to re-enable certain renderers) */
#define ENABLE_ALL 1

/* creation of a MacOSX application bundle */
/* #undef ENABLE_APP_BUNDLE */

/* binaural renderer (using HRIRs) */
#define ENABLE_BINAURAL 1

/* Binaural Room Synthesis renderer (using BRIRs) */
#define ENABLE_BRS 1

/* debugging symbols, asserts, ... */
/* #undef ENABLE_DEBUGGING */

/* Ecasound soundfile playback/recording */
#define ENABLE_ECASOUND 1

/* separate control window */
#define ENABLE_FLOATING_CONTROL_PANEL 1

/* generic renderer */
#define ENABLE_GENERIC 1

/* graphical user interface (using Qt) */
#define ENABLE_GUI 1

/* InterSense tracker support */
/* #undef ENABLE_INTERSENSE */

/* network (TCP/IP) interface */
#define ENABLE_IP_INTERFACE 1

/* support for isatty() */
#define ENABLE_ISATTY 1

/* MMX support */
#define ENABLE_MMX 1

/* Near-Field-Compensated Higher-Order-Ambisonics renderer */
#define ENABLE_NFC_HOA 1

/* code optimization */
#define ENABLE_OPTIMIZATION 1

/* Polhemus Fastrak/Patriot tracker support */
#define ENABLE_POLHEMUS 1

/* Razor AHRS tracker support */
#define ENABLE_RAZOR 1

/* SSE support */
#define ENABLE_SSE 1

/* SSE2 support */
#define ENABLE_SSE2 1

/* Vector Base Amplitude Panning renderer */
#define ENABLE_VBAP 1

/* VRPN tracker support */
/* #undef ENABLE_VRPN */

/* compiler warnings */
#define ENABLE_WARNINGS 1

/* Wave Field Synthesis renderer */
#define ENABLE_WFS 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Using InterSense library version >= 4.04 */
/* #undef HAVE_INTERSENSE_404 */

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* Name of package */
#define PACKAGE "ssr"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "ssr@spatialaudio.net"

/* Define to the full name of this package. */
#define PACKAGE_NAME "SSR (SoundScape Renderer)"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "SSR (SoundScape Renderer) 0.4.2-94-g247d9a6"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "ssr"

/* Define to the home page for this package. */
#define PACKAGE_URL "http://spatialaudio.net/ssr/"

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.4.2-94-g247d9a6"

/* List of SSR authors */
#define SSR_AUTHORS "Written by:\n Matthias Geier, Jens Ahrens\nScientific supervision:\n Sascha Spors\nContributions by:\n Peter Bartz, Florian Hinterleitner, Torben Hohn,\n Lukas Kaser, André Möhl, Till Rettberg, Fiete Winter\nGUI design:\n Katharina Bredies, Jonas Loh, Jens Ahrens\nLogo design:\n Fabian Hemmert"

/* List of SSR authors (with Qt markup) */
#define SSR_AUTHORS_QT "<EM>Written&nbsp;by:</EM><BR>&nbsp;Matthias&nbsp;Geier,&nbsp;Jens&nbsp;Ahrens<BR><BR><EM>Scientific&nbsp;supervision:</EM><BR>&nbsp;Sascha&nbsp;Spors<BR><BR><EM>Contributions&nbsp;by:</EM><BR>&nbsp;Peter&nbsp;Bartz,&nbsp;Florian&nbsp;Hinterleitner,&nbsp;Torben&nbsp;Hohn,<BR>&nbsp;Lukas&nbsp;Kaser,&nbsp;Andr&eacute;&nbsp;M&ouml;hl,&nbsp;Till&nbsp;Rettberg,&nbsp;Fiete&nbsp;Winter<BR><BR><EM>GUI&nbsp;design:</EM><BR>&nbsp;Katharina&nbsp;Bredies,&nbsp;Jonas&nbsp;Loh,&nbsp;Jens&nbsp;Ahrens<BR><BR><EM>Logo&nbsp;design:</EM><BR>&nbsp;Fabian&nbsp;Hemmert"

/* SSR copyright notice */
#define SSR_COPYRIGHT "Copyright © 2016 Division of Applied Acoustics, Chalmers University of Technology\nCopyright © 2014 Institut für Nachrichtentechnik, Universität Rostock\nCopyright © 2012 Quality & Usability Lab, Telekom Innovation Laboratories, TU Berlin\n\nLicense GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>\nThis is free software: you are free to change and redistribute it.\nThere is NO WARRANTY, to the extent permitted by law."

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Version number of package */
#define VERSION "0.4.2-94-g247d9a6"
