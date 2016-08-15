#!/bin/bash

src=$1;
dest=$2;


copy_single() {
    [ -d $dest ] || mkdir $dest
    [ -d $dest ] && mkdir -p $dest/$1
    #mkdir $dest; echo $?
    #mkdir $dest && echo success
    #mkdir $dest/$1
    unison $src/$1 $dest/$1 -batch -silent -dontchmod -perms 0 -force $src/$1
}


#copy_single .config/tox
copy_single .config/qBittorrent
#copy_single .eclipse
copy_single .local/share/Aspyr/
copy_single .minecraft
#copy_single .mozilla
#copy_single .PlayOnLinux
#copy_single .Skype
#copy_single .steam
#copy_single .unison
copy_single Desktop
#copy_single Desktop 4
copy_single Documents
copy_single Downloads
#copy_single eclipse 4.4.1
#copy_single git
#copy_single My Games
#copy_single Scripts
#copy_single Steam
#copy_single workspace
#copy_single .bash_history
copy_single .face.icon
copy_single .gitconfig
copy_single kthx.kdbx
copy_single n1.tar.gz.gpg
copy_single n2.tar.gz.gpg