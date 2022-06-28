# shellutils

Some shell utility scripts. All scripts are written in either POSIX shell or c++
and so should be fairly portable.

Note: make will strip extensions when installing to executables will not have
`.sh` or `.out` at the end

### Requirements

* shell
  * tested on bash, dash and zsh
  * needed for `*.sh`
* make
  * needed for everything
* c++ compiler with support for c++ 20
  * tested with gcc 11.1 and 11.2
  * if you have a c++ compiler that is not `/usr/bin/c++`, you can specify `CC`
    macro in `config.mk`
  * needed for `*.cpp`
* clang-tidy
  * needed for `ctfix.sh`
* gpg, tar
  * needed for `decryptdir.sh` and `encryptdir.sh`
* curl
  * needed for `dict.sh`
* bat
  * needed for `wbat`
* grub
  * needed for `update-grub.sh`
* xprop
  * needed for `wminfo.sh`

### List of Scripts and what they do

#### bak

* creates a backup of the file (or directory) passed to it as the first
  argument.
* backed up file is called `ORIGINAL_NAME.bak`

#### colorcheck

* checks color capabilities of a terminal by printing all colors

#### ctfix

* fixes c/c++ files with clang-tidy

#### decryptdir

* decrypts the tarball, then decompresses it.
* deletes the encrypted tar and the unencrypted tar.

#### dict

* takes 1 argument
* sends that argument to <dict://dict.org>
* prints the formatted result.

#### double

* takes 1 argument.
* closes the current terminal then opens 2 new terminals to the directory
  specified by the argument.

#### encryptdir

* creates a tarball from the directory
* encrypts the tarball, deletes the tar ball and the original directory.

#### execf

* stands for execute from.
* it takes a path (relative or absolute) as the first parameter, and a command
  as the second.
* then the command is executed as if current working directory was the one given
  as the first parameter.
  * E.g. `execf ~/ ls` will list the contents of the home directory (yes, just
    like `ls ~/` would).

#### extrename

* renames extensions of the files in the current directory
  * and any subdirectories in it
* from the one supplied as the 1st argument to the one supplied as the second
  * do not include dots
  * E.g. `extrename c cpp` will rename all files that match `*.c` to `*.cpp`

#### floatdump

* reads file
  * from stdin or as an argument
* interprets it as binary data
* converts binary data to some number format
  * float by default
  * use `floatdump -h` for details

#### forever

* will rerun a command forever

#### fsize

* takes one or more files
* prints their sizes in bytes
* see `fsize -h` for more options

#### license

* takes the name of a license, one of:
  * AGPL-3.0
  * Apache-2.0
  * BSD-2-Clause
  * BSD-3-Clause
  * BSL-1.0
  * CC0-1.0
  * EPL-2.0
  * GPL-2.0
  * GPL-3.0
  * LGPL-2.1
  * MIT
  * MPL-2.0
  * Unlicense
* copies said license to the LICENSE file in the current directory
* if a license requires copyright year to be specified (e.g. MIT), it will be
  fetched with the unix `date` command
* if a license requires author's name, it will first be taken from git's
  user.name or, if that fails, from `$USER`

#### lstype

* lists regular files in the current directry (not recursively) with their
  filetypes as deduced from the shebang.
* 0 if shebang is not supplied.

#### mkfile

* takes a path and creates an empty file at that location
* creates all intermediate directories if they don't exist

#### out

* takes tty number as the first argument and a command as the second.
* displays the output from the command to the specified tty.
* tty number can be found by running `tty`.

#### rmextdup

* remove extension duplicates.
* finds files with the same name, but different extension
* removes all files with the unwanted extension.
* takes 2 arguments with an optional `-t|--test` flag.
  * first argument is the extension to keep (without the dot)
  * the second one is extension to remove.
  * -t or --test will not remove any files, instead it will print all of the rm
    commands it would have ran if -t was not supplied.
  * -t can be used 1st or last, but not between the other 2 parameters.

#### run

* closes the current terminal and launches a program that was supplied as the
  argument.
* program has to be in `PATH`

#### update-grub

* works like it does on ubuntu.
* run (as root) after tweaking /etc/default/grub.

#### wbat

* same as `wcat` but using [bat](https://github.com/sharkdp/bat)

#### wcat

* print the contents of files on path that were passed as arguments

#### wminfo

* lifted from the suckless dwm documentation,
  [rules](https://dwm.suckless.org/customisation/rules/) section.
* Requires xprop and prints the basic information about the next window you
  click on in a human readable format.
* This information is often required by stand-alone window managers (and even
  some desktop environments).

### Installation

``` sh
git clone https://github.com/dk949/shellutils/
cd shellutils
make install
```

Note: This is the default method and it assumes that $HOME/.local/bin exists (it
will be created if not) and is on PATH. If you wish to install to a different
directory change `DESTDIR` and/or `PREFIX` variables in config.mk.
