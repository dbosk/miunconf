# $Id$
.PHONY: update shell utils editors tex db web prog mdi ide l209

all: update shell utils editors tex db web prog mdi ide

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
		p7zip

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

meego:
	mkdir -p /var/install/meego
	cd /var/install/meego
	wget http://harmattan-dev.nokia.com/stable/harmattan/harmattan-sdk-setup.py
	chmod +x harmattan-sdk-setup.py
	./harmattan-sdk-setup.py admininstall

mdi: meego tex

prog: editors
	apt-get install \
		git \
		subversion \
		cvs \
		ghc \
		swi-prolog \
		perl \
		idle-python3.2 \
		idle-python2.7

l209: all
