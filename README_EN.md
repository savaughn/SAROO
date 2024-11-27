### SAROO is an HDLoader for SEGA Saturn.

SAROO is a Saturn CD drive emulator. SAROO plugs into the slot and implements the functionality of the original motherboard's CDBLOCK, loading and running games from an SD card.
SAROO also provides 1MB/4MB acceleration card functionality.

--------
### Some Pictures

<img src="../doc/saroo_v12_top.jpg" width=48%/>  <img src="../doc/saroo_v12_bot.jpg" width=48%/>
<img src="../doc/saroo_scr1.png" width=48%/>  <img src="../doc/saroo_scr2.png" width=48%/>
<img src="../doc/saroo_dev1.png"/>
<img src="../doc/saroo_devhw.jpg"/>


--------
### Development History

#### V1.0
The initial SAROO only added a usbhost interface to the common usbdevcart. It required cracking the game main program to convert CDBLOCK operations to USB drive operations.
This method required modifications for each game, lacking universality. Performance and stability were also major issues. Only a few games could run using this method.
(Files related to V1.0 are not included in this project)


#### V1.1
The new version was completely redesigned. It adopted an FPGA+MCU approach. FPGA (EP4CE6) was used to implement the hardware interface of CDBLOCK, and MCU (STM32F103) ran firmware to handle various CDBLOCK commands.
This version basically achieved the expected goal, and some games could almost run. But there was also a fatal problem: random data errors. Various mosaics would appear during the opening animation, and eventually crash.
This problem was difficult to debug and locate, causing the project to stagnate for a long time.


#### V1.2
Version 1.2 is a bugfix and performance improvement of version 1.1, using a higher performance MCU: STM32H750. Its frequency is high enough (400MHz), and it has enough internal SRAM to accommodate the complete CDC cache.
The FPGA was also restructured, abandoning the qsys system and using a self-implemented SDRAM and bus structure. This version lived up to expectations and was almost perfect.
At the same time, by reverse porting the FPGA and MCU firmware to the V1.1 hardware, V1.1 also basically achieved the performance of V1.2.


--------
### Current Status

Dozens of tested games can run perfectly.  
1MB/4MB acceleration card functionality works normally.  
SD card supports FAT32/ExFAT file systems.  
Supports cue/bin format image files. Single bin or multi-bin.  
Some games may freeze at the loading/opening animation screen.  
Some games may freeze during gameplay.  


--------
### Hardware and Firmware

Schematics and PCB are made using AltiumDesign14.  
Version 1.1 requires wire modifications to work properly. This version should no longer be used.  
Version 1.2 still requires an additional pull-up resistor to use the FPGA's AS configuration mode.  

FPGA is developed using Quartus14.0.  

Firm_Saturn is compiled using the SH-ELF compiler that comes with SaturnOrbit.  
Firm_v11 is compiled using MDK4.  
Firm_V12 is compiled using MDK5.  


--------
### SD Card File Placement

<pre>
/ramimage.bin      ;Firmware program for Saturn.
/SAROO/ISO/        ;Store game images. Each directory contains one game. The directory name will be displayed in the menu.
/SAROO/update/     ;Store firmware for updates.
                   ;  FPGA: SSMaster.rbf
                   ;  MCU : ssmaster.bin
</pre>


--------
Some development notes: [SAROO Technical Notes](../doc/SAROO技术点滴.txt)