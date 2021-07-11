#!/bin/bash
title=$1
is_optimized=$2
base_dir=$(pwd)

if [ -z "$title" ]; then
  echo "title is required"
  exit 1
fi

LLVM_OPT_CMD=/home/lamida/github/llvm/llvm-project/llvm/cmake-build-release/bin/opt

generate_dot() {
  local dir_name_prefix=$1
  local title=$2
  local cfg_type=$3
  local is_inline=$4
  local is_optimized=$5

  local dir_name=$dir_name_prefix/dot-scarr

  local dot_pass="dot-cfg"
  local out_file_suffix="default" # print instructions in dot file
  if [ $cfg_type == "only" ]; then
    dot_pass="dot-cfg-only"
    out_file_suffix="only"
  fi 

  local llvm_passes=scarr-cp-marker,scarr-loa-collector,$dot_pass
  if [ "$is_inline" == "inline" ]; then
    llvm_passs=inliner-wrapper,scarr-cp-marker,scarr-loa-collector,$dot_pass
    dir_name=$dir_name_prefix/dot-scarr-inline
  fi

  mkdir -p $dir_name
  cd $dir_name
  $LLVM_OPT_CMD ../$title.ll -passes=$llvm_passes > loa.txt
  for file in $(ls -A); do
    if [ "${file##*.}" = "dot" ]; then
      baseFileName="$(basename "$file" .dot)"
      # Add suffix if it is not added
      if [[ $baseFileName != *"only"* && $baseFileName != *"default"* ]]; then
        newName="$baseFileName-$out_file_suffix"
        mv $file $newName.dot
        dot -Tpng $newName.dot -o $newName.png
      fi
    fi
  done
  
  # Remove all non-main files
  for file in $(ls -A); do
  if [[ $file != *"main"* ]]; then
    rm $file
  fi
  
  done
  cd $base_dir
}

dir_name_prefix=$title/no-opt
if [ -n "$is_optimized" ] && [  "$is_optimized" = "optimized" ]; then
  dir_name_prefix=$title/opt
  mkdir -p $dir_name_prefix
  clang -emit-llvm $title.c -S -o $dir_name_prefix/$title.ll

  generate_dot $dir_name_prefix $title "only" "no-inline" "optimized"
  generate_dot $dir_name_prefix $title "default" "on-inline" "optimized"
  generate_dot $dir_name_prefix $title "only" "inline" "optimized"
  generate_dot $dir_name_prefix $title "default" "inline" "optimized"
else
  mkdir -p $dir_name_prefix
  clang -emit-llvm $title.c -S -Xclang -disable-O0-optnone -fno-discard-value-names -o $dir_name_prefix/$title.ll

  generate_dot $dir_name_prefix $title "only" "no-inline" "no-optimized"
  generate_dot $dir_name_prefix $title "default" "on-inline" "no-optimized"
  generate_dot $dir_name_prefix $title "only" "inline" "no-optimized"
  generate_dot $dir_name_prefix $title "default" "inline" "no-optimized"
fi
# Comment attributes line because it prevent the pass to proces the IR
sed -i 's/^attributes/;&/g' $dir_name_prefix/$title.ll
