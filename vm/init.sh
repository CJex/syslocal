#!/bin/bash
BASHRC=/etc/bash.bashrc;
PROFILE=/etc/profile;
WKSPACE=/workspace;
MY_PATH='/opt/nodejs/bin:/workspace/syslocal/bin';
cd /tmp;


if [ ! -e /etc/apt/sources.list.bak ];then
  mv /etc/apt/sources.list  /etc/apt/sources.list.bak;
fi;

echo "
# China Mirrors

deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse

deb http://ftp.sjtu.edu.cn/ubuntu/ trusty main multiverse restricted universe
deb http://ftp.sjtu.edu.cn/ubuntu/ trusty-backports main multiverse restricted universe
deb http://ftp.sjtu.edu.cn/ubuntu/ trusty-proposed main multiverse restricted universe
deb http://ftp.sjtu.edu.cn/ubuntu/ trusty-security main multiverse restricted universe
deb http://ftp.sjtu.edu.cn/ubuntu/ trusty-updates main multiverse restricted universe
deb-src http://ftp.sjtu.edu.cn/ubuntu/ trusty main multiverse restricted universe
deb-src http://ftp.sjtu.edu.cn/ubuntu/ trusty-backports main multiverse restricted universe
deb-src http://ftp.sjtu.edu.cn/ubuntu/ trusty-proposed main multiverse restricted universe
deb-src http://ftp.sjtu.edu.cn/ubuntu/ trusty-security main multiverse restricted universe
deb-src http://ftp.sjtu.edu.cn/ubuntu/ trusty-updates main multiverse restricted universe

" > /etc/apt/sources.list;

apt-key update
apt-get update
apt-get install -y "linux-headers-$(uname -r)" build-essential vim vim-common vim-scripts vim-runtime git docker.io haskell-platform scala scala-library nginx-full openjdk-7-jdk openjdk-7-jre realpath screen dos2unix gcc chicken-bin ocaml-nox ocaml-native-compilers g++-4.8 llvm-3.6 clang-3.6  racket racket-common scala scala-library


# wget 'http://downloads.typesafe.com/scala/2.12.0-M3/scala-2.12.0-M3.deb' -O scala.deb
# dpkg -i  scala.deb
# apt-get install -f

if [ ! -e /opt/nodejs ]; then
  wget -c 'https://nodejs.org/dist/v5.5.0/node-v5.5.0-linux-x64.tar.xz' -O nodejs.tar.xz
  tar -xf nodejs.tar.xz
  mv node-v5.5.0-linux-x64 /opt/nodejs
fi;


if [ ! -e /etc/vim/colors ]; then
  git clone https://github.com/flazz/vim-colorschemes.git
  cd vim-colorschemes
  mv colors /etc/vim/colors
fi;



apt-get install -y python-pip python-virtualenv virtualenvwrapper

if ! which rvm; then
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable
fi;


ln -sf $WKSPACE/syslocal/etc/git/config /etc/gitconfig;
ln -sf $WKSPACE/syslocal/etc/vim/vimrc.local /etc/vim/vimrc.local;




echo "

export PATH=\"$MY_PATH:\$PATH\";

source $WKSPACE/syslocal/etc/bashrc;

" >> $BASHRC;

echo "

source $WKSPACE/syslocal/etc/profile;

" >> $PROFILE




apt-get autoremove -y
