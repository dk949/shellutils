# shellutils
Set of shell scripts I use. All scripts are written in POSIX shell and should be fairly portable.
### List of Scripts and what they do
* bak - creates a backup of the file passed to it as the first argument (others are gnored). Backed up file is called originalFile.bak
* colorcheck - checks whether or not  terminal has full color support
* decriptdir - dectipts the tarball, then decompressesit. Deletes the encripted tar and the unencripted tar.
* dict - takes 1 arguemnt, sends that argumen to dict://dict.org and prints the formatted result.
* double - takes 1 argument. closesthe current terminal then opens 2 new terminals to thedirectory specified by teh argument
* encriptdir - creates a tarball from the directory, encriptsthe tarball, deletes thetar ball and the oeriginal directory.
* execf - stands for execute from. It takes a path (relative or absolute) as the first parameter, and a command as the second. Then the command is executed as if current working directory was the one given as the first parameter. E.g. `execf ~/ ls` will list the contents of the home directory (yes, just like ls ~/ would).
* extrename - renames extensions of the files in the current directory (and any subdirectories in it) from the one supplied as the 1st argument to the one supplied as the second
* lstype - lists regular files in the current directry (not recursively) with their filetypes as deduced from the shebang. 0 if shebang is not supplied. Note: Turns out this one does use some bash only functionality, so it requires bash.
* out - takes tty number as the first argument and a command as the second, and displays the output from the command to the specified tty. tty number can be found by running `tty`.
* rmphdub - remove photo duplicates. Finds files with the same name, but different extention and removes all files with the unwanted extension. Takes 2 arguments with an optional -t|--test flag. First argument is the extension to keep (without the dot), the second one is extension to remove. -t or --test will not remove any files, instead it will print all of the rm commands it would have ran if -t was not supplied. -t can be used 1st or last, but not between the other 2 parameters.
* run - closes the current terminal and launches whichever program was supplied as the argument.
* update-grub - works like it does on ubuntu. Run (as root) after tweaking /etc/default/grub.
* wminfo - lifted from the suckless dwm documentation, [rules](https://dwm.suckless.org/customisation/rules/) section. Requires xprop and prints the basic information about the next window you click on in a human readable format. This information is often required by standalone window managers (and even some desktop environments.)

### Installation
```
git clone https://github.com/dk949/shellutils/
cd shellutils
make install
```
Note: This is the default method and it assumes that $HOME/.local/bin  exists (it will be created if not) and is on PATH. If you wish to install to a different directory change `DESTDIR` and/or `PREFIX` variables in config.mk.

