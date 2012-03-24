##!/bin/bash
. $SCRIPTS_DIR/WRF.env
. $SCRIPTS_DIR/WPS.env

export NETCDF=${NETCDF4_ROOT}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_ROOT}/lib
export JASPERINC=${JASPER_ROOT}/include

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf ${APP}.${EXT}
    mv ${DIR} $WPS_ROOT
fi

cd $WPS_ROOT

./clean -a # clean first
./configure  < $SCRIPTS_DIR/build/configure.wps.${COMP}.select
$SCRIPTS_DIR/build/configure.wps.hdf5.sh
$SCRIPTS_DIR/build/configure.wps.jasper.sh

# read dummy                      # manual inspection

./compile  2>&1 | tee log.${COMP}.compile
