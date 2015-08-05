FROM opensuse:13.2

MAINTAINER Daniel Molkentin <danimo@owncloud.com>

ENV TERM ansi
ENV HOME /root

ENV REFRESHED_AT 20150805

RUN zypper --non-interactive --gpg-auto-import-keys refresh
RUN zypper --non-interactive --gpg-auto-import-keys ar http://download.opensuse.org/repositories/windows:/mingw/openSUSE_13.2/windows:mingw.repo
RUN zypper --non-interactive --gpg-auto-import-keys ar http://download.opensuse.org/repositories/isv:ownCloud:toolchains:mingw:win32:stable/openSUSE_13.2/isv:ownCloud:toolchains:mingw:win32:stable.repo
RUN zypper --non-interactive --gpg-auto-import-keys install cmake make mingw32-cross-binutils mingw32-cross-cpp mingw32-cross-gcc \
	              mingw32-cross-gcc-c++ mingw32-cross-pkg-config mingw32-filesystem \
        	      mingw32-headers mingw32-runtime site-config mingw32-libwebp \ 
	              mingw32-cross-libqt5-qmake mingw32-cross-libqt5-qttools mingw32-libqt5* \
		      mingw32-qt5keychain* mingw32-angleproject* \
		      mingw32-cross-nsis mingw32-libopenssl* \
		      mingw32-sqlite* kdewin-png2ico \
		      osslsigncode wget

# RPM depends on curl for installs from HTTP
RUN zypper --non-interactive --gpg-auto-import-keys install curl

RUN rpm -ivh http://download.tomahawk-player.org/packman/mingw:32/openSUSE_12.1/x86_64/mingw32-cross-nsis-plugin-processes-0-1.1.x86_64.rpm
RUN rpm -ivh http://download.tomahawk-player.org/packman/mingw:32/openSUSE_12.1/x86_64/mingw32-cross-nsis-plugin-uac-0-3.1.x86_64.rpm

CMD /bin/bash

