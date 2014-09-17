FROM opensuse
MAINTAINER Martin Liška <mliska@suse.cz>

RUN mkdir /abuild
WORKDIR /abuild

RUN zypper up --skip-interactive
RUN zypper --non-interactive --gpg-auto-import-keys install wget unzip intltool pkg-config libpng16-devel gc-devel freetype2-devel liblcms2-devel libxml2-devel libxslt-devel gsl-devel boost-devel popt-devel flex make zip gcc-c++ gcc gcc-32bit gmp-devel mpfr-devel mpc-devel tar
