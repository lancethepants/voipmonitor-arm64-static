#!/mmc/bin/bash

set -e
set -x

mkdir -p /mmc/src/voipmonitor
SRC=/mmc/src/voipmonitor
MAKE="make -j`nproc`"

########## ##################################################################
# LIBOGG # ##################################################################
########## ##################################################################

mkdir -p $SRC/libogg && cd $SRC/libogg

if [ ! -f .downloaded ]; then
	wget https://downloads.xiph.org/releases/ogg/libogg-1.3.5.tar.gz
	touch .downloaded
fi

if [ ! -f .extracted ]; then
	rm -rf libogg-1.3.5
	tar zxvf libogg-1.3.5.tar.gz
	touch .extracted
fi

cd libogg-1.3.5

if [ ! -f .configured ]; then
	./configure \
	--prefix=/mmc \
	--enable-static \
	--disable-shared
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install
	touch .installed
fi

############# ###############################################################
# LIBVORBIS # ###############################################################
############# ###############################################################

mkdir -p $SRC/libvorbis && cd $SRC/libvorbis

if [ ! -f .downloaded ]; then
	wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.gz
	touch .downloaded
fi

if [ ! -f .extracted ]; then
	rm -rf libvorbis-1.3.7
	tar zxvf libvorbis-1.3.7.tar.gz
	touch .extracted
fi

cd libvorbis-1.3.7

if [ ! -f .configured ]; then
	./configure \
	--prefix=/mmc \
	--enable-static \
	--disable-shared
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install
	touch .installed
fi

########## ##################################################################
# SNAPPY # ##################################################################
########## ##################################################################

mkdir -p $SRC/snappy && cd $SRC/snappy

if [ ! -f .downloaded ]; then
	git clone https://github.com/google/snappy.git
	touch .downloaded
fi

cd snappy

if [ ! -f .configured ]; then
	git submodule update --init
	git checkout 1.1.9
	cmake \
	-DCMAKE_INSTALL_PREFIX=/mmc \
	-DCMAKE_INSTALL_LIBDIR=lib \
	-DCMAKE_INSTALL_FULL_LIBDIR=/mmc/lib \
	.
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install
	touch .installed
fi


########## ##################################################################
# LIBICU # ##################################################################
########## ##################################################################

mkdir -p $SRC/icu && cd $SRC/icu

if [ ! -f .downloaded ]; then
        wget https://github.com/unicode-org/icu/releases/download/release-71-1/icu4c-71_1-src.tgz
        touch .downloaded
fi

if [ ! -f .extracted ]; then
        rm -rf icu
        tar zxvf icu4c-71_1-src.tgz
	sed -i 's,LD_LIBRARY_PATH,MUSL_LD_LIBRARY_PATH,g' $SRC/icu/icu/source/config/Makefile.inc.in $SRC/icu/icu/source/icudefs.mk.in
        touch .extracted
fi

cd icu/source

if [ ! -f .configured ]; then
	CC=gcc \
	CXX=g++ \
	./configure \
	--prefix=/mmc \
	--enable-static
        touch .configured
fi

if [ ! -f .built ]; then
        $MAKE
        touch .built
fi

if [ ! -f .installed ]; then
        make install
        touch .installed
fi

########## ##################################################################
# LIBPNG # ##################################################################
########## ##################################################################

mkdir -p $SRC/libpng && cd $SRC/libpng

if [ ! -f .downloaded ]; then
	wget https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz
	touch .downloaded
fi

if [ ! -f .extracted ]; then
	rm -rf libpng-1.6.37
	tar zxvf libpng-1.6.37.tar.gz
	touch .extracted
fi

cd libpng-1.6.37

if [ ! -f .configured ]; then
	./configure \
	--prefix=/mmc \
	--enable-static \
	--disable-shared
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install
	touch .installed
fi

######## ####################################################################
# FFTW # ####################################################################
######## ####################################################################

mkdir -p $SRC/fftw && cd $SRC/fftw

if [ ! -f .downloaded ]; then
	wget http://www.fftw.org/fftw-3.3.10.tar.gz
	touch .downloaded
fi

if [ ! -f .extracted ]; then
	rm -rf fftw-3.3.10
	tar zxvf fftw-3.3.10.tar.gz
	touch .extracted
fi

cd fftw-3.3.10

if [ ! -f .configured ]; then
	./configure \
	--prefix=/mmc \
	--enable-static \
	--disable-shared
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install
	touch .installed
fi

######## ####################################################################
# JSON # ####################################################################
######## ####################################################################

mkdir -p $SRC/json && cd $SRC/json

if [ ! -f .downloaded ]; then
        wget https://github.com/json-c/json-c/archive/refs/tags/json-c-0.16-20220414.tar.gz
        touch .downloaded
fi

if [ ! -f .extracted ]; then
        rm -rf json-c-json-c-0.16-20220414.tar.gz
        tar zxvf json-c-0.16-20220414.tar.gz
        touch .extracted
fi

cd json-c-json-c-0.16-20220414

if [ ! -f .configured ]; then
	cmake \
	-DCMAKE_INSTALL_PREFIX=/mmc \
	-DCMAKE_INSTALL_LIBDIR=lib \
	-DCMAKE_INSTALL_FULL_LIBDIR=/mmc/lib \
	.
	touch .configured
fi

if [ ! -f .built ]; then
        $MAKE
        touch .built
fi

if [ ! -f .installed ]; then
        make install
        touch .installed
fi

########## ##################################################################
# LIBRRD # ##################################################################
########## ##################################################################

mkdir -p $SRC/librrd && cd $SRC/librrd

if [ ! -f .downloaded ]; then
	wget https://github.com/oetiker/rrdtool-1.x/releases/download/v1.8.0/rrdtool-1.8.0.tar.gz
	touch .downloaded
fi

if [ ! -f .extracted ]; then
	rm -rf rrdtool-1.8.0
	tar zxvf rrdtool-1.8.0.tar.gz
	touch .extracted
fi

cd rrdtool-1.8.0

if [ ! -f .configured ]; then
	./configure \
	--prefix=/mmc \
	--disable-tcl \
	--disable-perl \
	--disable-python \
	--enable-static \
	--disable-shared \
	--disable-nls \
	--disable-rrd_graph \
	--disable-docs
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install
	touch .installed
fi

############### #############################################################
# LIBEXECINFO # #############################################################
############### #############################################################

mkdir -p $SRC/libexecinfo && cd $SRC/libexecinfo

if [ ! -f .downloaded ]; then
        wget https://github.com/resslinux/libexecinfo/archive/refs/tags/v20180201.tar.gz
        touch .downloaded
fi

if [ ! -f .extracted ]; then
        rm -rf libexecinfo-20180201
        tar zxvf v20180201.tar.gz
        touch .extracted
fi

cd libexecinfo-20180201

if [ ! -f .built ]; then
	sed -i 's,s \/usr,sf \/mmc,g' Makefile
	CC=gcc \
	$MAKE \
	INCLUDEDIR=/mmc/include \
	LIBDIR=/mmc/lib \
	install

       touch .built
fi

############ ###############################################################
# TCMALLOC # ###############################################################
############ ###############################################################

#mkdir $SRC/tcmalloc && cd $SRC/tcmalloc
#wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.5/gperftools-2.5.tar.gz
#tar zxvf gperftools-2.5.tar.gz
#cd gperftools-2.5

#./configure \
#--prefix=/mmc \
#--enable-static

#$MAKE
#make install

############### #############################################################
# VOIPMONITOR # #############################################################
############### #############################################################

mkdir -p $SRC/voipmonitor && cd $SRC/voipmonitor

if [ ! -f .downloaded ]; then
        git clone https://github.com/voipmonitor/sniffer.git
        touch .downloaded
fi

cd sniffer

if [ ! -f .configured ]; then
	git checkout develop
	patch -p1 < /mmc/src/0001-MUSL.patch
	./configure \
	--prefix=/mmc \
	--with-mysql=/mmc
        touch .configured
fi

if [ ! -f .built ]; then
	LDFLAGS=" -s -static -fuse-ld=mold -Wl,--start-group -ldl -licuuc -licudata -lpthread -lpcap -lz -lvorbis -lvorbisenc -logg -lodbc -L/mmc/lib -lmysqlclient -lrt -lsnappy -lcurl -lssl -lcrypto -L/mmc/lib -ljson-c -lxml2 -lrrd -lgcrypt -lgnutls  -L/mmc/lib -lglib-2.0 -llzma -llzo2 -lpng -lfftw3 -lzstd -lgpg-error -lpcre2-8 -lfts -lexecinfo -lltdl -Wl,--end-group" \
	CXXFLAGS="-fpermissive" \
	make -j2
       touch .built
fi
