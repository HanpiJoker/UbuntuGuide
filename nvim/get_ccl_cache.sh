#!/bin/bash
ccls -index /home/spaceyu/Public/linux-4.9.99/ -init={"clang":{"excludeArgs":[
"-falign-jumps=1","-falign-loops=1","-fconserve-stack","-fmerge-constants","-fno-code-hoisting","-fno-schedule-insns","-fno-sched-pressure","-fno-var-tracking-assignments","-fsched-pressure",
"-mhard-float","-mindirect-branch-register","-mindirect-branch=thunk-inline","-mpreferred-stack-boundary=2","-mpreferred-stack-boundary=3","-mpreferred-stack-boundary=4","-mrecord-mcount","-mindirect-branch=thunk-extern","-mno-fp-ret-in-387","-mskip-rax-setup",
"--param=allow-store-data-races=0","-Wa,arch/x86/kernel/macros.s","-Wa,-"
], "extraArgs":["--gcc-toolchain=aarch64-gnu-linux-gcc"]}}
