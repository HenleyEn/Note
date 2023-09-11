# SPI

## 1、描述

### 1.1、连接方式

| 名称                                        | 描述                           |
| ------------------------------------------- | ------------------------------ |
| **MISO ( Master Input Slaver Output ), DI** | 主设备数据输出，从设备数据输入 |
| **MOSI (Master Output Slaver Input ), DO**  | 主设备数据输出，从设备数据输入 |
| **SCLK( Serial Clock), CLK**                | 时钟信号，主设备产生           |
| **SS( Serial Select ), CS(低电平有效)**     | 片选信号，主设备控制           |

![img](https://img-blog.csdn.net/20180515145056575)

- 输出引脚配置为**推挽输出**，输入引脚配置为**浮空或者上拉输入**；

- 当SS为高电平（未被选中），**（从机）**MISO必须为**高阻态**；

### 1.2、时序图

- 起始条件：SS从**高电平拉到低电平；**

- 停止条件：SS从**低电平拉到高电平；**

<img src="D:\MarkdowPad2_md\随手记\images\image-20230617191705250.png" alt="SS时序" style="zoom:80%;" />



```c
CPOL(时钟极性)
CPOL = 0;	//空闲状态时，SCK为低电平。
CPOL = 1;	//空闲状态时，SCK为高电平。

CPHA(时钟相位)
CPHA = 0;	//SCK第一个边沿移入数据，第二个边沿移出数据。
CPHA = 1;	//
```

- **以模式0为例：**



<img src="D:\MarkdowPad2_md\随手记\images\image-20230617193832624.png" alt="image-20230617193832624" style="zoom:80%;" />





- **模式1：**

<img src="D:\MarkdowPad2_md\随手记\images\image-20230617223508348.png" alt="image-20230617223508348" style="zoom:80%;" />



- **模式2**

<img src="D:\MarkdowPad2_md\随手记\images\image-20230617224112739.png" alt="image-20230617224112739" style="zoom:80%;" />



## 2、软件模拟（模式0）

### 2.0、通信引脚进行封装

```c
void MySPI_W_SS(uint8_t BitValue)
{
	GPIO_WriteBit(GPIOA, GPIO_Pin_4, (BitAction) BitValue);
}

void MySPI_W_MOSI(uint8_t BitValue)
{
	GPIO_WriteBit(GPIOA, GPIO_Pin_5, (BitAction) BitValue);
}

void MySPI_W_CLK(uint8_t BitValue)
{
	GPIO_WriteBit(GPIOA, GPIO_Pin_7, (BitAction) BitValue);
}

uint8_t MySPI_R_MISO(uint8_t BitValue)
{
	uint8_t data;
	data = GPIO_ReadInputDataBit(GPIOA, GPIO_Pin_6);

	return data;
}
```



### 2.1、GPIO初始化

```c
void MySPI_Init(void)
{
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_GPIOA, ENABLE);

	GPIO_InitTypeDef GPIO_InitStructure;

	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;			/* 推挽输出 */
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4 | GPIO_Pin_5 | GPIO_Pin_7;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;		/* 上拉输入*/
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	MySPI_W_SS(1);
	MySPI_W_CLK(0);
}
```

### 2.2、开始信号

```c
void my_spi_start(void)
{
	MySPI_W_SS(0);
}
```

### 2.3、停止信号

```c
void my_spi_stop(void)
{
	MySPI_W_SS(1);
}
```

### 2.4、交换数据

```c
uint8_t my_spi_swap_byte(uint8_t byte_send)
{
	uint8_t i;
	
	for(i = 0; i < 8;i++){
		MySPI_W_MOSI(byte_send & 0x80);
		byte_send <<= 1;
		MySPI_W_CLK(1);
		
		if(MySPI_R_MISO() == 1){
			byte_send |= 0x01;
		}
		MySPI_W_CLK(0);
	}
	return byte_send;
}
```

### 2.5、使用实例（w25q64）

```c
void w24q64_read_id(uint8_t *MID, uint16_t *DID)
{
    my_spi_start();
    my_spi_swap_byte(0x9F);			/* w24q64 读设备id的cmd */
    
    *MID = my_spi_swap_byte(0xff);		/* 只需要传无效数据进行交换便可 */
    *DID = my_spi_swap_byte(0xff);
    
    *DID << 8;
    *DID |= my_spi_swap_byte(0xff);
    
    my_spi_stop();
}
```



## 3、硬件流程（模式0）

### 3.1、硬件初始化

```c
void software_spi_init(void)
{
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_GPIOA, ENABLE);
	
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_SPI1, ENABLE);

	GPIO_InitTypeDef GPIO_InitStructure;

	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	/*
	 *	SCK : Pin_5
	 *	MOSI : Pin_7
	 */
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5 | GPIO_Pin_7;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);
	
	SPI_InitTypeDef SPI_InitStructure;

	SPI_InitStructure.SPI_Mode = SPI_Mode_Master;					/* 主机模式 */
	SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_128;	/* 波特率分频时钟 */
	SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;							/* 时钟极性，空闲时为低电平 */
	SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;						/* 时钟相位，在时钟第一个边沿进行采样 */
	SPI_InitStructure.SPI_CRCPolynomial = 7;							/* 没用上，设定默认值 7 */
	SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;					/* 数据大小设定为 8bit */
	SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;	/* 全双工，用于裁剪spi */
	SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;					/* 首位是高字节 */
	SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;							/* SS引脚软件控制 */

	SPI_Init(SPI1, &SPI_InitStructure);
	SPI_Cmd(SPI1,  ENABLE);
    
   	my_spi_stop();
	
}
```



### 3.2、交换字节

<img src="D:\MarkdowPad2_md\随手记\images\image-20230619004756562.png" alt="SPI硬件流程" style="zoom:80%;" />

```c
uint8_t software_spi_swap_data(uint8_t byte_send)
{
	uint8_t recv_data;
	while(SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_TXE) != SET);		/* 等待开始，标志为1时，表明发送缓冲区为空*/

	SPI_I2S_SendData(SPI1, byte_send);

    /* 发送完成即等于接收完成，标志为1时，表明接收缓冲区包含有效数据 */
	while(SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_RXNE) != SET);		

	recv_data = SPI_I2S_ReceiveData(SPI1);

	return recv_data;
}
```



## 4、例子

<img src="https://pic4.zhimg.com/v2-069df3709fb1a0c5486acbf620890313_r.jpg" alt="img" style="zoom:80%;" />

