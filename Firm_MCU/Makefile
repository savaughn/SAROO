# Project-specific variables
TARGET = ssmaster
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# Directories
SRCDIR = ./Main
INCDIR = ./inc ./FatFS ./RTE/CMSIS ../../STM32CubeH7/Drivers/CMSIS/Device/ST/STM32H7xx/Include ../../STM32CubeH7/Drivers/CMSIS/Include ../../STM32CubeH7/Drivers/CMSIS/RTOS2/Include ../../ArduinoCore-mbed-4.2.1/cores/arduino/mbed/cmsis/CMSIS_5/CMSIS/RTOS2/RTX/Include/
BUILDDIR = build

# Source files
SRCS = \
	$(SRCDIR)/main.c \
	$(SRCDIR)/printk.c \
    $(SRCDIR)/uart4.c \
    $(SRCDIR)/sdio_h7.c \
    $(SRCDIR)/spi1_fpga.c \
    $(SRCDIR)/shell.c \
    $(SRCDIR)/version.c \
    Startup/system_init.c \
    FatFS/file_utils.c \
    $(SRCDIR)/diskio.c \
    $(SRCDIR)/ff.c \
    $(SRCDIR)/ffunicode.c \
    Saturn/saturn_main.c \
    Saturn/saturn_cdc.c

# Compiler flags
CFLAGS = -Wall -g -Os -ffunction-sections -fdata-sections -mcpu=cortex-m7 -mthumb
CFLAGS += $(addprefix -I, $(INCDIR))

# Linker flags
LDFLAGS = -Tstm32h750xx.ld -Wl,--gc-sections

# Object files
OBJS = $(addprefix $(BUILDDIR)/, $(notdir $(SRCS:.c=.o)))

# Rules to build object files from C source files
$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rules to build object files from C source files
$(BUILDDIR)/%.o: Startup/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: FatFS/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: Saturn/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	
# Build rules
.PHONY: all clean

all: $(TARGET).bin

$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
	$(SIZE) $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -rf $(BUILDDIR) $(TARGET).elf $(TARGET).bin