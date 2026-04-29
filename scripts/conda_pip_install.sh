#!/bin/bash
#
# reproducible script to install gmx_MMPBSA on Ubuntu 24.04.3 LTS
# might also work on some other Linux distributions

ENV=gmx_MMPBSA

# conda env and python
conda create -n $ENV "python=3.11.8" -y -q
conda activate $ENV

set -u
#set -x

# packages which are not available through pip
# (too bad, or we could get rid of conda-the-dumb-and-slow)
conda install -c conda-forge "ambertools=23.3" -y -q
conda install -c conda-forge "gromacs=2023.4" pocl -y -q

# pip for all other dependencies
pip install "matplotlib>=3" \
            "mpi4py>=4"     \
            "numpy>=2"      \
            "pandas>=2"     \
            "pyqt6>=6.7"    \
            "scipy>=1.14"   \
            "seaborn>=0.13" \
            gmx_MMPBSA

# very important: test that everything works
time gmx_MMPBSA_test -f tests -n 10
