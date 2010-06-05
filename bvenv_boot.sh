#!/bin/bash

echo I am assuming you installed all the required software.

config=environment.sh

echo "#!/bin/bash" > ${config}
echo "# load this using   source ${config}" >> ${config}
echo export BVENV_ROOT=`pwd` >>${config}
echo export BVENV_PREFIX=\${BVENV_ROOT}/deploy >>${config}
echo export BVENV_SRC=\${BVENV_ROOT}/src >>${config}
echo export PATH=\${BVENV_PREFIX}/bin:\$PATH >>${config}
echo export PKG_CONFIG_PATH=\${BVENV_PREFIX}/lib/pkgconfig >>${config}

cat ${config}

mkdir -p ${BVENV_SRC}

echo Activating environment
source ${config}

echo Create a new virtual env for python
virtualenv ${BVENV_PREFIX}

echo Activate virtual env
${BVENV_PREFIX}/bin/activate
echo Installing nose in this virtual env
${BVENV_PREFIX}/bin/easy_install nose


echo Checkout the sources
cd ${BVENV_SRC}
svn co https://www.cds.caltech.edu/subversion/andrea/snp/snp-log
svn co https://www.cds.caltech.edu/subversion/andrea/snp/snp_geometry
svn co https://www.cds.caltech.edu/subversion/andrea/snp/albert-sp10


cd ${BVENV_SRC}/snp_geometry && python setup.py develop
cd ${BVENV_SRC}/snp-log && python setup.py develop

cd ${BVENV_SRC}/albert-sp10/camera_utils && python setup.py develop






