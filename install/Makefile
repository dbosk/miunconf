# $Id$
# Author: Daniel Bosk <daniel.bosk@miun.se>

CATEGORY=		conf
PUB_FILES=		Makefile

ANDROID?=				/usr/local/android
ANDROID_SDK?=			${ANDROID}/sdk
# this is the name of the directory in the tarball
ANDROID_SDK_NAME?=		android-sdk-linux
# this is the file on google's servers
ANDROID_SDK_FILE?=		android-sdk_r20.0.3-linux.tgz
ANDROID_NDK?=			${ANDROID}/ndk
ANDROID_NDK_NAME?=		android-ndk-r8b
ANDROID_NDK_FILE?=		android-ndk-r8b-linux-x86.tar.bz2

APTGET?=		apt-get -y
INSTALLFILES?=	/var/install

.PHONY: update shell utils editors \
	tex miuntex \
	db web prog mdi ide java version \
	android android-device-rules \
	mediakodning wireshark \
	build-essential

all: update shell utils editors miuntex \
	db web prog mdi ide java version android mediakodning

update: build miuntex ${ANDROID_SDK} ${ANDROID_NDK}
	${APTGET} update
	${APTGET} upgrade

shell:
	${APTGET} install \
		pdksh \
		gnome \
		kde-standard

build:
	wget -O ${INSTALLFILES}/build.tar.gz \
		http://ver.miun.se/build/build-all.tar.gz
	mkdir -p ${INSTALLFILES}/build
	tar -zxf ${INSTALLFILES}/build.tar.gz -C ${INSTALLFILES}/build
	${MAKE} PREFIX=/usr/local -C ${INSTALLFILES}/build/build-all install

utils:
	${APTGET} install \
		unrar \
		p7zip \
		bzip2

${INSTALLFILES}/vimrc:
	wget -O ${@} http://ver.miun.se/conf/vimrc

/usr/share/vim/vimrc: ${INSTALLFILES}/vimrc
	install -Dp ${^} ${@}

${INSTALLFILES}/papersize:
	wget -O ${@} http://ver.miun.se/conf/papersize

/etc/papersize: papersize
	install -Dp $^ $@

editors: /usr/share/vim/vimrc
	${APTGET} install \
		vim \
		emacs

ide:
	${APTGET} install \
		netbeans \
		eclipse \
	#	kdevelop

miuntex: tex
	wget -O ${INSTALLFILES}/miuntex.tar.gz \
		http://ver.miun.se/latex/packages-all.tar.gz
	mkdir -p ${INSTALLFILES}/miuntex
	tar -zxf ${INSTALLFILES}/miuntex.tar.gz -C ${INSTALLFILES}/miuntex
	${MAKE} PREFIX=/usr/local/share/texmf \
		-C ${INSTALLFILES}/miuntex/packages-all install
	-texhash

tex:
	${APTGET} install \
		texlive-full

build-essential:
	${APTGET} install \
		build-essential

db:
	${APTGET} install \
		mysql-server mysql-client \
		postgresql postgresql-client postgresql-common < /dev/null

web: db
	${APTGET} install \
		apache2 \
		php5 \
		php-pear php-auth php-mail \
		chromium-browser \
		firefox

${INSTALLFILES}/meego/harmattan-sdk-setup.py::
	mkdir -p ${INSTALLFILES}/meego
	cd ${INSTALLFILES}/meego
	wget -O ${INSTALLFILES}/meego/harmattan-sdk-setup.py \
		http://harmattan-dev.nokia.com/stable/harmattan/harmattan-sdk-setup.py
	chmod +x ${INSTALLFILES}/meego/harmattan-sdk-setup.py

#meego: ${INSTALLFILES}/meego/harmattan-sdk-setup.py
#	${INSTALLFILES}/meego/harmattan-sdk-setup.py admininstall

${INSTALLFILES}/android/${ANDROID_SDK_FILE}:
	mkdir -p ${INSTALLFILES}/android
	wget -O ${@} \
		http://dl.google.com/android/${ANDROID_SDK_FILE}

${INSTALLFILES}/android/${ANDROID_NDK_FILE}:
	mkdir -p ${INSTALLFILES}/android
	cd ${INSTALLFILES}/android
	wget -O ${@} \
		http://dl.google.com/android/ndk/${ANDROID_NDK_FILE}

${ANDROID_SDK}: ${INSTALLFILES}/android/${ANDROID_SDK_FILE}
	mkdir -p ${ANDROID}
	tar -xzf ${^} -C ${ANDROID}
	mv ${ANDROID}/${ANDROID_SDK_NAME} ${ANDROID_SDK}
	chown -R root:root ${ANDROID_SDK}
	chmod -R 0755 ${ANDROID_SDK}
	if ! grep "^ANDROID_SDK=" /etc/profile; then \
		echo "export ANDROID_SDK=${ANDROID_SDK}" >> /etc/profile; \
		echo "export PATH=\$${PATH}:\$${ANDROID_SDK}/tools" \
			>> /etc/profile; \
		echo "export PATH=\$${PATH}:\$${ANDROID_SDK}/platform-tools" \
			>> /etc/profile; \
	fi
	${ANDROID_SDK}/tools/android update sdk -u < /dev/null

${ANDROID_NDK}: ${INSTALLFILES}/android/${ANDROID_NDK_FILE}
	mkdir -p ${ANDROID}
	tar -xjf ${INSTALLFILES}/android/${ANDROID_NDK_FILE} -C ${ANDROID}
	mv ${ANDROID}/${ANDROID_NDK_NAME} ${ANDROID_NDK}
	chown -R root:root ${ANDROID_NDK}
	chmod -R 0755 ${ANDROID_NDK}
	if ! grep "^ANDROID_NDK=" /etc/profile; then \
		echo "export ANDROID_NDK=${ANDROID_NDK}" >> /etc/profile; \
		echo "export PATH=\$${PATH}:\$${ANDROID_NDK}" \
			>> /etc/profile; \
	fi

${INSTALLFILES}/android/51-android.rules:
	wget -O ${INSTALLFILES}/android http://ver.miun.se/conf/51-android.rules

android-device-rules: /etc/udev/rules.d/51-android.rules

/etc/udev/rules.d/51-android.rules:
	wget -O $@ http://ver.miun.se/conf/51-android.rules

android: java ${ANDROID_SDK} ${ANDROID_NDK} android-device-rules
	mkdir -p ${ANDROID}
	${ANDROID_SDK}/tools/android update sdk -u < /dev/null
	if ! grep "^ANDROID=" /etc/profile; then \
		echo "export ANDROID=${ANDROID}" >> /etc/profile; \
	fi
	# XXX add conditional for x64 or x86
	${APTGET} install \
		abootimg \
		ia32-libs

mdi: android tex

mediakodning: wireshark

wireshark:
	${APTGET} install \
		wireshark
	setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap

version:
	${APTGET} install \
		git \
		subversion \
		cvs \
		mercurial

prog: editors java version mono build-essential
	${APTGET} install \
		ghc \
		swi-prolog \
		perl \
		python \
		python3 \
		umbrello \
		dia

${INSTALLFILES}/java/sun-java6-jdk.bin:
	mkdir -p ${INSTALLFILES}/java
	wget -O $@ \
		http://ver.miun.se/conf/jdk-6u37-linux-x64.bin
	chmod +x $@

java: ${INSTALLFILES}/java/sun-java6-jdk.bin
	mkdir -p ${INSTALLFILES}/java
	${APTGET} install \
		openjdk-7-jre \
		openjdk-7-jdk \
		openjdk-7-doc \
		openjdk-6-jre \
		openjdk-6-jdk \
		openjdk-6-doc \
		ant ant-doc
	cd ${INSTALLFILES}/java && \
		${INSTALLFILES}/java/sun-java6-jdk.bin < /dev/null
	update-alternatives --config java < /dev/null | \
		sed -En '/java-6-sun/s/[* ]*([0-9]{1,}) *.*$$/\1/p' | \
		update-alternatives --config java

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


L209PC?=01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20

# XXX this code does not work yet
l209:
	for n in ${L209PC}; do \
		echo "${PASSWORD}" | ssh studadm@CSVL209PC$$n.student.miun.se \
			"sudo mkdir -p /var/install && sudo chown -R studadm /var/install" ; \
		scp Makefile studadm@CSVL209PC$$n.student.miun.se:/var/install
		echo "${PASSWORD}" | ssh studadm@CSVL209PC$$n.student.miun.se \
			"cd /var/install && make all" & \
	done


miun.pub.mk: build
miun.package.mk: build

include miun.pub.mk
