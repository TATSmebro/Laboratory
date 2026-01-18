#!/bin/bash

N=10
POLICIES=(baseline double biased)
BASE_DIR="output"

mkdir output

for policy in ${POLICIES[@]}; do
  git switch $policy

  make clean > /dev/null

  echo "Recompiling for policy $policy"
  make > /dev/null

  echo "Priming with throwaway run"
  CPUS=1 make qemu > /dev/null

  for ((k=1; k<=N; k++)); do
    filename="$BASE_DIR/$policy-$k.txt"
    echo $filename

    CPUS=1 make qemu > $filename

  done
done
