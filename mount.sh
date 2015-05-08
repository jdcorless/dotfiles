#!/bin/bash
# mount.sh
# Execute from command line as $ sudo ./mount.sh

echo "    "
echo Mounting share folders.
echo "    "
cd ~
printf "Dropbox   ... "
mount -t vboxsf Dropbox ~/Dropbox  2> /dev/null
if [ $? -eq "0" ]; 
    then printf "Success\n"
fi

printf "Documents ... "
mount -t vboxsf Documents ~/Documents 2> /dev/null
if [ $? -eq "0" ]; 
    then printf "Success\n"
fi

printf "U:\Drive  ... "
mount -t vboxsf U_DRIVE ~/UDrive 2> /dev/null
if [ $? -eq "0" ]; 
    then printf "Success\n"
else
    printf "Failure\n"
fi

printf "V:\Drive  ... "
mount -t vboxsf V_DRIVE ~/VDrive 2> /dev/null
if [ $? -eq "0" ]; 
    then printf "Success\n"
else
    printf "Failure\n"
fi


echo "    "
echo "Finished"
echo "    "
