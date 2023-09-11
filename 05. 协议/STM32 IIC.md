# STM32 IIC

## 1、通讯协议概况

![IIC](https://img-blog.csdnimg.cn/20210205164439326.png#pic_center)

数据线 SDA
时钟线 SCL

起始信号：SCL-高，SDA拉低；
停止信号：SCL-高，SDA拉高；
应答信号：数据接收完，CPU向外设发送**低电平**，等待外设应答。

## 2、数据有效性

![数据有效性](https://img-blog.csdnimg.cn/20210205170232689.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0MDExMTE2,size_16,color_FFFFFF,t_70#pic_center)

## 3、软件模拟

### 3.0、补充

STM32的一组GPIO有16个IO口，比如GPIOA这一组，有GPIOA0~GPIOA15一共16个IO口。每一个IO口需要寄存器的4位用来配置工作模式。

那么一组GPIO就需要16x4=64位的寄存器来存放这一组GPIO的工作模式的配置，但STM32的寄存器都是32位的，所以只能使用2个32位的寄存器来存放了。**CRL**用来存放**低八位的IO口（GPIOx0—GPIOx7）**的配置，CRH用来存放**高八位的IO口（GPIOx8—GPIOx15）**的配置。

这两个寄存器的全称是：**端口配置低寄存器(GPIOx_CRL) (x=A…E) 和 端口配置高寄存器(GPIOx_CRH) (x=A…E)。**

**也就是每一组GPIO都有两个32位的寄存器是用来配置IO口的工作模式的。**

```c
#define SDA_IN() 			    {IIC_Port->CRL &= 0x0FFFFFFF;IIC_Port->CRL |=(u32)8<<28;}
#define SDA_OUT() 			    {IIC_Port->CRL &= 0x0FFFFFFF;IIC_Port->CRL |=(u32)3<<28;}
#define READ_SDA            	GPIO_ReadInputDataBit(IIC_Port, IIC_SDA)

#define SCL_H               GPIO_SetBits(IIC_Port, IIC_SCL)
#define SCL_L               GPIO_ResetBits(IIC_Port, IIC_SCL)
#define SDA_H               GPIO_SetBits(IIC_Port, IIC_SDA)
#define SDA_L               GPIO_ResetBits(IIC_Port, IIC_SDA)
```

### 3.1、起始信号

起始信号：SCL-高，SDA拉低；

![img](https://img-blog.csdn.net/2018052517543199?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0NzUyMDcw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

```c
void I2C_Start(void)
{
    SCL_H;
    SDA_H;
    delay_us(5);
    
    SDA_L;
    delay_us(5);

    SCL_L;
}
```

### 3.2、停止信号

停止信号：SCL-高，SDA拉高；

![img](https://img-blog.csdn.net/2018052519484960?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0NzUyMDcw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

```c
void I2C_Stop(void)
{
    SDA_L;
    delay_us(5);
    
    SCL_H;
    delay_us(5);

    SDA_H;
}
```

### 3.3、应答信号

![img](https://img-blog.csdn.net/20180525200936792?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0NzUyMDcw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

```c
void I2C_Write_ACK(void)
{
    SCL_L;
	SDA_OUT();	//SDA设置为输出
	SDA_L;
	delay_us(2);
	SCL_H;
	delay_us(5);
	SCL_L;
}
```

### 3.4、非应答信号

![img](https://img-blog.csdn.net/20180525201813141?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0NzUyMDcw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

```c
void IIC_NAck(void)
{
	SCL_L;
	SDA_OUT();
	SDA_H;
	delay_us(2);
	SCL_H;
	delay_us(5);
	SCL_L;
}
```

### 3.5、等待应答信号

``` c
u8 I2C_Write_WaitToACK(void)
{
    u8 TimeErrAck = 0;
    SDA_IN();		//释放SDA总线
    SCL_H;			//拉高SCL，确保等待应答信号有效
    SDA_L;			//拉低SDA，接收外设应答
    delay_us(5);
    while(READ_SDA)
    {
        TimeErrAck++;
        if(TimeErrAck > 200)
        {
            I2C_Stop();
            return 1;		//超时等待，无应答
        }
    }
    SCL_L;					//拉低SCL
    return 0;			//有应答
}
```

### 3.6、写一个字节

```c
void I2C_Write_BYTE(u8 data)
{
    SCL_L;
    delay_us(4);
      
    /* 循环发送data
    *  当data = 01001011，data & 0x80 的目的是判断是0还是1
    *  通过判断，对SDA线进行拉高或者拉低操作
    */
	for(u8 i=0; i<8; i++)
    {
        SDA_OUT();				//输出模式
        if((data<<i) & 0x80)
            SDA_H;
        else 
            SDA_L;
		
        /* 产生一个脉冲，确保SDA数据线上的数据有效 */
        SCL_H;			
        delay_us(4);

        SCL_L;
        delay_us(4);
    }

}
```

### 3.7、读一个字节

```c
u8 IIC_Read_Data(void)
{
    u8 data;

    for(u8 i=0; i<8; i++)
    {
        SDA_IN();	//设置为输入模式
        SCL_H;		//时钟线拉高
        delay_us(4);

        data = data << 1;
        if(READ_SDA)
        {
            data |= 0x01; //读取SDA数据线上的值，进行赋值
        }

        SCL_L;
        delay_us(4);
    }

    return data;
}

```

## 4、硬件实现(以MPU6050为例)

### 4.1、初始化

STM32F103C8T6的IIC资源引脚使用**PB10，PB11**

具体其他信息查看数据手册。

```c
void HardWare_I2C_Init(void)
{
	RCC_APB1PeriphClockCmd( RCC_APB1Periph_I2C2, ENABLE);
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_GPIOB, ENABLE);

	GPIO_InitTypeDef GPIO_InitStructure;
		
	GPIO_InitStructure.GPIO_Pin = (GPIO_Pin_10 | GPIO_Pin_11);
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_OD;			//复用开漏推挽输出
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOB, &GPIO_InitStructure);

	I2C_InitTypeDef I2C_InitStructure;
    
	I2C_InitStructure.I2C_Mode = I2C_Mode_I2C;				//模式，主从模式
	I2C_InitStructure.I2C_Ack = I2C_Ack_Enable;				//应答使能
	I2C_InitStructure.I2C_ClockSpeed = 50000;				//SCL时钟速度
	I2C_InitStructure.I2C_DutyCycle = I2C_DutyCycle_2;		//占空比
	I2C_InitStructure.I2C_AcknowledgedAddress = I2C_AcknowledgedAddress_7bit;		//从机模式的地址格式地址
	I2C_InitStructure.I2C_OwnAddress1 = 0x00;					//设置地址
	
    I2C_Cmd(I2C2, ENABLE);
}
```

其中初始化结构体中的参数

```c
	I2C_InitStructure.I2C_ClockSpeed = 50000;				//SCL时钟速度
	I2C_InitStructure.I2C_DutyCycle = I2C_DutyCycle_2;		//占空比
```

- **I2C_InitStructure.I2C_ClockSpeed**有两种模式：标准模式（100KHZ以内），快速模式（100-400KHz）。不同模式下，占空比不同；
- **I2C_InitStructure.I2C_DutyCycle**（占空比）：为SCL时钟线的占空比，有**I2C_DutyCycle_2（ 2：1 ）**、**I2C_DutyCycle_16_9（ 16：9 ）**。

### 4.2、写寄存器

![主发送器序列图](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20230616170630423.png)

```c
void HardWare_I2C_SendData(uint8_t data)
{
	I2C_GenerateSTART(I2C2, ENABLE);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_MODE_SELECT != SUCCESS));	//EV5
/*
	I2C_Send7bitAddress(I2C2, Addr, I2C_Direction_Transmitter);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED != SUCCESS));		//EV6

	I2C_SendData(I2C2, Addr);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_BYTE_TRANSMITTING != SUCCESS));			//EV8
*/
	I2C_SendData(I2C2, data);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_BYTE_TRANSMITTED != SUCCESS));	//EV8_2

	I2C_GenerateSTOP(I2C2, ENABLE);
	
}
```

### 4.3、读寄存器

![主机接收序列](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20230616182655952.png)

```c
uint8_t HardWare_I2C_RecvData(uint8_t RegAddr)
{
	uint8_t data;

	I2C_GenerateSTART(I2C2, ENABLE);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_MODE_SELECT != SUCCESS));			//EV5

	I2C_Send7bitAddress(I2C2, DEVICE_ADDR, I2C_Direction_Transmitter);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED != SUCCESS));		//主机发送的EV6

	I2C_SendData(I2C2, RegAddr);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_BYTE_TRANSMITTED != SUCCESS));			//EV8_2

	
	I2C_GenerateSTART(I2C2, ENABLE);								//6050的 重复起始条件
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_MODE_SELECT != SUCCESS));				//EV5

	I2C_Send7bitAddress(I2C2, DEVICE_ADDR, I2C_Direction_Receiver);				//接收方向
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED != SUCCESS));	//主机接收的EV6

    //在数据接收前将ACK = 0，产生停止位
	I2C_AcknowledgeConfig(I2C2, DISABLE);
	I2C_GenerateSTOP(I2C2);
	while(I2C_CheckEvent(I2C2, I2C_EVENT_MASTER_BYTE_RECEIVED != SUCCESS));			//EV7

	data = I2C_ReceiveData(I2C2);

	I2C_AcknowledgeConfig(I2C2, ENABLE);				//保持ack = 1，确保有应答

	return data;
}
```

### 
