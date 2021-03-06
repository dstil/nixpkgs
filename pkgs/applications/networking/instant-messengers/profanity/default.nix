{ stdenv, fetchurl, pkgconfig, glib, openssl, expat, libmesode
, ncurses, libotr, curl, readline, libuuid

, autoAwaySupport ? false, libXScrnSaver ? null, libX11 ? null
, notifySupport ? false,   libnotify ? null, gdk_pixbuf ? null
}:

assert autoAwaySupport -> libXScrnSaver != null && libX11 != null;
assert notifySupport   -> libnotify != null && gdk_pixbuf != null;

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "profanity-${version}";
  version = "0.5.0";

  src = fetchurl {
    url = "http://www.profanity.im/profanity-${version}.tar.gz";
    sha256 = "0s4njc4rcaii51qw1najxa0fa8bb2fnas00z47y94wdbdsmfhfvq";
  };

  buildInputs = [
    pkgconfig readline libuuid libmesode
    glib openssl expat ncurses libotr curl
  ] ++ optionals autoAwaySupport [ libXScrnSaver libX11 ]
    ++ optionals notifySupport   [ libnotify gdk_pixbuf ];

  meta = {
    description = "A console based XMPP client";
    longDescription = ''
      Profanity is a console based XMPP client written in C using ncurses and
      libstrophe, inspired by Irssi.
    '';
    homepage = http://profanity.im/;
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.devhell ];
  };
}
