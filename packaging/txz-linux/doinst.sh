( cd usr/lib ; rm -rf libmmapi.so )
( cd usr/lib ; ln -sf libmmapi.so.0.1.0 libmmapi.so )
( cd usr/lib ; rm -rf libmmapi.so.0 )
( cd usr/lib ; ln -sf libmmapi.so.0.1.0 libmmapi.so.0 )
