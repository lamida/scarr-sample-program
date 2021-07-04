# ScaRR Sample Program

This repository contains sample program that is used to test [ScaRR LLVM passes](https://github.com/lamida/llvm-project/pull/3/). 

In the `small/c` and `big/c` subdirectory there are several c source code. There are also some script to regenerate the result. 
In that folder, there are some subfolder with the same name as the c source code.

In the subfolder there will be two more folders:
* dot-scarr
* dot-scarr-inline

In those two folderswe can see the modified dot-cfg output with checkpoint information. There is also loa.txt which contains
the statistic of the checkpoints and LoA.

# Note
There are some gibberish at the end of loa.txt. I am still not sure what is causing that. Maybe because of the piping in the script I use to generate that.
