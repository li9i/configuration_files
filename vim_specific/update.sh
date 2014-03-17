#!/bin/bash

cd $HOME/vim_specific

if [ -f cscope.files ]; then
  rm cscope.files
else
  touch cscope.files
fi

find $HOME/pandora/ -name "*.cpp" > cscope.files
find $HOME/pandora/ -name "*.h" >> cscope.files

cscope -bRq

cd $HOME/pandora/src/pandora_vision
ctags -R .
