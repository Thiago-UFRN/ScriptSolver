#!/bin/bash

sudo apt install -y subversion
sudo apt install -y gfortran
sudo apt install -y doxygen
sudo apt install -y cxxtest
sudo apt install -y git
sudo apt install -y build-essential
sudo apt install -y cmake

cd /etc/opt/
sudo mkdir ipopt
cd ipopt
sudo svn co https://projects.coin-or.org/svn/Bonmin/stable/1.8 Bonmin-stable

cd Bonmin-stable
cd ThirdParty/ASL
sudo ./get.ASL
cd ../Blas
sudo ./get.Blas
cd ../Lapack
sudo ./get.Lapack
cd ../Mumps
sudo ./get.Mumps

cd ..
cd ..

sudo mkdir build
cd build
sudo ../configure -C
sudo make
sudo make test
sudo make install
cd ~
export BONMIN_LIB=/etc/opt/ipopt/Bonmin-stable/build/lib
echo "export BONMIN_LIB=/etc/opt/ipopt/Bonmin-stable/build/lib" >> .bashrc
export BONMIN_INCLUDE=/etc/opt/ipopt/Bonmin-stable/build/include
echo "export BONMIN_INCLUDE=/etc/opt/ipopt/Bonmin-stable/build/include" >> .bashrc
source .bashrc
sudo cp $BONMIN_LIB/* /usr/lib
sudo ldconfig

cd /etc/opt/ipopt
sudo git clone https://github.com/stanle/madopt.git
cd madopt
sudo mkdir build
cd build
sudo cmake -DCUSTOM_LIBRARY=$BONMIN_LIB -DCUSTOM_INCLUDE=$BONMIN_INCLUDE ..
sudo make
sudo make install
cd ~
export MADOPT_LIB=/etc/opt/ipopt/madopt/build
echo "export MADOPT_LIB=/etc/opt/ipopt/madopt/build" >> .bashrc
export MADOPT_INCLUDE=/etc/opt/ipopt/madopt/src
echo "export MADOPT_INCLUDE=/etc/opt/ipopt/madopt/src" >> .bashrc
source .bashrc
