FROM opensuse
MAINTAINER Martin Liška <mliska@suse.cz>

RUN mkdir /abuild
WORKDIR /abuild

RUN zypper up --skip-interactive
RUN zypper --non-interactive --gpg-auto-import-keys install git wget unzip intltool pkg-config libpng16-devel gc-devel freetype2-devel liblcms2-devel libxml2-devel libxslt-devel gsl-devel boost-devel popt-devel flex make zip gcc-c++ gcc gcc-32bit gmp-devel mpfr-devel mpc-devel tar bison which gtkmm3-devel gtkmm2-devel strace vim babl-devel gegl-devel libtiff-devel libjpeg-devel python-devel python-gtk-devel bc

WORKDIR /abuild
RUN wget ftp://sourceware.org/pub/binutils/snapshots/binutils-2.24.51.tar.bz2
RUN tar xjvf binut*
WORKDIR binutils-2.24.51
RUN ./configure --prefix=/abuild/bin/binutils --enable-gold --enable-plugins --enable-lto && make -j$(nproc) && make install
RUN rm -rf binutils-2.24.51
ENV PATH /abuild/bin/binutils/bin/:$PATH

WORKDIR /abuild
RUN wget http://downloads.sourceforge.net/inkscape/inkscape-0.48.5.tar.gz
RUN tar xfvz inks*

RUN wget http://de-mirror.gimper.net/pub/gimp/v2.8/gimp-2.8.14.tar.bz2
RUN tar xfvj gimp*
RUN rm *.tar.*

RUN wget --no-check-certificate https://kernel.org/pub/linux/kernel/v3.x/testing/linux-3.17-rc6.tar.xz
RUN mkdir linux && tar xvJf linux-* -C linux --strip-components=1
RUN wget --no-check-certificate https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/plain/include/linux/compiler-gcc5.h?id=refs/tags/next-20140922 -o compiler-gcc5.h
RUN rm *.tar.*

RUN cd linux && cp ../compiler-gcc5.h include/linux && make allyesconfig
