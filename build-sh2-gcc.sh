#!/bin/bash

# This script builds the SH2 GCC cross-compiler toolchain.
git clone https://github.com/kentosama/sh2-elf-gcc.git
cd sh2-elf-gcc

# Build the toolchain
./build-toolchain.sh

sudo cp -R sh2-toolchain /opt
echo export PATH="${PATH}:/opt/sh2-toolchain/bin" >> ~/.bashrc
source ~/.bashrc

# Clean up
cd ..
rm -rf sh2-elf-gcc

# Done
sh2-elf-gcc -v