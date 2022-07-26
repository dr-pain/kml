#/bin/bash

#echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/kml/lib:/usr/local/kml/lib/kvml/single:$LD_LIBRARY_PATH

gfortran -I/usr/local/kml/include vsexp_example.f -o vsexp_examplef.exe -L/usr/local/kml/lib -L/usr/local/kml/lib/kvml/single -lkvml -lkm -lm

./vsexp_examplef.exe
