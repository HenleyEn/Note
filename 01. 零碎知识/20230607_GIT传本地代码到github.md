# GIT传本地代码到github

## 1、 创建github repository仓库

### 1.1 登录github

在网页中登录github

### 1.2 创建远程仓库

<img src="D:\MarkdowPad2_md\随手记\images\image-20230408200903340.png" alt="image-20230408200903340" style="zoom:80%;" />

直接**New**一个新的仓库；

同时github提示相关指令：

```text
git init //把这个目录变成Git可以管理的仓库
git add README.md //文件添加到仓库（README.md是需要增加的文件）
git add . //不但可以跟单一文件，还可以跟通配符，更可以跟目录。一个点就把当前目录下所有未追踪的文件全部add了 
git commit -m "first commit" //把文件提交到仓库（“”双引号中包含的是日志）
git remote add origin git@github.com:HenleyEn/gitTest.git //关联远程仓库（关联远程仓库）
git push -u origin main //把本地库的所有内容推送到远程库上（以前是master，现在传在main分支）
```

## 2、创建本地仓库

直接在本地的电脑路径中找到需要上传的文件夹，选择**”Git Bash Here“**

<img src="D:\MarkdowPad2_md\随手记\images\image-20230408202020062.png" alt="image-20230408202020062" style="zoom:80%;" />

进入bash

<img src="D:\MarkdowPad2_md\随手记\images\image-20230408202309929.png" alt="image-20230408202309929" style="zoom:80%;" />

执行

```text
git init
git commit -m ”first commit“		//引号内是日志
```

本地仓库便建好了。

## 3、关联远程仓库

<img src="D:\MarkdowPad2_md\随手记\images\image-20230408202602406.png" alt="image-20230408202602406" style="zoom:80%;" />

复制ssh，再执行

```text
git remote add origin git@github.com:HenleyEn/gitTest.git		//origin后接仓库的ssh
```

## 4、上传代码

执行

```text
git push -u origin main 			//main是一个仓库分支
```

<img src="D:\MarkdowPad2_md\随手记\images\image-20230408203217792.png" alt="image-20230408203217792" style="zoom:80%;" />

此时，将代码上传至github。

若遇到报错则执行
```text
git push -u origin main -f
```


遇到网络超时问题，原因：**这样的问题往往是由于网络慢访问超时，这时候我们可以在终端选择使用设置代理和取消代理的命令解决。**

步骤：

1、设置代理：

```text
git config --global https.proxy
```

2、取消代理

```text
git config --global --unset http.proxy 
git config --global --unset https.proxy
```

3、再运行

```text
git push -u origin main
```





## 5、其他技巧

### 5.1 冲突

