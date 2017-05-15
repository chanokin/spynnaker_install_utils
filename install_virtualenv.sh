#!/bin/bash
if [ $# -eq 0 ]
then
  BRANCH="master"
else
  BRANCH=$1
fi

#---------------------------------------
# Check modules out of git
#---------------------------------------
# Clone low-level tools
git clone -b $BRANCH https://github.com/SpiNNakerManchester/spinnaker_tools.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/spinn_common.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/ybug.git

# Clone sPyNNaker and requirements
git clone -b $BRANCH https://github.com/SpiNNakerManchester/DataSpecification.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNMachine.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNMan.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/PACMAN.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNFrontEndCommon.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/sPyNNaker.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNStorageHandlers.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNakerGraphFrontEnd.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNUtils.git

# Clone extra modules
git clone -b $BRANCH https://github.com/SpiNNakerManchester/sPyNNakerExtraModelsPlugin.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/sPyNNakerExternalDevicesPlugin.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/PyNNExamples.git


# Clone rig
git clone https://github.com/project-rig/rig
git clone https://github.com/project-rig/rig_c_sa

# Clone rig_cpp_common for connector builder
git clone https://github.com/project-rig/rig_cpp_common

#---------------------------------------
# Setup virtualenv
#---------------------------------------
# Create virtualenv
venv="/usr/bin/virtualenv2"
if [ ! -e "$venv" ]
then
    venv="/usr/bin/virtualenv"
fi

$venv virtualenv --system-site-packages


# Activate the virtualenv
cd virtualenv
. bin/activate

#---------------------------------------
# Install python modules
#---------------------------------------
# Install python modules
cd ../DataSpecification
python setup.py develop --no-deps

cd ../SpiNNMachine
python setup.py develop --no-deps

cd ../SpiNNMan
python setup.py develop --no-deps

cd ../PACMAN
python setup.py develop --no-deps

cd ../SpiNNFrontEndCommon
python setup.py develop --no-deps

cd ../SpiNNFrontEndCommon
python setup.py develop --no-deps

cd ../SpiNNStorageHandlers
python setup.py develop --no-deps

cd ../SpiNNakerGraphFrontEnd
python setup.py develop --no-deps

cd ../SpiNNUtils
python setup.py develop --no-deps

cd ../sPyNNaker
python setup.py develop --no-deps

cd ../sPyNNakerExternalDevicesPlugin
python setup.py develop --no-deps

cd ../sPyNNakerExtraModelsPlugin
python setup.py develop --no-deps

cd ../rig
python setup.py develop

cd ../rig_c_sa
python setup.py develop

cd ../rig_cpp_common 
python setup.py develop 

#---------------------------------------
# Build C
#---------------------------------------
# Source spinnaker tools
cd ../spinnaker_tools
source ./setup
make

# Make spinn_common
cd ../spinn_common
make
make install

cd ../SpiNNFrontEndCommon/c_common
make

cd ../../sPyNNaker/neural_modelling
make

cd ../../SpiNNMan/c_models/
make

cd ../../sPyNNaker/neural_modelling/
NEURAL_MODELLING_DIRS=`pwd`

cd ../../spinnaker_tools
SPINN_DIRS=`pwd`

pip install spalloc 

cd ../virtualenv/bin
echo -e "\nexport NEURAL_MODELLING_DIRS=$NEURAL_MODELLING_DIRS" >> activate
echo -e "\nexport SPINN_DIRS=$SPINN_DIRS" >> activate
echo -e "\nexport SPINN_VERSION=131" >> activate




