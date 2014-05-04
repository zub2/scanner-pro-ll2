# Debian/Ubuntu package for Scanner Pro LL2

This repository contains some scripts and Debian package specification that can be used to turn the upstream zip archive into a Debian package.

While the name _Scanner Pro LL2_ looks a bit obscure this is the name used inside the original package. It seems to be produced by SAGEMCOM. I found the following inside the original zip file I downloaded: date *2011-01-01* and version *1.0.7d*. It should support the scanner part of the following multifunction printers with scanner:
* Philips MFD 6020
* Ricoh Aficio SP1100S

and perhaps others.

## How to build the package
The process is not fully automated. You need to run the individual steps manually.

First make sure you have the necessary tools to build the package. Required packages are:
* build-essential
* devscripts
* debhelper
* wget

You can install these e.g. by:

    sudo apt-get install build-essential devscripts debhelper wget

Then you can proceed to the individual steps.

### Get the upstream achive
Ideally just run:

     ./get_upstream_zip.sh

and it should download the archive. But it's possible the URL of the archive changes. In that case have a look at Philips' or Ricoh's website and try to find its current location by searching for the printer's drivers on their websites.

Note that if the name of the archive changes you need to update the script in the following step.

### Repackage the upstream zip archive

The original zip archive needs to be repackaged to match the requirements of the Debian packaging tools. To do so, run:

    ./repack_zip.sh

This should result in a file `scanner-pro-ll2_1.0.7d.orig.tar.xz`.

### Unpacking the orig.tar.xz file

Now unpack the orig.tar.xz:

    tar xJvf scanner-pro-ll2_1.0.7d.orig.tar.xz

Its content should merge with what's already in `scanner-pro-ll2-1.0.7d` so it should now contain the subdirectories:
* `Linux` (this comes from the original file)
* `debian` (packaging info, part of this repository)

### Build the deb package

The packaging command must be run in the directory that contains the "debian" subdirectory, so switch there:

    cd scanner-pro-ll2-1.0.7d

and then run:

    debuild -us -uc

If you're on amd64 and want to build the package anyway, try this:

    DEB_BUILD_OPTIONS="nostrip" debuild -us -uc -ai386

It's a bit hacky, but should result in a working package too.

The resulting files should be build in the parent directory of the current one (so, in the root of the repository). The file you care about is `scanner-pro-ll2_1.0.7d-1_i386.deb`.

## How to install the package

The package has the following dependencies:
* sane
* libusb-0.1-4

If your architecture is i386, just do:

    sudo apt-get install sane libusb-0.1-4

For amd64 this is more complicated. The upstream binaries are for i386 only, so if you want to install the package on amd64 (x86_64), you need to get the dependencies that were built for the i386 architecture.

To get that, you can do like:

    dpkg --add-architecture i386
    apt-get update
    apt-get install sane:i386 libusb-0.1-4:i386

though it might be better to use something like Aptitude to be able to analyze and solve possible conflicts or other issues. See https://wiki.debian.org/Multiarch/HOWTO.

Note there there is one unavoidable issue: It's not possible to install both sane:amd64 and sane:i386 at the same time.

Then finally you can install the package itself:

    sudo dpkg -i scanner-pro-ll2_1.0.7d-1_i386.deb

And that should be it. If you're lucky:

    sudo sane

should tell you it sees the scanner:

To actually use sane with your user account, add yourself to the group "scanner":

    sudo adduser $USER scanner
 
then log out and back in for the change to take effect.

Good luck!
