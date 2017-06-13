FROM consol/centos-xfce-vnc:1.1.0
USER 0
RUN yum install -y wget tar gzip unzip && yum clean all
RUN yum install samba-winbind-clients -y
RUN yum groupinstall 'Development Tools' -y
RUN yum install libjpeg-turbo-devel libtiff-devel freetype-devel -y
RUN yum install glibc-devel.{i686,x86_64} libgcc.{i686,x86_64} libX11-devel.{i686,x86_64} freetype-devel.{i686,x86_64} gnutls-devel.{i686,x86_64} libxml2-devel.{i686,x86_64} libjpeg-turbo-devel.{i686,x86_64} libpng-devel.{i686,x86_64} libXrender-devel.{i686,x86_64} alsa-lib-devel.{i686,x86_64} -y
WORKDIR /usr/src
RUN wget http://dl.winehq.org/wine/source/1.8/wine-1.8.5.tar.bz2 -O wine-1.8.5.tar.bz2 && tar xjf wine-1.8.5.tar.bz2
WORKDIR wine-1.8.5/
RUN mkdir -p wine32 wine64
WORKDIR wine64
RUN ../configure --enable-win64 && make -j 4
WORKDIR ../wine32
RUN ../configure --with-wine64=../wine64 && make -j 4 && make install
WORKDIR ../wine64
RUN make install
WORKDIR /root