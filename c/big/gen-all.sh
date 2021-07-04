#echo "branches\nbranches2\nfactorial\nfib\nscarr\nnested-loop\nshadow\nsimple-linear\nsimple-loop\nuncallable" | xargs -I{} ./gen.sh {} $1
echo "sqlite3" | xargs -I{} ./gen-scarr.sh {} $1
echo "sqlite3" | xargs -I{} ./gen-scarr.sh {} no-opt
echo "sqlite3" | xargs -I{} ./gen-loa.sh {} $1
  echo "sqlite3" | xargs -I{} ./gen-loa.sh {} no-opt

# Remove non main dot file
find . -type f -name "*.dot" | grep -v main | xargs rm
find . -type f -name "*.dot.png" | grep -v main | xargs rm
