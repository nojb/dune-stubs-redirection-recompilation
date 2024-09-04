This test exhibits a weird issue with how Dune decides to recompile C stubs:
they seem to be considered out-of-date of the `dune build` command changes its
standard error redirection.

When executing `run.sh`, a tiny library with C stubs is compiled twice by doing
`dune build`, followed by `dune build`, where the standard error of the second
build command is redirected to a temporary file. Normally, one would not expect
to have any recompilation the second time around; however, it turns out that
Dune rebuilds the C stubs the second time around.

Output on my computer:

```
$ cat run.sh
#!/bin/bash

set -euox pipefail

dune build # should show warning

tmpfile=$(mktemp)

dune build 2>$tmpfile

cat $tmpfile

rm -f $tmpfile
$ ./run.sh
+ dune build
stubs.c:1:2: warning: #warning "foo" [-Wcpp]
    1 | #warning "foo"
      |  ^~~~~~~
++ mktemp
+ tmpfile=/tmp/tmp.cB53WNBajm
+ dune build
+ cat /tmp/tmp.cB53WNBajm
stubs.c:1:2: warning: #warning "foo" [-Wcpp]
    1 | #warning "foo"
      |  ^~~~~~~
+ rm -f /tmp/tmp.cB53WNBajm
```
