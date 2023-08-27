cmake_minimum_required(VERSION 3.6)

project(mcu C ASM)

list(APPEND MCU_INC
    ${MCU_FAMILY}
    ${MCU_FAMILY}/core
    ${MCU_FAMILY}/hal/inc
)

if (MCU_FAMILY STREQUAL "stm32f1")
    list(APPEND BSP_SRC
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_adc_ex.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_adc.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_can.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_cortex.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_dma.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_exti.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_flash.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_flash_ex.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_gpio.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_i2c.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_rcc.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_rcc_ex.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_sd.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_spi.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_tim.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_tim_ex.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_uart.c
        ${MCU_FAMILY}/hal/src/stm32f1xx_hal_usart.c
    )

    if(MCU_MODEL STREQUAL "stm32f103c8t6")
        list(APPEND MCU_SRC
            ${MCU_FAMILY}/core/startup_stm32f103xb.s
            ${MCU_FAMILY}/core/system_stm32f1xx.c
        )
    else()
        message(FATAL_ERROR "CMake error: MCU_MODEL is not selected")
    endif()
elseif (MCU_FAMILY STREQUAL "stm32f4")
    list(APPEND BSP_SRC
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_adc_ex.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_adc.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_can.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_cortex.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_dma.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_exti.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_flash.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_flash_ex.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_gpio.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_i2c.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_rcc.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_rcc_ex.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_sd.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_spi.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_tim.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_tim_ex.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_uart.c
        ${MCU_FAMILY}/hal/src/stm32f4xx_hal_usart.c
    )

    if(MCU_MODEL STREQUAL "stm32f401re")
    list(APPEND MCU_SRC
        ${MCU_FAMILY}/core/startup_stm32f401xe.s
        ${MCU_FAMILY}/core/system_stm32f4xx.c
    )
    else()
        message(FATAL_ERROR "CMake error: MCU_MODEL is not selected")
    endif()
else()
    message(FATAL_ERROR "CMake error: MCU_FAMILY is not selected")
endif()

add_library(mcu-static STATIC ${MCU_SRC})
target_include_directories(mcu-static PUBLIC ${MCU_INC})

list(TRANSFORM MCU_INC PREPEND "${CMAKE_CURRENT_LIST_DIR}/")
set(MCU_INC ${MCU_INC} PARENT_SCOPE)
