#!/usr/bin/bash

source virtualenv/bin/activate

python add_izk_stdp.py

cd ./spinnaker_tools
source ./setup

cd ../sPyNNaker/neural_modelling
make 

