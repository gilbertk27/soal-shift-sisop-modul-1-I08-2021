 #!/bin/bash

passw=`date +'%m%d%Y'`
zip -P $passw '/home/xyncz/Downloads/Koleksi.zip' . -x *.sh* *.log* *.tab*
#rm $(ls -I "*.zip" -I "*.sh" -I"*.tab")  

