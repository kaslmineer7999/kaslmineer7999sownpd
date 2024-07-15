#!/data/data/com.termux/files/usr/bin/bash
clear
echo "+==============================================+"
echo "kaslmineer7999's own proot-distro"
echo "this script has nothing to do with proot-distro"
echo "+==============================================+"
sleep 4.3
clear
echo "
* debian (bookworm)
alias : debian
* ubuntu (24.04)
alias : ubuntu
* alpine linux
alias alpine
"
echo -e "what distro to install : \c\c"
read distroin
if [[ $distroin == "debian" ]] || [[ $distroin == "ubuntu" ]] || [[ $distroin == "alpine" ]]
then
echo "downloading the linux distro tarball"
mkdir -p $HOME/distro_dl_cache
cd $HOME/distro_dl_cache
curl http://localhost:8000/$distroin.tar.xz --output $distroin.tar.xz
echo "extracting the linux distro tarball"
cd ..
mkdir distro_data
cd distro_data
mkdir $distroin
tar -xvf ~/distro_dl_cache/$distroin.tar.xz -C ./$distroin/
touch $PREFIX/bin/$distroin
touch $PREFIX/bin/del$distroin
distrolock="$(cd ~/distro_data/$distroin/ ;echo *)"
echo "proot -0 -r /data/data/com.termux/files/home/distro_data/$distroin/$distrolock /bin/sh -c 'export HOME=/root ;export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin ;/bin/bash || /bin/sh'" > $PREFIX/bin/$distroin
chmod +rwx $PREFIX/bin/$distroin
echo -e "rm -rvf $HOME/distro_data/$distroin\nrm -rvf $PREFIX/bin/$distroin\nrm -rvf $PREFIX/bin/del$distroin" > $PREFIX/bin/del$distroin
chmod +rwx $PREFIX/bin/del$distroin
ifLD="$(cat $HOME/.bashrc | grep 'unset LD_PRELOAD')"
if [[ $ifLD == "unset LD_PRELOAD" ]]
then
echo "yay it's finshed to run it type '$distroin' to start it and to remove it type 'del$distroin'"
else
echo "unset LD_PRELOAD" >> $HOME/.bashrc
unset LD_PRELOAD
echo "yay it's finshed to run it type '$distroin' to start it and to remove it type 'del$distroin'"
fi
else
echo "fuck you, maybe you have god damn typo or the fucking distro is not in here"
false
fi
