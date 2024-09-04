#!/bin/bash

set -euox pipefail

dune build # should show warning

tmpfile=$(mktemp)

dune build 2>$tmpfile

cat $tmpfile

rm -f $tmpfile
