## math3d库向量

math3d库包含两个数据类型

- M3DVector3f 三维向量  (x, y, z)
- M3DVector4f 四维向量（x, y, z, w）

在典型情况下，w 坐标设为1.0。x,y,z值通过除以w，来进行缩放。⽽除以1.0则本质上不改变x,y,z值。

```
typedef float M3DVector3f[3];
typedef float M3DVector4f[4];

// 声明⼀个三维向量操作:
M3DVector3f vVector;
// 类似，声明⼀个四维向量的操作:
M3DVector4f vVectro= {0.0f,0.0f,1.0f,1.0f};

// 声明⼀个三维向量顶点数组，例如⽣成⼀个三角形
M3DVector3f vVerts[] = {
	-0.5f, 0.0f, 0.0f,
	0.5f, 0.0f, 0.0f,
	-0.0f, 0.5f, 0.0f,
};
```

## 向量

向量大小

标量与向量乘法

标量与向量的除法

标准化向量

向量加减法

## 向量点乘

向量的点乘,也叫向量的内积、数量积，对两个向量执行点乘运算，就是对这两个向量对应位一一相乘之后求和的操作，点乘的结果是一个标量。

例如：向量a和向量b

- a=[a1, a2, a3, ...an];
- b=[b1, b2, b3, ...bn];
- a和b点乘 = a1b1 + a2b2 + a3b3 + ... + anbn;

**几何意义：**

点乘的几何意义是可以用来表征或计算两个向量之间的**夹角**，以及在b向量在a向量方向上的投影

**公式：**

![img](https://img-blog.csdn.net/20160902220238078)

结论：

- a·b>0   方向基本相同，夹角在0°到90°之间   
- a·b=0   正交，相互垂直  
- a·b<0   方向基本相反，夹角在90°到180°之间

```
//实现点乘⽅法: 
//⽅法1:返回的是-1，1之间的值。它代表这个2个向量的余弦值。
float m3dDotProduct3(const M3DVector3f u,const M3DVector3f v);

//⽅法2:返回2个向量之间的弧度值。
float m3dGetAngleBetweenVector3(const M3DVector3f u,const M3DVector3f v);
```

## 向量叉乘

叉乘的运算结果是一个向量而不是一个标量。结果向量与这两个向量组成的坐标平面垂直。

**公式：**

![img](https://img-blog.csdn.net/20160902230539163)

![img](https://img-blog.csdn.net/20160902231520146)

其中i，j，k

![img](https://img-blog.csdn.net/20160902231657984)

根据i、j、k间关系，有：

![img](https://img-blog.csdn.net/20160902232255082)

**在二维空间中，叉乘还有另外一个几何意义就是：aXb等于由向量a和向量b构成的平行四边形的面积。**

```
void m3dCrossProduct3(M3DVector3f result,const M3DVector3f u ,const M3DVector3f v);
```

## OpenGL 矩阵

- typedef float M3DMatrix33f[9];
- typedef float M3DMatrix44f[16];

![image-20220726074901432](http://xingyajie.oss-cn-hangzhou.aliyuncs.com/uPic/image-20220726074901432.png)

**对角线元素**：行号等于列号的元素

**单元矩阵**：对角线元素为1，其他元素为0

任何矩阵乘以单元矩阵，结果都是他本身

**方阵**：行数和列数相同的矩阵

**矩阵乘法**：标量与矩阵，矩阵与矩阵

- 当矩阵A的列数（column）等于矩阵B的行数（row）时，A与B**可以相乘**。
- 任意矩阵M乘以方阵S,不管从哪边乘，都得到与原矩阵⼤小相同的矩阵。当然，前提是假定乘法有意义。如果S是单位 矩阵，结果就是原矩阵M，即:MI = IM = M 
- 矩阵乘法不满⾜交换律，即:AB != BA
- 矩阵乘法满⾜结合律，即:(AB)C = A(BC)。假定ABC的维数使得其乘法有意义，要注意如果(AB)C有意义，那么A(BC)就⼀定有意义。
- 矩阵乘法也满⾜与标量或向量的结合律律，即:(kA)B = k(AB) = A(kB); (vA)B = v(AB);
- 矩阵积的转置相当于先转置矩阵然后以相反的顺序乘法，即:(AB)T = BT AT

## 向量与矩阵乘法