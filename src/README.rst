mkisofs 

.. code:: bash

  -D Do not use deep directory relocation, and instead just pack them in the way we see them. If ISO9660:1999 has not been selected, this violates the ISO9660 standard, but it happens to work on many systems.

  -R Generate SUSP and RR records using the Rock Ridge protocol to further describe the files on the ISO9660 filesystem.

  -r  This  is  like the -R option, but file ownership and modes are set to more useful values.

  -V volid

  -J Generate Joliet directory records in addition to regular ISO9660 filenames.

  -l Allow full 31-character filenames.

  -b Specifies the path and filename of the boot image to be used when making an El Torito bootable CD for x86 PCs. The pathname must be relative to the source path specified to genisoimage.  This option is required to make an El Torito bootable CD.   The  boot  image must  be  exactly 1200 kB, 1440 kB or 2880 kB, and genisoimage will use this size when creating the output ISO9660 filesystem.  The PC BIOS will use the image to emulate a floppy disk, so the first 512-byte sector should contain PC boot code.  This will work, for example, if the boot image is a LILO-based boot floppy.

  -c boot catalog: Specifies  the path and filename of the boot catalog, which is required for an El Torito bootable CD.

  -no-emul-boot: Specifies that the boot image used to create El Torito bootable CDs is a "no emulation" image. The system  will  load  and  execute this image without performing any disk emulation.

  -boot-load-size: Specifies the number of "virtual" (512-byte) sectors to load in no-emulation mode.  The default is to load the  entire  boot  file. Some BIOSes may have problems if this is not a multiple of 4.

  -boot-info-table: Specifies  that  a  56-byte  table  with information of the CD-ROM layout will be patched in at offset 8 in the boot file.  If this option is given, the boot file is modified in the source filesystem, so make a copy of this file if it cannot  be  easily  regenerated!  See the EL TORITO BOOT INFO TABLE section for a description of this table.

  -input-charset: Input charset that defines the characters used in local filenames.

  -cache-inodes: Enable or disable caching inode and device numbers to find hard links to files.  If genisoimage finds a hard link (a file with mul‐
              tiple  names),  the  file  will  also  be  hard-linked on the CD, so the file contents only appear once.

  -quiet: surpress output

  -o: output-iso
