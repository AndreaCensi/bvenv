#!/bin/bash
set -e
echo "I am assuming you installed all the required software. (press enter)"
read
config=environment.sh

echo \#\!/bin/bash > ${config}
echo "# load this using   source ${config}" >> ${config}
echo export BVENV_ROOT=`pwd` >>${config}
echo export BVENV_PREFIX=\${BVENV_ROOT}/deploy >>${config}
echo export BVENV_SRC=\${BVENV_ROOT}/src >>${config}
echo export BVENV_DATA=\${BVENV_ROOT}/data >>${config}
echo export BVENV_OUT=\${BVENV_ROOT}/results >>${config}
echo export PATH=\${BVENV_PREFIX}/bin:\$PATH >>${config}
echo export PKG_CONFIG_PATH=\${BVENV_PREFIX}/lib/pkgconfig >>${config}

source ${config}
cat ${config}

echo "Now creating virtual environment (press enter)"
read
echo Create a new virtual env for python
virtualenv ${BVENV_PREFIX}
echo source ${BVENV_PREFIX}/bin/activate >> ${config}
source ${config}


mkdir -p ${BVENV_SRC}


echo Installing nose in this virtual env
${BVENV_PREFIX}/bin/easy_install nose


echo "The next steps can be done with patience. (./patience resources.yaml checkout)"
read


echo Checkout the sources
cd ${BVENV_SRC} && svn co https://www.cds.caltech.edu/subversion/andrea/snp/camera-bootstrap
cd ${BVENV_SRC} && svn co https://www.cds.caltech.edu/subversion/andrea/snp/snp-log
cd ${BVENV_SRC} && svn co https://www.cds.caltech.edu/subversion/andrea/snp/snp_geometry
cd ${BVENV_SRC} && svn co https://www.cds.caltech.edu/subversion/andrea/snp/albert-sp10
cd ${BVENV_SRC} && git clone git@github.com:AndreaCensi/compmake.git
cd ${BVENV_SRC} && git clone git@github.com:AndreaCensi/json-c.git
cd ${BVENV_SRC} && svn co https://www.cds.caltech.edu/subversion/andrea/pri/bv/src bv
cd ${BVENV_SRC} && git clone git@github.com:AndreaCensi/reprep.git


cd ${BVENV_SRC}          && svn up snp-log
cd ${BVENV_SRC}          && svn up snp_geometry
cd ${BVENV_SRC}          && svn up camera-bootstrap
cd ${BVENV_SRC}          && svn up albert-sp10
cd ${BVENV_SRC}/compmake && git pull
cd ${BVENV_SRC}/json-c   && git pull
cd ${BVENV_SRC}/reprep   && git pull
cd ${BVENV_SRC}          && svn up bv


cd ${BVENV_SRC}          && svn commit snp-log
cd ${BVENV_SRC}          && svn commit snp_geometry
cd ${BVENV_SRC}          && svn commit camera-bootstrap
cd ${BVENV_SRC}          && svn commit albert-sp10
cd ${BVENV_SRC}/compmake && git commit -a
cd ${BVENV_SRC}/json-c   && git commit -a
cd ${BVENV_SRC}          && svn commit bv

cd ${BVENV_SRC}/snp_geometry             && python setup.py develop
cd ${BVENV_SRC}/snp-log                  && python setup.py develop
cd ${BVENV_SRC}/albert-sp10/camera_utils && python setup.py develop
cd ${BVENV_SRC}/compmake                 && python setup.py develop
cd ${BVENV_SRC}/camera-bootstrap         && python setup.py develop
cd ${BVENV_SRC}/reprep                   && python setup.py develop

cd ${BVENV_SRC}/json-c        && cmake -DCMAKE_INSTALL_PREFIX=${BVENV_PREFIX} . && make install
cd ${BVENV_SRC}/bv/raytracer  && cmake -DCMAKE_INSTALL_PREFIX=${BVENV_PREFIX} . && make install
cd ${BVENV_SRC}/bv/jsonstream && python setup.py develop
cd ${BVENV_SRC}/bv            && python setup.py develop

cd ${BVENV_SRC}/bv            && nosetests
cd ${BVENV_SRC}/compmake            && nosetests


mkdir -p ${BVENV_DATA}

tokyo=131.215.42.218
#cd ${BVENV_DATA} && rsync --progress -a -v andrea@tokyo:BIGDATA/er1-logs .
cd ${BVENV_DATA} && rsync --progress -a -v andrea@131.215.42.218:BIGDATA/er1-logs .

