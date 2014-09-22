FROM opensuse
MAINTAINER Martin Liška <mliska@suse.cz>

RUN mkdir /abuild
WORKDIR /abuild

RUN zypper up --skip-interactive
RUN zypper --non-interactive --gpg-auto-import-keys install git wget unzip intltool pkg-config libpng16-devel gc-devel freetype2-devel liblcms2-devel libxml2-devel libxslt-devel gsl-devel boost-devel popt-devel flex make zip gcc-c++ gcc gcc-32bit gmp-devel mpfr-devel mpc-devel tar bison which gtkmm3-devel gtkmm2-devel strace vim babl-devel gegl-devel libtiff-devel libjpeg-devel python-devel python-gtk-devel bc

WORKDIR /abuild
RUN wget -q ftp://sourceware.org/pub/binutils/snapshots/binutils-2.24.51.tar.bz2
RUN mkdir binutils && tar xjf binut*.tar.bz2 --strip-components=1 -C binutils
WORKDIR binutils
RUN ./configure --prefix=/abuild/bin/binutils --enable-gold --enable-plugins --enable-lto && make -j$(nproc) && make install
RUN rm -rf binutils
ENV PATH /abuild/bin/binutils/bin/:$PATH

WORKDIR /abuild
RUN wget -q http://downloads.sourceforge.net/inkscape/inkscape-0.48.5.tar.gz
RUN mkdir inkscape && tar xfz inks*.tar.gz -C inkscape --strip-components=1

RUN wget -q http://de-mirror.gimper.net/pub/gimp/v2.8/gimp-2.8.14.tar.bz2
RUN mkdir gimp && tar xfj gimp*.tar.bz2 -C gimp --strip-components=1

RUN wget -q --no-check-certificate https://kernel.org/pub/linux/kernel/v3.x/testing/linux-3.17-rc6.tar.xz
RUN mkdir linux && tar xJf linux-*.tar.xz -C linux --strip-components=1
RUN wget --no-check-certificate https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/plain/include/linux/compiler-gcc5.h?id=refs/tags/next-20140922 -q -O compiler-gcc5.h

RUN cd linux && cp ../compiler-gcc5.h include/linux && make allyesconfig

RUN rm *.tar.*
