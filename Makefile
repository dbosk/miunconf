# $Id$

ANDROID_SDK=	/usr/local/androidsdk
ANDROID_NDK=	/usr/local/androidndk

.PHONY: update shell utils editors tex db web prog mdi ide l209 android

all: update shell utils editors tex db web prog mdi ide java version android

update:
	apt-get update
	apt-get upgrade

shell:
	apt-get install \
		pdksh \
		gnome \
		kde-standard

utils:
	apt-get install \
		unrar \
		p7zip \
		bzip2

editors:
	apt-get install \
		vim

ide:
	apt-get install \
		netbeans \
		eclipse \
		kdevelop

tex:
	apt-get install \
		texlive-full

db:
	apt-get install \
		mysql \
		postgresql

web: db
	apt-get install \
		apache2 \
		php5 \
		pear

/var/install/meego/harmattan-sdk-setup.py:
	mkdir -p /var/install/meego
	cd /var/install/meego
	wget http://harmattan-dev.nokia.com/stable/harmattan/harmattan-sdk-setup.py
	chmod +x harmattan-sdk-setup.py

meego: /var/install/meego/harmattan-sdk-setup.py
	/var/install/meego/harmattan-sdk-setup.py admininstall

/var/install/android/android-sdk.tgz:
	mkdir -p /var/install/android
	cd /var/install/android
	wget http://dl.google.com/android/android-sdk_r20.0.3-linux.tgz
	ln -sf android-sdk_r20.0.3-linux.tgz android-sdk.tgz

/var/install/android/android-ndk.tar.bz2:
	mkdir -p /var/install/android
	cd /var/install/android
	wget http://dl.google.com/android/ndk/android-ndk-r8b-linux-x86.tar.bz2
	ln -sf android-ndk-r8b-linux-x86.tar.bz2 android-ndk.tar.bz2

android: java \
	/var/install/android/android-sdk.tgz \
	/var/install/android/android-ndk.tar.bz2
	# XXX add conditional for x64 or x86
	apt-get install \
		abootimg \
		ia32-libs
	# XXX fix android install

mdi: meego tex

version:
	apt-get install \
		git \
		subversion \
		cvs \
		mercurial

prog: editors java version
	apt-get install \
		ghc \
		swi-prolog \
		perl \
		idle-python3.2 \
		idle-python2.7

java:
	apt-get install \
		openjdk-7-jre \
		openjdk-7-jdk \
		openjdk-7-doc \
		openjdk-6-jre \
		openjdk-6-jdk \
		openjdk-6-doc \
		sun-java6-jdk

l209: all
