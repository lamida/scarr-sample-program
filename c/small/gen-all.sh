#echo "branches\nbranches2\nfactorial\nfib\nscarr\nnested-loop\nshadow\nsimple-linear\nsimple-loop\nuncallable" | xargs -I{} ./gen.sh {} $1
echo "branches\nbranches2\nfactorial\nfib\nscarr\nnested-loop\nshadow\nsimple-linear\nsimple-loop\nuncallable" | xargs -I{} ./gen-scarr.sh {} $1
# echo "branches\nbranches2\nfactorial\nfib\nscarr\nnested-loop\nshadow\nsimple-linear\nsimple-loop\nuncallable" | xargs -I{} ./gen-loa.sh {} $1
# echo "branches\nbranches2\nfactorial\nfib\nscarr\nnested-loop\nshadow\nsimple-linear\nsimple-loop\nuncallable" | xargs -I{} ./gen-loa.sh {} no-opt

