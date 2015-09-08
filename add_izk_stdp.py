#!/usr/bin/python
from __future__ import print_function

import os
import shutil

DEBUG = True
WRITE_OUT = True

new_models = ["IZK_curr_exp_stdp_pair_additive",
              "IZK_curr_exp_stdp_nearest_pair_additive",
              "IZK_curr_exp_stdp_mad_pair_additive",
              "IZK_curr_exp_stdp_mad_nearest_pair_additive",
             ]

base_dir = "sPyNNaker/neural_modelling/src/neuron/"

def add_models_to_makefile(models, makefile_base_dir):
  f = open(os.path.join(makefile_base_dir, "Makefile"), "r")

  shutil.copyfile(os.path.join(makefile_base_dir, "Makefile"),
                  os.path.join(makefile_base_dir, "Makefile_old"))
           
  lines = []
  for line in f:
    if line.startswith("MODELS"):
      lines.append(line)
      for model in new_models:
        padding = "         "
        lines.append(padding+model+" \\\n")
    else:
      lines.append(line)
  
  new_file_str = "".join(lines)
  if DEBUG:
    print(new_file_str)

  if WRITE_OUT:
    f = open(os.path.join(makefile_base_dir, "Makefile"), "w")
    f.write(new_file_str)
  
  f.close()
  

def add_build_directories(models, build_base_dir):
  
  for model in models:
    if DEBUG:
      print(model)
      print("----------------------------------------------------------")
      
    model_path = os.path.join(build_base_dir, model)
    if not os.path.exists(model_path): 
      IF_name = model.replace("IZK", "IF")
      f_base = open(os.path.join(build_base_dir, IF_name, "Makefile"), "r").read()
      if WRITE_OUT:
        os.makedirs(model_path)
        f = open(os.path.join(model_path, "Makefile"), "w+")
      
      new_file_str = f_base.replace("neuron_model_lif_curr_impl",
                                    "neuron_model_izh_curr_impl")
      
      if WRITE_OUT:
        f.write(new_file_str)

      if DEBUG:
        print(new_file_str)
        print("----------------------------------------------------------")
    

def main():
  add_models_to_makefile(new_models, base_dir)
  build_base_dir = os.path.join(base_dir, "builds")
  add_build_directories(new_models, build_base_dir)


if __name__ == "__main__":
  main()
