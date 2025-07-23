# This is converter generated file, and shall not be touched by user
#
# Use CMakeLists.txt to apply user changes
cmake_minimum_required(VERSION 3.22)

# Core MCU flags, CPU, instruction set and FPU setup
set(cpu_PARAMS ${cpu_PARAMS}
    -mthumb

    # Other parameters
    # -mcpu, -mfloat, -mfloat-abi, ...
    -mcpu=cortex-m4
	-mfpu=fpv4-sp-d16
	-mfloat-abi=hard
	
)

# Linker script
set(linker_script_SRC ${linker_script_SRC}
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f407vetx_FLASH.ld
)

# 添加全局宏定义
add_definitions(
    -DSTM32F40_41xxx #指定STM32F4设备系列
    -DUSE_STDPERIPH_DRIVER #启用标准外设库
    -DUSE_FULL_ASSERT    # 启用断言功能
)

# Sources
set(sources_SRCS ${sources_SRCS}
    
	${CMAKE_CURRENT_SOURCE_DIR}/Src/main.c
	${CMAKE_CURRENT_SOURCE_DIR}/Src/syscall.c
	${CMAKE_CURRENT_SOURCE_DIR}/Src/sysmem.c
	${CMAKE_CURRENT_SOURCE_DIR}/Startup/startup_stm32f407vetx.s
    ${CMAKE_CURRENT_SOURCE_DIR}/board/board.c
    ${CMAKE_CURRENT_SOURCE_DIR}/bsp/uart/bsp_uart.c
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/STM32F4xx_StdPeriph_Driver/src/misc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_usart.c
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/croutine.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/event_groups.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/stream_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/tasks.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/timers.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/portable/MemMang/heap_4.c
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/portable/GCC/ARM_CM4F/port.c
    
)

# Include directories
set(include_c_DIRS ${include_c_DIRS}
    
	${CMAKE_CURRENT_SOURCE_DIR}/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/board
    ${CMAKE_CURRENT_SOURCE_DIR}/bsp/uart
    ${CMAKE_CURRENT_SOURCE_DIR}/module
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/CMSIS/Device/ST/STM32F4xx/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/CMSIS/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/libraries/STM32F4xx_StdPeriph_Driver/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/include
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel/portable/GCC/ARM_CM4F

)
set(include_cxx_DIRS ${include_cxx_DIRS}
    
)
set(include_asm_DIRS ${include_asm_DIRS}
    
)

# Symbols definition
set(symbols_c_SYMB ${symbols_c_SYMB}

)
set(symbols_cxx_SYMB ${symbols_cxx_SYMB}
    
)
set(symbols_asm_SYMB ${symbols_asm_SYMB}
    
)

# Link directories
set(link_DIRS ${link_DIRS}
    
)

# Link libraries
set(link_LIBS ${link_LIBS}
    
)

# Compiler options
set(compiler_OPTS ${compiler_OPTS})

# Linker options
set(linker_OPTS ${linker_OPTS})
