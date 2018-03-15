#!/bin/bash

sudo apt install -y subversion
sudo apt install -y gfortran
sudo apt install -y doxygen
sudo apt install -y cxxtest
sudo apt install -y git
sudo apt install -y build-essential
sudo apt install -y cmake

cd /usr/opt/
mkdir ipopt
cd ipopt
svn co https://projects.coin-or.org/svn/Bonmin/stable/1.8 Bonmin-stable

cd Bonmin-stable
cd ThirdParty/ASL
./get.ASL
cd ../Blas
./get.Blas
cd ../Lapack
./get.Lapack
cd ../Mumps
./get.Mumps

cd ..
cd ..

mkdir build
cd build
../configure -C
make
make test
make install
cd ~
echo "export BONMIN_LIB=/etc/opt/ipopt/Bonmin-stable/build/lib" >> .bashrc
source .bashrc
sudo cp ../BONMIN_LIB/* /usr/lib
sudo ldconfig

git clone https://github.com/stanle/madopt.git
cd madopt
mkdir build
cd build
cmake -DCUSTOM_LIBRARY=$BONMIN_LIB -DCUSTOM_INCLUDE=$BONMIN_INCLUDE ..
make
sudo make install
cd ~
echo "export MADOPT_LIB=/etc/opt/ipopt/madopt/build" >> .bashrc
echo "export MADOPT_INCLUDE=/etc/opt/ipopt/madopt/src" >> .bashrc
source .bashrc
