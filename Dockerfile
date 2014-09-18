FROM opensuse
MAINTAINER Martin Liška <mliska@suse.cz>

RUN mkdir /abuild
WORKDIR /abuild

RUN zypper up --skip-interactive
RUN zypper --non-interactive --gpg-auto-import-keys install git wget unzip intltool pkg-config libpng16-devel gc-devel freetype2-devel liblcms2-devel libxml2-devel libxslt-devel gsl-devel boost-devel popt-devel flex make zip gcc-c++ gcc gcc-32bit gmp-devel mpfr-devel mpc-devel tar bison which gtkmm3-devel

WORKDIR /abuild
RUN wget ftp://sourceware.org/pub/binutils/snapshots/binutils-2.24.51.tar.bz2
RUN tar xjvf binut*
WORKDIR binutils-2.24.51
RUN ./configure --prefix=/abuild/bin/binutils --enable-gold --enable-plugins && make -j$(nproc) && make install
RUN rm -rf binutils-2.24.51
ENV PATH /abuild/bin/binutils/bin/:$PATH

WORKDIR /abuild
RUN wget http://downloads.sourceforge.net/inkscape/inkscape-0.48.5.tar.gz
RUN tar xfvz inks*
RUN rm *.tar.*
