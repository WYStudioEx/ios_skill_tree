## Engine安装

### 工具：

1、下载Chromium提供的部署工具[depo_tools](https://chromium.googlesource.com/chromium/tools/depot_tools/)

```
git clone https://chromium.googlesource.com/chromium/tools/depot_tools
```

2、配置depo_tools的环境变量

```
open ~/.bash_profile

export PATH=/opt/depot_tool/:$PATH
```

3、安装ant编译工具

```
brew install ant
```

### 下载引擎

1、新建目录

```
mkdir engine
```

2、创建gclien文件。

`flutter/engine`需要通过`gclient`工具获取，因为`engine`有很多依赖，`gclient`可以很好地处理这些依赖，简化源码管理流程。

```
touch .gclient
```

3、配置文件

```
solutions = [
  {
    "managed": False,
    "name": "src/flutter", //指定仓库的存放位置
    "url": "git@github.com:flutter/engine.git@6bc433c6b6b5b98dcf4cc11aff31cdee90849f32", //制定将要下载的仓库地址,最好fork一份到自己仓库
    "custom_deps": {},
    "deps_file": "DEPS", // 指定存放第三方依赖的文件名。
    "safesync_url": "",
  },
]
```

4、在.gclient 文件所在的目录执行 sync 

```
gclient sync
```

5、成功后src/flutter中的部分目录结构

```
├── assets  #资源读取
├── common  #公共逻辑
├── flow  #渲染管道相关逻辑
├── flutter_frontend_server  #Dart构建相关逻辑
├── fml   #消息循环相关逻辑
├── lib   #Dart Runtime及渲染和Web相关逻辑
├── runtime  #Dart Runtime相关逻辑
├── shell
    ├──platform
        ├──android  #Android Embedder相关逻辑
        ├──common #Embedder公共逻辑
├── sky
├── testing  #测试相关
├── third_party
```

### 编译引擎代码

1、构建。此处./gn文件目录“engine/src/flutter/tools/gn”

不要直接使用gn命令，因为会使用depot_toolsde gn工具

```
# 构建iOS设备使用引擎
# 真机debug
./gn --ios --unoptimized
# 真机release
./gn --ios --unoptimized --runtime-mode=release 
# 模拟器版本
./gn --ios --simulator --unoptimized
# 主机端(Mac)构建
./gn --unoptimized
```

2、编译

```
ninja -C host_debug_unopt && ninja -C ios_debug_sim_unopt && ninja -C ios_debug_unopt && ninja -C ios_release_unopt
```

### 配置项目代码

iOS工程。在iOS工程中找到Generated.xcconfig文件，在里面添加两个环境变量

```
FLUTTER_ENGINE= ${引擎代码路径}/engine/src 
LOCAL_ENGINE=ios_debug_sim_unopt  # 使用引擎对应的版本
```

