#!/bin/bash
set -e



echo sudo adduser bvr

#ssh -p 2222 bvr@localhost

# TODO: put these in rc file
export PREFIX=$HOME/usr
export SOURCES=$HOME/bv
export PATH=$PREFIX/bin:$PATH
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
echo We will install all the supporting software in $PREFIX 
echo While the playground will be in $SOURCES

echo create a new virtual env for python
virtualenv $PREFIX

echo Activate virtual env
$PREFIX/bin/activate
echo Installing nose (unit test) in this virtual env
$PREFIX/bin/easy_install nose

cd ~
mkdir -p .ssh
echo temporary
escondido=131.215.42.196
scp andrea@${escondido}:.ssh/github  ~/.ssh/
echo "IdentityFile ~/.ssh/github" >> ~/.ssh/config
git config --global user.name "Andrea Censi"
git config --global user.email andrea@cds.caltech.edu

cd ~
rm -rf bv
mkdir bv

echo Install compmake from repository
cd $SOURCES
git clone git@github.com:AndreaCensi/compmake.git
cd $SOURCES/compmake
sudo python setup.py develop

echo Install JSON-C from github
cd $SOURCES
git clone git@github.com:AndreaCensi/json-c.git
cd $SOURCES/json-c
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX .
make
make install

echo Checkout the bvr sources
cd $SOURCES
svn co https://www.cds.caltech.edu/subversion/andrea/pri/bv/

echo Install the raytracer program (written in C++ for performance)
cd $SOURCES/bv/src/raytracer
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX .
make 
make install

echo Some utilities in python
cd $SOURCES/bv/src/jsonstream
python setup.py develop

cd $SOURCES/bv/src
python setup.py develop

echo run unit tests to check everything is ok
cd $SOURCES/bv/src
nosetests

cd $SOURCES/bv/src
compmake pybv_experiments.first_order.go_parallel make



