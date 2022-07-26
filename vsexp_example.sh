#/bin/bash

#echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/kml/lib:/usr/local/kml/lib/kvml/single:$LD_LIBRARY_PATH

gcc -I/usr/local/kml/include vsexp_example.c -o vsexp_example.exe -L/usr/local/kml/lib -L/usr/local/kml/lib/kvml/single -lkvml -lkm -lm

./vsexp_example.exe
