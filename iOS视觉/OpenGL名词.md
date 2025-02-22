## 状态机

记录对象在其⽣命周期内所经历的各种状态，或者根据输入改变对象的状态

特点：

- 记忆功能：记忆当前状态（如使用颜色、混合功能是否开启等）
- 接收输入：根据输入修改当前状态，且有相应输出
- 进入停机状态时，不再接受输入，且停止工作

OpenGL状态机：

- OpenGL可以记录⾃⼰的状态（如当前所使⽤的颜⾊、是否开启了混合 功能等）
- OpenGL可以接收输⼊（当调⽤OpenGL函数的时候，实际上可以看成 OpenGL在接收我们的输⼊），如我们调⽤glColor3f，则OpenGL接收到 这个输⼊后会修改⾃⼰的“当前颜⾊”这个状态；
- OpenGL可以进⼊停⽌状态，不再接收输⼊。在程序退出前，OpenGL总 会先停⽌⼯作的；

## OpenGL上下文 Context

上下⽂是OpenGL指令执⾏的基础。它是⼀个⾮常庞⼤的状态机，保存了OpenGL中的各种状态

OpenGL的函数本质上都是对OpenGL上下⽂这个庞⼤的状态机中的某个状态或者对象进⾏操作

存在的问题：反复上下文切换/大量修改渲染状态，导致GPU开销较大

- 针对不同模块，创建不同的context进行状态管理，context之间共享纹理、缓冲区等资源

## 渲染 Rendering

将图形/图像数据转换成3D空间图像操作叫做渲染(Rendering).

## 顶点数组和顶点缓冲区

顶点指的是我们在绘制⼀个图形时,它的顶点位置数据.⽽这个数据可以直接存储在数组中或者将其缓存到GPU内存中

顶点数据GPU处理

OpenGL中的图像都是由图元组成。在OpenGLES中，有3种类型的图 元：点、线、三⻆角形。

这些图元的存储：

- 开发者可以选择设定函数指针，在调⽤绘制⽅法的时候，直接由内存传⼊顶点数据，也就是说这部分数据之前是存储在内存当中的，被称为**顶点数组**。
- ⽽性能更⾼的做法是，提前分配⼀块显存，将顶点数据预先传⼊到显存当 中。这部分的显存，就被称为**顶点缓冲区**

## 管线、渲染流⽔线

渲染流⽔线分为两种，其中⼀种为**可编程渲染流⽔线**。另外⼀种为**固定渲染流水线**。(也称可编程管线或固定管线，管线就是流⽔线的意思)。渲染流水线可否编程，取决于程序猿能否在顶点着色器以及⽚段着⾊器上进⾏编码。⽽现在的渲染流⽔线，基本都是可编程的，当然，它们也支持固定渲染流水线的功能

在OpenGL 下渲染图形,就会有经历⼀个⼀个节点。这些结点按照固定的顺序一个一个执行

### 固定管线/存储着⾊器

一个封装了光照、坐标变换、裁剪等等诸多功能的Shader程序，开发者使用时，只需要传入相应参数，即可快速完成渲染。

## 着色器程序Shader

**Shader**，中⽂名，着⾊器。着⾊器其实就是⼀段在GPU运⾏的程序。我们平时的程序是在CPU运行。由于GPU的硬件设计结构与CPU有着很⼤的不同，所以GPU需要⼀些新的编程语⾔

常见的着⾊器主要有顶点着⾊器（VertexShader），⽚段着⾊器（FragmentShader）/像素着⾊器（PixelShader），⼏何着⾊器 （GeometryShader），曲⾯细分着⾊器（TessellationShader）。

直到OpenGLES3.0，依然只⽀持了顶点着⾊器和⽚段着⾊器这两个最基础的着⾊器。

## 顶点着色器VertexShader

OpenGL中用来处理顶点相关代码的程序

确定顶点位置，处理图形每个顶点变换(旋转/平移/投影等)，将顶点坐标由自身坐标系转换到归一坐标系

是逐顶点运行的程序，即每个顶点数据都会执行一次，且是并行的

## 片元着色器程序FragmentShader

⽚段着⾊器是OpenGL中⽤于计算⽚段（像素）颜⾊的程序。处理图形中每个像素点颜⾊计算和填充

每个像素都会执⾏⼀次⽚段着⾊器，当然也 是并⾏的

## GLSL【OpenGL Shading Language】

OpenGL中着色编程的语言

开发者可以使用该语言，自定义着色器

## 光栅化Rasterization

是把顶点数据转换为⽚元的过程。

将⼏何图元变为⼆维图像的过程。

光栅化过程产⽣的是⽚元。

物体的数学描述以及与物体相关的颜⾊信息转换为屏幕上⽤于对应位置的像素及⽤于填充像素的颜⾊

将模拟信号转化为离散信号的过程。

其中包含两个步骤：

- 决定窗⼝坐标中的哪些整型栅格区域被基本图元占⽤
- 分配⼀个颜⾊值和⼀个深度值到各个区域。

作⽤：具有将图转化为⼀个个栅格组成的图象

特点：是每个元素对应帧缓冲区中的⼀像素。

## 纹理

可以理解为图片

渲染图形时需要在其编码填充图⽚，这⾥使⽤的图⽚,就是常说的纹理.但是在OpenGL,我们更加习惯叫纹理,⽽不是图⽚.

### 图像存储空间

图像存储空间 = 图像高度 * 图像宽度 * 每个像素的字节数

## 混合

可以理解为两个图形/图像相交处的颜色，该颜色即为两个图形/图像颜色的混合。

混合的算法可以通过OpenGL的函数进⾏指定。或者通过像素着⾊器进⾏实现。但是像素着⾊器实现性能相对差点

## 变换矩阵 Transformation

处理图形平移,缩放,旋转变换

## 投影矩阵 Projection

将3D坐标转换为2D屏幕坐标时使用

## 渲染上屏/交换缓冲区SwapBuffer

渲染上屏：图像直接渲染到窗⼝对应的渲染缓冲区

渲染缓冲区：可以理解为是系统的资源，例如窗口

## 双缓冲区和垂直同步技术

双缓冲区解决问题：单缓冲区，在绘制过程中屏幕进⾏了刷新，窗⼝可能显示出不完整的图像

双缓冲区。显示在屏幕上的称为屏幕缓冲区，没有显示的称为离屏缓冲区。在⼀个缓冲区渲染完成之后，通过将屏幕缓冲区和离屏缓冲区交换，实现图像在屏幕上的显示。

垂直同步技术解决问题：防⽌交换缓冲区的时候屏幕上下区域的图像分属于两个不同的帧，因此交换⼀般会等待显示器刷新完成的信号，即垂直同步信号

## 三缓冲区技术

三缓冲区解决问题：使⽤了双缓冲区和垂直同步技术之后，由于总是要等待缓冲区交换之后再进⾏下⼀帧的渲染。

在等待垂直同步时，来回交替渲染两个离屏的缓冲区，⽽垂直同步发⽣时，屏幕缓冲区和最近渲染完成的离屏缓冲区交换，实现充分利⽤硬件性能的⽬的

## 2D/3D笛卡尔坐标系

![img](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/2-20220708143139089.png)

![img](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/2-20220708143139089.png)

**坐标裁剪：**`窗口是以像素为单位进行度量的`。开始在窗口中绘制点、线和形状之前，要把指定的笛卡尔坐标对翻译成屏幕坐标，我们可以通过指定占据窗口的笛卡尔区域来转换，这个区域叫做**裁剪区域**

**左右手坐标系：**

![image-20220708144710519](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220708144710519.png)

## 视口

视口（viewport）就是浏览器显示页面内容的屏幕区域。

视口可以分为布局视口、视觉视口和理想视口

在OpenGL中，视口就是窗口内部用于绘制裁剪区域的客户区域、

坐标系统从笛卡尔坐标到物理屏幕像素的映射是通过视口(viewport)的设置来指定

```
// 视口的设定通过glViewport()函数实现的：
void glViewport(GLint x,GLint y,GLint width,GLint ehignt);
//它设置窗口的左下角，以及宽度和高度。
```

视口一般和窗口是等比的

## 投影

透视投影和正投影

![image-20220708143945494](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220708143945494.png)

正投影(Orthographics Projection)或平行投影

- 视景体：正方形/长方形
- 不存在近大远小
- 适合平面图形/2D图形渲染

```
GLFrustum::SetOrthographic(GLfloat xMin, GLfloat xMax, GLfloat yMin, GLfloat yMax, GLfloat zMin, GLfloat zMax)
```

透视投影

- 视景体：平截体
- 近大远小
- 适合使3D图像渲染

```
GLFrustum::SetPerspective(**float** fFov, **float** fAspect, **float** fNear, **float** fFar)
```

setPerspective ⽅方法为我们构建⼀一个平截头体

![image-20220714174625193](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220714174625193.png)

参数：

- fFov:垂直⽅方向上的视场⻆角度 

- fAspect:窗⼝口的宽度与⾼高度的纵横⽐

- fNear:近裁剪⾯面距离 

- fFar:远裁剪⾯面距离

  纵横⽐ = 宽(w)/⾼高(h)

## 坐标系

OpenGL里每个顶点的x,y,z都应该在−1到1之间，超出这个范围的顶点将是不可见

共有5中比较重要的坐标系系统

- **局部空间(Local Space，或者称为物体空间(Object Space))**
- **世界空间(World Space)**
- **观察空间(View Space，或者称为视觉空间(Eye Space))**
- **裁剪空间(Clip Space)**
- **屏幕空间(Screen Space)**

坐标转换过程

![image-20220708151652305](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220708151652305.png)

### Model Matrix

模型变化，物体坐标转换为世界坐标，需要经历旋转+平移两个过程，为了方便其中加入了惯性坐标系。整个过程分为两步

1、物体坐标旋转后变成惯性坐标

2、惯性坐标平移后变成世界坐标

![img](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/70.jpeg)

### View Matrix

视变换，世界坐标转换为观察者坐标

### Projection Matrix

投影变换，观察者坐标转换为裁剪坐标

### ViewPort Transform

视口变换，裁剪坐标转换为屏幕坐标

其中分为两步：

1、perspective divide透视算法，将裁剪坐标转换为规范化设备坐标

2、viewport mapping 视口变化，将规范化设备坐标转换为屏幕坐标

### 开发者可操作部分

![image-20220708153135169](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220708153135169.png)

## OpenGL 变换

|   变换   |               应⽤               |
| :------: | :------------------------------: |
|   视图   |          指定观察者位置          |
|   模型   |         在场景中移动物体         |
| 模型视图 |    描述视图/模型变换的二元性     |
|   投影   | 改变视景体⼤小和设置它的投影⽅式 |
|   视⼝   | 伪变化,对窗口上最终输出进⾏缩放  |

![image-20220726165520953](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220726165520953.png)