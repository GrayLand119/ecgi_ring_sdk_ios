#!/bin/bash

# 删除当前目录下以 .mat 结尾的文件
rm -f *.mat

# 删除当前目录下名称包含 _clang-format 的文件
rm -f *_clang-format*

# 删除当前目录下以 .dmr 结尾的文件
rm -f *.dmr

# 删除当前目录下以 .tmw 结尾的文件
rm -f *.tmw

rm -rd examples
rm -rd html
rm -f interface/_*.cpp
rm -f interface/_*.h
rm -rf ./**/README.txt
rm -rf **/README.txt
rm -rd CXSparse/License
rm -rf CXSparse/SuiteSparse_config/SuiteSparse_config.mk

cp CMakeLists.txt CMakeLists_bak.txt
