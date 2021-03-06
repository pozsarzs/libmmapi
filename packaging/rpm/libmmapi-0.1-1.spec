Group: System/Libraries
License: EUPL
Name: libmmapi
Packager: Pozsar Zsolt <pozsar.zsolt@szerafingomba.hu>
Release: 1
Summary: API for MMxD device
Url: http://www.szerafingomba.hu/softwares/
Vendor: Pozsar Zsolt
Version: 0.1

%description
It is an API library for MMxD Raspberry Pi based growing
house controlling and remote monitoring device. You can
write own handler application with this library easily.

%files
/usr/share/doc/libmmapi/VERSION
/usr/share/doc/libmmapi/README
/usr/share/doc/libmmapi/AUTHORS
/usr/share/doc/libmmapi/COPYING
/usr/share/man/man3/libmmapi.3.gz
/usr/share/man/hu/man3/libmmapi.3.gz
/usr/lib/libmmapi.so
/usr/lib/libmmapi.so.0
/usr/lib/libmmapi.so.0.1.0

%post
ldconfig
