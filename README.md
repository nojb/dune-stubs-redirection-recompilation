This test exhibits a weird issue with how Dune decides to recompile C stubs:
they seem to be considered out-of-date of the `dune build` command changes its
standard error redirection.

When executing `run.sh`, a tiny library with C stubs is compiled twice by doing
`dune build`, followed by `dune build`, where the standard error of the second
build command is redirected to a temporary file. Normally, one would not expect
to have any recompilation the second time around; however, it turns out that
Dune rebuilds the C stubs the second time around.
