# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build

# Include any dependencies generated for this target.
include CMakeFiles/openat.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/openat.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/openat.dir/flags.make

CMakeFiles/openat.dir/src/oscomp/openat.c.o: CMakeFiles/openat.dir/flags.make
CMakeFiles/openat.dir/src/oscomp/openat.c.o: ../src/oscomp/openat.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/openat.dir/src/oscomp/openat.c.o"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/openat.dir/src/oscomp/openat.c.o   -c /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/src/oscomp/openat.c

CMakeFiles/openat.dir/src/oscomp/openat.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/openat.dir/src/oscomp/openat.c.i"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/src/oscomp/openat.c > CMakeFiles/openat.dir/src/oscomp/openat.c.i

CMakeFiles/openat.dir/src/oscomp/openat.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/openat.dir/src/oscomp/openat.c.s"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/src/oscomp/openat.c -o CMakeFiles/openat.dir/src/oscomp/openat.c.s

# Object files for target openat
openat_OBJECTS = \
"CMakeFiles/openat.dir/src/oscomp/openat.c.o"

# External object files for target openat
openat_EXTERNAL_OBJECTS =

riscv64/openat: CMakeFiles/openat.dir/src/oscomp/openat.c.o
riscv64/openat: CMakeFiles/openat.dir/build.make
riscv64/openat: libulib.a
riscv64/openat: CMakeFiles/openat.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable riscv64/openat"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/openat.dir/link.txt --verbose=$(VERBOSE)
	mkdir -p asm
	riscv64-unknown-elf-objdump -d -S /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/openat > asm/openat.asm
	mkdir -p bin
	riscv64-unknown-elf-objcopy -O binary /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/openat bin/openat.bin --set-section-flags .bss=alloc,load,contents

# Rule to build all files generated by this target.
CMakeFiles/openat.dir/build: riscv64/openat

.PHONY : CMakeFiles/openat.dir/build

CMakeFiles/openat.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/openat.dir/cmake_clean.cmake
.PHONY : CMakeFiles/openat.dir/clean

CMakeFiles/openat.dir/depend:
	cd /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build /home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/CMakeFiles/openat.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/openat.dir/depend

