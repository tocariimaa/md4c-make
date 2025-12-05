# md4c-make

This repository is a "fork" of [MD4C](https://github.com/mity/md4c) which replaces the CMake-based build
system with POSIX Make.

See the original repo for the documentation, information, etc.

## Makefile
### Targets
Check the makefile for all the details.

- `all`: build all
- `install`: installs the md4c, md4c-html libraries and md2html at `PREFIX`.
- `install-md4c`: install md4c library
- `install-md4c-html` install md4c-html library
- `install-md2html` install md2html program
- `uninstall`

Modify `config.mk` to fit your needs (change compiler, flags, `PREFIX`, etc).
