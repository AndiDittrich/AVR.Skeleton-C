Skeleton-C
==========

Simple Makefile Template for 8Bit AVR Projects

## Features ##

* Simply compile all C-Files of a project
* Project configuration within a simple config file
* Generates the `.hex` image and extended listing `.lss`
* Includes some [basic utility functions](docs/library.md) located in `lib/`
* Use [AVRDUDE](http://www.nongnu.org/avrdude/) to upload the flash image to your target
* Advanced PHP based pre-processing (define your custom pre-processor functions)

## Requirement: AVR Toolchain ##

The AVR Toolchain can be installed with your package manager, or *in case you need a more recent version* manually by downloading the [Official Toolchain Package](http://www.atmel.com/tools/atmelavrtoolchainforlinux.aspx)

**Ubuntu/Debian**

```bash
apt-get install make avr-libc binutils-avr gcc-avr avrdude
```

## Usage ##

1. Download the Skeleton-C package `wget https://github.com/AndiDittrich/AVR.Skeleton-C/archive/master.zip -O skeleton.zip`
2. Unpack it `unzip skeleton.zip`
3. Customize the project based configuration by editing `config.makefile` to match your MCU-Type and frequency
4. Compile your project with `make`
5. Upload the flash image to your device `make install`

All build-files are stored in the `build/` directorie. The output files are prefixed with **_application**.
For example, the generated hex file is located in `build/_application.hex`

## Project based Configuration ##
To edit linker, compiler flags, MCU-target, frequency you just need to edit the `config.makefile` file.
This allows you to easily update the **Skeleton-C** project without merging the makefile manually!

### Exmaple - Target Device Settings ###

* 8MHz Clock
* atmega16

```makefile
# The AVR Device (AVR-GCC/AVRDUDE)
T_DEVICE = atmega16

# Target Clock (F_CPU) in Hz
T_FCPU  = 8000000
```

## EEPROM Programming ##

```raw
0x55 0x22 0x10 0x1 0x00 0x01 0x02 0x03
0x22 0x11 0x00 0xff 0xA0
```

## Library Functions ##

A bunch of easy to use [utility functions](LibraryDocs.md) is included to speed-up your project.
For further informations, please take a look into the [Documentation](LibraryDocs.md)

## Any Questions ? Report a Bug ? Enhancements ? ##

Please open a new issue on [GitHub](https://github.com/AndiDittrich/AVR.Skeleton-C/issues)

## License ##

AVR.Skeleton-C is OpenSource and licensed under the Terms of [The MIT License (X11)](http://opensource.org/licenses/MIT). You're welcome to [contribute](https://github.com/AndiDittrich/AVR.Skeleton-C/blob/master/CONTRIBUTE.md)!
