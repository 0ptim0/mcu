cmake_minimum_required(VERSION 3.6)

set(TOOLCHAIN STM32)
set(STM32 TRUE)

set(CMAKE_SYSTEM_NAME STM32)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION 1)

if (MCU_MAP_CREATION STREQUAL "ON")
    set(LINK_MAP_CREATION_FLAG "-Wl,-Map=${PROJECT_BINARY_DIR}/${PROJ_NAME}.map")
endif ()

set(ARCH "cortex-m4")

SET(CMAKE_C_COMPILER_WORKS   TRUE)
SET(CMAKE_CXX_COMPILER_WORKS TRUE)

set(TOOLCHAIN_BIN_DIR   "/usr/bin")
set(TOOLCHAIN_BIN_PATH  ${TOOLCHAIN_BIN_DIR}/arm-none-eabi)
set(CMAKE_C_COMPILER    ${TOOLCHAIN_BIN_PATH}-gcc)
set(CMAKE_CXX_COMPILER  ${TOOLCHAIN_BIN_PATH}-g++)
set(CMAKE_ASM_COMPILER  ${TOOLCHAIN_BIN_PATH}-gcc)
set(CMAKE_SIZE          ${TOOLCHAIN_BIN_PATH}-size)
set(CMAKE_OBJCOPY       ${TOOLCHAIN_BIN_PATH}-objcopy)
set(CMAKE_OBJDUMP       ${TOOLCHAIN_BIN_PATH}-objdump)
set(LINKER_SCRIPT       ${CMAKE_CURRENT_LIST_DIR}/core/${MCU_MODEL}.ld)

string(CONCAT MCU_FLAGS
    "-mcpu=cortex-m4 "
    "-mlittle-endian "
    "-mfloat-abi=soft "
    "-mthumb "
    "-mno-unaligned-access "
)

string(CONCAT COMPILER_FLAGS
    "${MCU_FLAGS} "
    # "-Werror -pedantic-errors "
    "-Wall -Wextra "
    # "-Wpedantic "
    "-Wcast-align "
    "-Wcast-qual "
    "-Wduplicated-branches "
    "-Wduplicated-cond "
    "-Wfloat-equal "
    "-Wlogical-op "
    "-Wredundant-decls "
    "-Wsign-conversion "
    "-Wconversion "
    "-Wno-unused-variable "
    "-Wno-unused-function "
    "-Wno-unused-parameter "
    "-Wno-missing-braces "

    "-fdata-sections "
    "-ffunction-sections "
)

string(CONCAT LINKER_FLAGS
    "${LINK_MAP_CREATION_FLAG} "
    "--specs=nosys.specs "
    "-specs=nano.specs "
    "${MCU_FLAGS} "
    "-Wl,--start-group -lgcc -lc -lg -Wl,--end-group "
    "-Wl,--gc-sections -u _printf_float "
    "-T ${LINKER_SCRIPT} "
)

set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_C_FLAGS_DEBUG "-O0 -g3 ${COMPILER_FLAGS}")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3 ${COMPILER_FLAGS}")
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG ${COMPILER_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG ${COMPILER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${LINKER_FLAGS} -O3")

if (MCU_MODEL STREQUAL "stm32f401re")
    add_definitions(-DSTM32F401xE)
endif()
