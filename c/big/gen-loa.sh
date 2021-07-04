if [ -z "$1" ]
  then
    echo "title is required"
    exit 1
fi

title=$1
if [ -n "$2" ] && [  "$2" = "no-opt" ]
  then
    echo "Running with no-opt"
    out_title=$1-no-opt
  else
    out_title=$1
fi

cd $out_title/dot-scarr
pwd
echo /home/lamida/github/llvm/llvm-project/llvm/cmake-build-release/bin/opt ../../$out_title.ll -passes=scarr-cp-marker,scarr-loa-collector 
/home/lamida/github/llvm/llvm-project/llvm/cmake-build-release/bin/opt ../../$out_title.ll -passes=scarr-cp-marker,scarr-loa-collector > loa.txt
cd ../..

cd $out_title/dot-scarr-inline
pwd
echo /home/lamida/github/llvm/llvm-project/llvm/cmake-build-release/bin/opt ../../$out_title.ll -passes=inliner-wrapper,scarr-cp-marker,scarr-loa-collector
/home/lamida/github/llvm/llvm-project/llvm/cmake-build-release/bin/opt ../../$out_title.ll -passes=inliner-wrapper,scarr-cp-marker,scarr-loa-collector > loa.txt
cd ../..

