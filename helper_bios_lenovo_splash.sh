#!/bin/bash 

#Some small automation utility for preparing the usb drive. 


#Please read the WARNING before running this 

#You might need to run sudo mkdir /mnt/temp1.
cp bios-update.unmodified.img bios-update.modified.img
sudo mount -o loop,offset=16384 bios-update.modified.img /mnt/temp1
sudo cp LOGO.JPG /mnt/temp1/
sudo cp LOGO.JPG /mnt/temp1/FLASH/
sudo cp LOGO.JPG /mnt/temp1/FLASH/N23ET52W/
sudo umount /mnt/temp1

##### WARNING #####
#Check if your usb drive *is* actually /dev/sdb from `sudo fdisk -l`.
#and *if* it is then uncomment the following line (or run it manually).
#sudo dd if=bios-update.img of=/dev/sdb oflag=direct status=progress
