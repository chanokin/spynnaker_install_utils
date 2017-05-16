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
git clone -b $BRANCH https://github.com/SpiNNakerManchester/SpiNNUtils.git
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


