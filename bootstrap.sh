#!/usr/bin/env bash

# Commands and other details taken from
# https://github.com/jsmess/jsmess/wiki/How-to-build-and-test-JSMESS-0.153

# Configurable constants
export MESS_TEST_PLATFORM=coleco
export MESS_TEST_GAME_FILE=smurfs.rom
export MESS_GAME_DIR=/vagrant/games
export MESS_BIOS_DIR=/vagrant/bios

# Preliminaries
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y git g++ nodejs qt4-default libsdl-dev libsdl-ttf2.0-dev libfontconfig1-dev libxinerama-dev

# Let's get down to business
git clone https://github.com/jsmess/jsmess.git
cd jsmess
git submodule update --init --recursive

# Link games/ and bios/
cd ..
rm -rf games bios
ln -s $MESS_GAME_DIR
ln -s $MESS_BIOS_DIR

# Clang & emscripten-fastcomp
cd third_party
git clone https://github.com/kripken/emscripten-fastcomp
cd emscripten-fastcomp
git checkout incoming
cd tools
git clone https://github.com/kripken/emscripten-fastcomp-clang clang
cd clang
git checkout incoming
cd ../..
mkdir build
cd build
../configure --enable-optimized --disable-assertions --enable-targets=host,js
make -j 4 install
../../emscripten/emcc

# Helpers
cd ../../../helpers
sudo chown vagrant .
./genhelpers.sh

# If you want MAME, uncomment these lines
#cd ../mamehelpers/
#sudo chown vagrant .
#./genhelpers.sh

# Make a MESS!

./startmake.sh $MESS_PLATFORM
cd ../..
make SYSTEM=$MESS_PLATFORM GAME=$MESS_GAME_FILE test
