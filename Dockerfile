FROM opensuse:13.2

MAINTAINER Daniel Molkentin <danimo@owncloud.com>

ENV TERM ansi
ENV HOME /root

ENV REFRESHED_AT 12062015

RUN zypper --non-interactive --gpg-auto-import-keys refresh
RUN zypper --non-interactive --gpg-auto-import-keys ar http://download.opensuse.org/repositories/windows:/mingw/openSUSE_13.2/windows:mingw.repo
RUN zypper --non-interactive --gpg-auto-import-keys ar http://download.opensuse.org/repositories/windows:/mingw:/win32/openSUSE_13.2/windows:mingw:win32.repo
RUN zypper --non-interactive --gpg-auto-import-keys install cmake make mingw32-cross-binutils mingw32-cross-cpp mingw32-cross-gcc \
	              mingw32-cross-gcc-c++ mingw32-cross-pkg-config mingw32-filesystem \
        	      mingw32-headers mingw32-runtime site-config \ 
	              mingw32-cross-libqt5-qmake mingw32-cross-libqt5-qttools mingw32-libqt5* \
		      mingw32-qt5keychain* mingw32-angleproject* \
		      mingw32-cross-nsis mingw32-libopenssl* \
		      mingw32-sqlite* kdewin-png2ico \
		      osslsigncode wget

# RPM depends on curl for installs from HTTP
RUN zypper --non-interactive --gpg-auto-import-keys install curl

RUN rpm -ivh http://download.tomahawk-player.org/packman/mingw:32/openSUSE_12.1/x86_64/mingw32-cross-nsis-plugin-processes-0-1.1.x86_64.rpm
RUN rpm -ivh http://download.tomahawk-player.org/packman/mingw:32/openSUSE_12.1/x86_64/mingw32-cross-nsis-plugin-uac-0-3.1.x86_64.rpm

# Work around compiler-related crash bug by deploying older binaries.
ADD https://download.owncloud.com/desktop/stable/build_artifacts/Qt5WebKit.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/
ADD https://download.owncloud.com/desktop/stable/build_artifacts/Qt5WebKitWidgets.dll /usr/i686-w64-mingw32/sys-root/mingw/bin/
RUN chmod 644 /usr/i686-w64-mingw32/sys-root/mingw/bin/Qt5WebKit*.dll

CMD /bin/bash

