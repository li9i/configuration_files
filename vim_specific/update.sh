#!/bin/bash

cd /home/alek/vim_specific

if [ -f cscope.files ]; then
  rm cscope.files
else
  touch cscope.files
fi

find /home/alek/pandora/ -name "*.cpp" > cscope.files
find /home/alek/pandora/ -name "*.h" >> cscope.files

cscope -bRq

cd /home/alek/pandora/src/pandora_vision
ctags -R .
