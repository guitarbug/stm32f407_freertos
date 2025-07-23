/*
 * 立创开发板软硬件资料与相关扩展板软硬件资料官网全部开源
 * 开发板官网：www.lckfb.com
 * 技术支持常驻论坛，任何技术问题欢迎随时交流学习
 * 立创论坛：https://oshwhub.com/forum
 * 关注bilibili账号：【立创开发板】，掌握我们的最新动态！
 * 不靠卖板赚钱，以培养中国工程师为己任
 * 

 Change Logs:
 * Date           Author       Notes
 * 2024-03-07     LCKFB-LP    first version
 */
#include "stm32f4xx_conf.h"
#include "stm32f4xx.h"
#include "board.h"
#include "bsp_uart.h"
#include <stdio.h>
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_rcc.h"

// for FreeRTOS
#include "FreeRTOS.h"
#include "task.h"

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line)
{
    /* User can add his own implementation to report the file name and line number,
       for example: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

    /* Infinite loop */
    while (1)
    {
    }
}
#endif

// LED任务实现
void LedTask(void *argument) {
    const TickType_t xDelay = pdMS_TO_TICKS(1000); // 将1000ms转换为tick数
    
    printf("LedTask started!\r\n");  // 添加任务启动提示

    for (;;) {
        GPIO_SetBits(GPIOB, GPIO_Pin_2);
        printf("freertos LedTask: LED ON!\r\n");
        vTaskDelay(xDelay);  // 使用FreeRTOS的延迟函数
        
        GPIO_ResetBits(GPIOB, GPIO_Pin_2);
        printf("freertos LedTask: LED OFF!\r\n");
        vTaskDelay(xDelay);  // 使用FreeRTOS的延迟函数
    }
}

//监控系统状态任务实现
void vTaskStats(void *argument) {
    const TickType_t xDelay = pdMS_TO_TICKS(5000);  // 5秒打印一次
    uint32_t counter = 0;
    for(;;) {
        printf("\r\n=== Task Stats %lu ===\r\n",counter++);
        printf("Free Heap: %d bytes\r\n", xPortGetFreeHeapSize());
        printf("Min Free Heap: %d bytes\r\n", xPortGetMinimumEverFreeHeapSize());
        vTaskDelay(xDelay);
    }
}

int main(void)
{
	
	board_init();
	
	uart1_init(115200U);

	GPIO_InitTypeDef  GPIO_InitStructure;
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOB, ENABLE);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
	GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOB, &GPIO_InitStructure);

    // 使用printf测试
    printf("Hello World!!!\r\n");
    printf("SystemCoreClock = %lu Hz\r\n", SystemCoreClock);

    // 创建LED任务
    BaseType_t xReturn = xTaskCreate(
        LedTask,                   // 任务函数
        "LED Task",                // 任务名称
        configMINIMAL_STACK_SIZE * 8, // 栈大小（单位：字）
        NULL,                      // 参数
        tskIDLE_PRIORITY + 3,      // 优先级
        NULL            // 任务句柄
    );

    if(xReturn != pdPASS)
    {
        printf("LED Task creation failed!\r\n");
        while(1);
    }    
    
    //创建监控系统状态任务
    xTaskCreate(
        vTaskStats,                   // 任务函数
        "Task Stast",                // 任务名称
        configMINIMAL_STACK_SIZE * 4, // 栈大小（单位：字）
        NULL,                      // 参数
        tskIDLE_PRIORITY + 1,      // 优先级
        NULL            // 任务句柄
    );

    //配置系统节拍定时器
    if (SysTick_Config(SystemCoreClock / configTICK_RATE_HZ) != 0) {
        printf("SysTick configuration failed!\r\n");
        while(1);
    }
    
    // 启动FreeRTOS调度器
    vTaskStartScheduler();

    /* 如果程序运行到这里，说明系统出错 */
    printf("Scheduler start failed!\r\n");

    // 如果调度器启动成功，以下代码不会运行    
	while(1)
	{
		GPIO_SetBits(GPIOB, GPIO_Pin_2);
		printf("LED On!\r\n");
		delay_ms(100);
		
		GPIO_ResetBits(GPIOB, GPIO_Pin_2);
		printf("LED Off!\r\n");
		delay_ms(100);
	}
	

}
