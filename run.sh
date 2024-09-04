#!/bin/bash

set -x

dune build
tmpfile=$(mktemp)
dune build 2>$tmpfile
cat $tmpfile
rm -f $tmpfile
