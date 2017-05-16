#!/bin/bash
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

cd ../SpiNNUtils
python setup.py develop --no-deps

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
#echo -e "\nexport PATH=$PATH:$SPINN_DIRS/tools" >> activate


