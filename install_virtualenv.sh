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
git clone -b $BRANCH https://github.com/SpiNNakerManchester/ybug

# Clone sPyNNaker and requirements
git clone -b $BRANCH https://github.com/SpiNNakerManchester/DataSpecification.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNMachine
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNMan.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/PACMAN
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNFrontEndCommon.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/sPyNNaker.git

# Clone extra modules
git clone -b $BRANCH https://github.com/SpiNNakerManchester/sPyNNakerExtraModelsPlugin.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/sPyNNakerExternalDevicesPlugin.git
git clone -b $BRANCH https://github.com/SpiNNakerManchester/PyNNExamples.git

#---------------------------------------
# Setup virtualenv
#---------------------------------------
# Create virtualenv
virtualenv virtualenv --system-site-packages

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

cd ../sPyNNaker
python setup.py develop --no-deps

cd ../sPyNNakerExternalDevicesPlugin
python setup.py develop --no-deps

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
NEURAL_MODELLING_DIRS=$PWD

cd ../../virtualenv/bin
echo "export NEURAL_MODELLING_DIRS=$NEURAL_MODELLING_DIRS" >> activate


