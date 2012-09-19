# $Id$

CATEGORY=		conf
PUB_FILES=		Makefile

ANDROID?=		/usr/local/android
ANDROID_SDK?=	${ANDROID}/sdk
ANDROID_NDK?=	${ANDROID}/ndk

APTGET?=		apt-get -y
INSTALLFILES?=	/var/install

.PHONY: update shell utils editors tex db web prog mdi ide java version android

all: update shell utils editors tex db web prog mdi ide java version android

update:
	${APTGET} update
	${APTGET} upgrade

shell:
	${APTGET} install \
		pdksh \
		gnome \
		kde-standard \
		xfce4 \
		xfce4-goodies

build:
	wget -O ${INSTALLFILES}/build.tar.gz \
		http://ver.miun.se/build/build-all.tar.gz
	mkdir -p ${INSTALLFILES}/build
	tar -zxf ${INSTALLFILES}/build.tar.gz -C ${INSTALLFILES}/build
	${MAKE} -C ${INSTALLFILES}/build/build-all install

utils:
	${APTGET} install \
		unrar \
		p7zip \
		bzip2

editors:
	${APTGET} install \
		vim \
		emacs

ide:
	${APTGET} install \
		netbeans \
		eclipse \
	#	kdevelop

tex:
	${APTGET} install \
		texlive-full
	wget -O ${INSTALLFILES}/tex.tar.gz \
		http://ver.miun.se/latex/packages-all.tar.gz
	mkdir -p ${INSTALLFILES}/tex
	tar -zxf ${INSTALLFILES}/tex.tar.gz -C ${INSTALLFILES}/tex
	${MAKE} -C ${INSTALLFILES}/tex/packages-all install

db:
	${APTGET} install \
		mysql \
		postgresql

web: db
	${APTGET} install \
		apache2 \
		php5 \
		pear

${INSTALLFILES}/meego/harmattan-sdk-setup.py::
	mkdir -p ${INSTALLFILES}/meego
	cd ${INSTALLFILES}/meego
	wget -O ${INSTALLFILES}/meego/harmattan-sdk-setup.py \
		http://harmattan-dev.nokia.com/stable/harmattan/harmattan-sdk-setup.py
	chmod +x ${INSTALLFILES}/meego/harmattan-sdk-setup.py

meego: ${INSTALLFILES}/meego/harmattan-sdk-setup.py
	${INSTALLFILES}/meego/harmattan-sdk-setup.py admininstall

${INSTALLFILES}/android/android-sdk.tgz: \
	${INSTALLFILES}/android/android-sdk-r20.tgz
	ln -sf ${^} ${@}

${INSTALLFILES}/android/android-sdk-r20.tgz:
	mkdir -p ${INSTALLFILES}/android
	wget -O ${@} \
		http://dl.google.com/android/android-sdk_r20.0.3-linux.tgz

${INSTALLFILES}/android/android-ndk.tar.bz2: \
	${INSTALLFILES}/android/android-ndk-r8b.tar.bz2
	ln -sf ${^} ${@}

${INSTALLFILES}/android/android-ndk-r8b.tar.bz2:
	mkdir -p ${INSTALLFILES}/android
	cd ${INSTALLFILES}/android
	wget -O ${@} \
		http://dl.google.com/android/ndk/android-ndk-r8b-linux-x86.tar.bz2

${ANDROID_SDK}: ${INSTALLFILES}/android/android-sdk.tgz
	mkdir -p ${ANDROID_SDK}
	tar -xzf ${INSTALLFILES}/android/android-sdk.tgz -C ${ANDROID_SDK}
	if ! grep "^ANDROID_SDK=" /etc/profile; then \
		echo "ANDROID_SDK=${ANDROID_SDK}" >> /etc/profile; \
		echo "export ANDROID_SDK PATH=\$${PATH}:\$${ANDROID_SDK}" \
			>> /etc/profile; \
	fi

${ANDROID_NDK}: ${INSTALLFILES}/android/android-ndk.tar.bz2
	mkdir -p ${ANDROID_NDK}
	tar -xjf ${INSTALLFILES}/android/android-ndk.tar.bz2 -C ${ANDROID_NDK}
	if ! grep "^ANDROID_NDK=" /etc/profile; then \
		echo "ANDROID_NDK=${ANDROID_NDK}" >> /etc/profile; \
		echo "export ANDROID_NDK PATH=\$${PATH}:\$${ANDROID_NDK}" \
			>> /etc/profile; \
	fi

android: java ${ANDROID_SDK} ${ANDROID_NDK}
	if ! grep "^ANDROID=" /etc/profile; then \
		echo "export ANDROID=${ANDROID}" >> /etc/profile; \
	fi
	# XXX add conditional for x64 or x86
	${APTGET} install \
		abootimg \
		ia32-libs

mdi: meego android tex

version:
	${APTGET} install \
		git \
		subversion \
		cvs \
		mercurial

prog: editors java version mono
	${APTGET} install \
		ghc \
		swi-prolog \
		perl \
		python \
		python3

java:
	${APTGET} install \
		openjdk-7-jre \
		openjdk-7-jdk \
		openjdk-7-doc \
		openjdk-6-jre \
		openjdk-6-jdk \
		openjdk-6-doc \
		sun-java6-jdk \
		ant ant-doc

mono:
	${APTGET} install \
		mono-runtime \
		monodoc-browser \
		mono-dbg \
		mono-utils \
		mono-runtime-dbg \
		mono-devel \
		mono-dmcs \
		mono-mcs \
		mono-tools-devel

l209: all


miun.pub.mk: build
miun.package.mk: build

include miun.pub.mk
include miun.package.mk
