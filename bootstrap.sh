#!/usr/bin/env bash

# Commands and other details taken from
# https://github.com/jsmess/jsmess/wiki/How-to-build-and-test-JSMESS-0.153

# Preliminaries
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y git g++ nodejs qt4-default libsdl-dev libsdl-ttf2.0-dev libfontconfig1-dev libxinerama-dev

# Let's get down to business
git clone https://github.com/jsmess/jsmess.git
cd jsmess
git submodule update --init --recursive
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
make -j 4
../../emscripten/emcc
