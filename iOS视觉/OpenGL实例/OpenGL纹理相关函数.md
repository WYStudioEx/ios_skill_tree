## 像素图

**像素存储方式**

//改变像素存储方式
void glPixelStorei(GLenum pname,GLint param);

//恢复像素存储方式
void glPixelStoref(GLenum pname,GLfloat param);

```
//举例:
//参数1:GL_UNPACK_ALIGNMENT 指定OpenGL 如何从数据缓存区中解包图像 数据
//参数2:表示参数GL_UNPACK_ALIGNMENT 设置的值
//GL_UNPACK_ALIGNMENT 指内存中每个像素行起点的排列请求，允许设置为1 (byte排列)、2(排列为偶数byte的行)、4(字word排列)、8(⾏从双字节边界开始)
glPixelStorei(GL_UNPACK_ALIGNMENT,1);
```

**OpenGL 的像素格式**：

| 常量量 | 描述 |
| :--: | :--: |
| GL_RGB             | 描述红、绿、蓝顺序排列的颜⾊       |
| GL_RGBA            | 按照红、绿、蓝、Alpha顺序排列的颜⾊ |
| GL_BGR             | 按照蓝、绿、红顺序排列颜⾊  |
| GL_BGRA            | 按照蓝、绿、红、Alpha顺序排列颜⾊	|
| GL_RED             | 每个像素只包含了一个红色分量  |
| GL_GREEN           | 每个像素只包含了一个绿⾊分量  |
| GL_BLUE            | 每个像素只包含了一个蓝⾊分量	 |
| GL_RG              | 每个像素依次包含了一个红色和绿⾊的分量	|
| GL_RED_INTEGER     | 每个像素包含了一个整数形式的红色分量	 |
| GL_GREEN_INTEGER   | 每个像素包含了一个整数形式的绿色分量  |
| GL_BLUE_INTEGER    | 每个像素包含了一个整数形式的蓝⾊分量	 |
| GL_RG_INTEGER      | 每个像素依次包含了一个整数形式的红⾊、绿⾊分量  |
| GL_RGB_INTEGER     | 每个像素包含了一个整数形式的红色、蓝色、绿⾊分量	 |
| GL_RGBA_INTEGER    | 每个像素包含了一个整数形式的红色、蓝色、绿⾊、Alpah分量 |
| GL_BGR_INTEGER     | 每个像素包含了一个整数形式的蓝色、绿色、红色分量	 |
| GL_BGRA_INTEGER    | 每个像素包含了一个整数形式的蓝色、绿色、红色、Alpah分量 |
| GL_STENCIL_INDEX   | 每个像素只包含了一个模板值 	|
| GL_DEPTH_COMPONENT | 每个像素值包含⼀个深度值  |
| GL_DEPTH_STENCIL   | 每个像素包含一个深度值和⼀个模板值 |

**像素数据的数据类型**：

![image-20220729154923497](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220729154923497.png)

指定分量RGBA的排列顺序根据format参数确定。分量是按照分量高位到低位排列

### 从颜⾊色缓存区读取像素图

**glReadPixels**

```
认识函数 从颜⾊缓存区内容作为像素图直接读取
//参数1:x,矩形左下⻆的窗⼝坐标
//参数2:y,矩形左下角的窗口坐标
//参数3:width,矩形的宽，以像素为单位 
//参数4:height,矩形的⾼，以像素为单位
//参数5:format,OpenGL 的像素格式，参考下表
//参数6:type,解释参数pixels指向的数据，告诉OpenGL 使⽤缓存区中的什么数据类型来存储颜色分量，像素数据的数据类型，参考下图
//参数7:pixels,指向图形数据的指针

void glReadPixels(GLint x,GLint y,GLSizei width,GLSizei height, GLenum format, GLenum type,const void *pixels);

glReadBuffer(mode);—> 指定读取的缓存 
glWriteBuffer(mode);—> 指定写⼊入的缓存
```

### 从TGA⽂件中读取像素图

gltReadTGABits

```
参数1: 纹理文件名称
参数2: ⽂件宽度地址 
参数3: ⽂件高度地址 
参数4: ⽂件组件地址 
参数5: ⽂件格式地址 
返回值:pBits,指向图像数据的指针

GLbyte *gltReadTGABits(const char *szFileName, GLint *iWidth, GLint *iHeight, GLint
*iComponents, GLenum *eFormat);
```

## 载入纹理

```
void glTexImage1D(GLenum target,GLint level,GLint internalformat,GLsizei width,GLint border,GLenum format,GLenum type,void *data);
     
void glTexImage2D(GLenum target,GLint level,GLint internalformat,GLsizei width,GLsizei height,GLint border,GLenum format,GLenum type,void * data);

void glTexImage3D(GLenum target,GLint level,GLint internalformat,GLSizei width,GLsizei height,GLsizei depth,GLint border,GLenum format,GLenum type,void *data);
```

* target:`GL_TEXTURE_1D`、`GL_TEXTURE_2D`、`GL_TEXTURE_3D`。
* Level:指定所加载的mip贴图层次。⼀般我们都把这个参数设置为0。
* internalformat:每个纹理单元中存储多少颜色成分。
* width、height、depth参数:指加载纹理的宽度、⾼度、深度。==注意!==这些值必须是 2的整数次方。(这是因为OpenGL 旧版本上的遗留下的⼀个要求。当然现在已经可以⽀持不是 2的整数次方。但是开发者们还是习惯使用以2的整数次方去设置这些参数。)
* border参数:允许为纹理贴图指定一个边界宽度。
* format、type、data参数:与我们在讲glDrawPixels 函数对于的参数相同

## 更新纹理

```C
void glTexSubImage1D(GLenum target,GLint level,GLint xOffset,GLsizei width,GLenum format,GLenum type,const GLvoid *data);

void glTexSubImage2D(GLenum target,GLint level,GLint xOffset,GLint yOffset,GLsizei width,GLsizei height, GLenum format,GLenum type,const GLvoid *data);

void glTexSubImage3D(GLenum target,GLint level,GLint xOffset,GLint yOffset,GLint zOffset,GLsizei width, GLsizei height, GLsizei depth,Glenum type,const GLvoid * data);
```

## 插入替换纹理

```c
void glCopyTexSubImage1D(GLenum target,GLint level,GLint xoffset,GLint x,GLint y,GLsize width);

void glCopyTexSubImage2D(GLenum target,GLint level,GLint xoffset,GLint yOffset, GLint x, GLint y,GLsizei width,GLsizei height);

void glCopyTexSubImage3D(GLenum target,GLint level,GLint xoffset,GLint yOffset,GLint zOffset,GLint x,GLint y,GLsizei width,GLsizei height);
```

## 使⽤颜⾊缓存区加载数据**,**形成新的纹理使⽤

```c
void glCopyTexImage1D(GLenum target,GLint level,GLenum internalformt,GLint x,GLint y,GLsizei width,GLint border);
  
void glCopyTexImage2D(GLenum target,GLint level,GLenum internalformt,GLint x,GLint y,GLsizei width,GLsizei height,GLint border);
```

- x,y 在颜⾊缓存区中指定了开始读取纹理数据的位置; 
- 缓存区里的数据，是源缓存区通过glReadBuffer设置的

不存在**glCopyTextImage3D** ，因为我们无法从2D 颜⾊缓存区中获取体积数据。

## 纹理对象

分配纹理对象

绑定纹理状态

删除绑定纹理对象

测试纹理对象是否有效

```
//使⽤函数分配纹理对象
//指定纹理对象的数量 和 指针(指针指向⼀个⽆符号整形数组，由纹理对象标识符填充)。 
void glGenTextures(GLsizei n,GLuint * textTures);

//绑定纹理状态 
//参数target:GL_TEXTURE_1D、GL_TEXTURE_2D、GL_TEXTURE_3D
//参数texture:需要绑定的纹理对象
void glBindTexture(GLenum target,GLunit texture);

//删除绑定纹理对象
//纹理对象 以及 纹理对象指针(指针指向⼀个⽆符号整形数组，由纹理对象标识符填充)。
void glDeleteTextures(GLsizei n,GLuint *textures); 

//测试纹理对象是否有效
//如果texture是⼀个已经分配空间的纹理对象，那么这个函数会返回GL_TRUE,否则会返回GL_FALSE。 
GLboolean glIsTexture(GLuint texture);
```

## 设置纹理参数

```
glTexParameterf(GLenum target,GLenum pname,GLFloat param);
glTexParameteri(GLenum target,GLenum pname,GLint param);
glTexParameterfv(GLenum target,GLenum pname,GLFloat *param);
glTexParameteriv(GLenum target,GLenum pname,GLint *param);
```

- **1:target,**指定这些参数将要应⽤在那个纹理模式上，⽐比如**GL_TEXTURE_1D**、**GL_TEXTURE_2D**、**GL_TEXTURE_3D**。
- **2:pname,**指定需要设置那个纹理参数
- **3:param,**设定特定的纹理参数的值

### 设置过滤方式：

邻近过滤

![image-20220729172942539](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220729172942539.png)

线性过滤

![image-20220729173000192](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220729173000192.png)

两种纹理方式对比

![image-20220729173128356](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220729173128356.png)

```
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST) 
//纹理理缩⼩小时,使⽤用邻近过滤

glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR) 
//纹理理放⼤大时,使⽤用线性过滤

glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
```

### 设置环绕方式

![image-20220729173224644](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220729173224644.png)

![image-20220729173252059](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220729173252059.png)

```
glTextParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAR_S,GL_CLAMP_TO_EDGE);

glTextParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAR_T,GL_CLAMP_TO_EDGE);
```

- 参数1:GL_TEXTURE_1D、GL_TEXTURE_2D、GL_TEXTURE_3D 
- 参数2:GL_TEXTURE_WRAP_S、GL_TEXTURE_T、GL_TEXTURE_R,针对s,t,r坐标 
- 参数3:GL_REPEAT、GL_CLAMP、GL_CLAMP_TO_EDGE、GL_CLAMP_TO_BORDER
  - GL_REPEAT:OpenGL 在纹理坐标超过1.0的⽅向上对纹理进⾏重复; 
  - GL_CLAMP:所需的纹理单元取⾃纹理边界或TEXTURE_BORDER_COLOR. 
  - GL_CLAMP_TO_EDGE环绕模式强制对范围之外的纹理坐标沿着合法的纹理单元的最后⼀行或者最后⼀列来进行采样。 
  - GL_CLAMP_TO_BORDER:在纹理坐标在0.0到1.0范围之外的只使⽤边界纹理单元。边界纹理单元是作为围绕基本图像的额外的行和列，并与基本纹理图像⼀起加载的。


## 绘制金字塔

![image-20220729174042249](/Users/xyj/Library/Application Support/typora-user-images/image-20220729174042249.png)

```
三⻆角形X的坐标如下: 
vBackLeft(-1.0,-1.0,-1.0)
vBackRight(1.0,-1.0,-1.0) 
vFrontRight(1.0,-1.0,1.0)

三⻆角形Y的坐标如下: 
vFrontLeft(-1.0,-1.0,1.0)
vBackLeft(-1.0,-1.0,-1.0) 
vFrontRight(1.0,-1.0,1.0)

顶点坐标:
VBackLeft (-1.0,-1.0,-1.0) 
VBackRight (1.0,-1.0,-1.0) 
vFrontLeft (-1.0,-1.0,1.0) 
VFrontRight(1.0,-1.0,1.0) 
vApex (0,1.0,0)

纹理理坐标! 
VBackLeft ( 0,0,0)
VBackRight (0,1,0) 
vFrontLeft (0,0,1) 
VFrontRight (0,1,1) 
vApex (0,0.5,1)
```

## 设置Mip贴图

```
//设置mip贴图基层 
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_BASE_LEVEL,0); 

//设置mip贴图最⼤大层 
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAX_LEVEL,0);
```
经过Mip贴图的纹理过滤

| 常量量                    | 描述                                                       |
| ------------------------- | ---------------------------------------------------------- |
| GL_NEAREST                | 在Mip基层上执行最邻近过滤                                  |
| GL_LINEAR                 | 在Mip基层执行线性过滤                                      |
| GL_NEAREST_MIPMAP_NEAREST | 在最邻近Mip层，并执行最邻近过滤                            |
| GL_NEAREST_MIPMAP_LINEAR  | 在Mip层之间执⾏线性插补，并执⾏最邻近过滤                  |
| GL_LINEAR_MIPMAP_NEAREST  | 选择最邻近Mip层，并执⾏线性过滤                            |
| GL_LINEAR_MIPMAP_LINEAR   | 在Mip层之间执⾏线性插补，并执⾏线性过滤，⼜称三线性Mip贴图 |

## 压缩纹理

通用压缩纹理格式

| 压缩格式 | 基本内部格式 |
| ----| ---- |
| GL_COMPRESSED_RGB        | GL_RGB       |
| GL_COMPRESSED_RGBA       | GL_RGBA      |
| GL_COMPRESSED_SRGB       | GL_RGB       |
| GL_COMPRESSED_SRGB_ALPHA | GL_RGBA      |
| GL_COMPRESSED_RED        | GL_RED       |
| GL_COMPRESSED_RG         | GL_RG        |

### 判断压缩与选择压缩方式

```
GLint comFlag;
//判断纹理理是否被成功压缩 
glGetTexLevelParameteriv(GL_TEXTURE_2D,0,GL_TEXTURE_COMPRESSED,&comFlag);

//根据选择的压缩纹理理格式，选择最快、最优、⾃自⾏行行选择的算法⽅方式选择压缩格式。 glHint(GL_TEXTURE_COMPRESSION_HINT,GL_FASTEST);
glHint(GL_TEXTURE_COMPRESSION_HINT,GL_NICEST);
glHint(GL_TEXTURE_COMPRESSION_HINT,GL_DONT_CARE);
```

### 加载压缩纹理

```c
void glCompressedTexImage1D(GLenum target,GLint level,GLenum internalFormat,GLsizei width,GLint border,GLsizei imageSize,void *data);
 
void glCompressedTexImage2D(GLenum target,GLint level,GLenum internalFormat,GLsizei width,GLint heigth,GLint border,GLsizei imageSize,void *data);

void glCompressedTexImage3D(GLenum target,GLint level,GLenum internalFormat,GLsizei width,GLsizei heigth,GLsizei depth,GLint border,GLsizei imageSize,void *data);
```

- target:`GL_TEXTURE_1D`、`GL_TEXTURE_2D`、`GL_TEXTURE_3D`。
- Level:指定所加载的mip贴图层次。一般我们都把这个参数设置为0。 
- internalformat:每个纹理单元中存储多少颜色成分。 
- width、height、depth参数:指加载纹理的宽度、⾼度、深度。
- border参数:允许为纹理贴图指定一个边界宽度。 
- format、type、data参数:与我们在讲glDrawPixels 函数对于的参数相同

**glGetTexLevelParameter** 函数提取的压缩纹理格式

| 参数  | 返回   |
| ---- | ---- |
| GL_TEXTURE_COMPRESSED             | 如果纹理理被压缩，返回1，否则返回0 |
| GL_TEXTURE_COMPRESSED_IMAGE_SIZE  | 压缩后的纹理理的⼤大⼩小(以字节为单位)  |
| GL_TEXTURE_INTERNAL_FORMAT        | 所使⽤用的压缩格式  |
| GL_NUM_COMPRESSED_TEXTURE_FORMATS | 受⽀支持的压缩纹理理格式数量量 |
| GL_COMPRESSED_TEXTURE_FORMATS     | ⼀一个包含了了⼀一些常量量值的数组，每个常量量值对应于⼀一种受⽀支持的压缩纹理理格式 |
| GL_TEXTURE_COMPRESSION_HINT       | 压缩纹理理提示的值(GL/NICEST/GL_FASTEST)                     |

**GL_EXT_texture_compression_s3tc**压缩格式

| 格式 | 描述 |
| ---- | ---- |
| GL_COMPRESSED_RGB_S3TC_DXT1  | RGB数据被压缩，alpha值始终是1.0                 |
| GL_COMPRESSED_RGBA_S3TC_DXT1 | RGBA数据被压缩，alpha值返回1.0或者0.0           |
| GL_COMPRESSED_RGAB_S3TC_DXT3 | RGB值被压缩，alpha值⽤用4位存储                 |
| GL_COMPRESSED_RGBA_SETC_DXT5 | RGB数据被压缩，alpha值是⼀一些8位值的加权平均值 |

## 使用纹理

```
//1. 读取文件!
void glReadPixels(GLint x,GLint y,GLSizei width,GLSizei height, GLenu m format, GLenum type,const void * pixels);

//2. 载入纹理
void glTexImage2D(GLenum target,GLint level,GLint internalformat,GLsi zei width,GLsizei height,GLint border,GLenum format,GLenum type,void * data);

//3. 纹理对象
// 使用函数分配纹理对象
// 指定纹理对象的数量和指针（指针指向一个无符号整形数组，由纹理对象标识符填充）
void glGenTextures(GLsizei n,GLuint * textTures);

//绑定纹理对象
//参数target:GL_TEXTURE_1D、GL_TEXTURE_2D、GL_TEXTURE_3D 
//参数texture:需要绑定的纹理对象
void glBindTexture(GLenum target,GLunit texture);

//删除绑定纹理对象
//纹理对象 以及 纹理对象指针（指针指向一个无符号整形数组，由纹理对象标识符填充）
void glDeleteTextures(GLsizei n,GLuint *textures);

//测试纹理对象是否有效 
//如果texture是一个以及分配空间的纹理对象，那么这个函数会返回GL_TRUE,否者会返回GL_FALSE
GLboolean glIsTexture(GLuint texture);

//设置纹理的相关参数!
//放大/缩小过滤(临近过滤,线性过滤) 
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST); glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);

glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

//设置X轴/Y轴上的环绕方式.
//x,y,z,w
//s,t,r,q 
glTextParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAR_S,GL_CLAMP_TO_EDGE); glTextParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAR_T,GL_CLAMP_TO_EDGE);
```







