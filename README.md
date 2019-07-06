![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016110201.png)

[![Language: Objective-C](https://img.shields.io/badge/language-Objective%20C-orange.svg?style=flat)](https://developer.apple.com/reference/objectivec) [![Platform](https://img.shields.io/cocoapods/p/YJCocoa.svg?style=flat)](http://cocoadocs.org/docsets/YJCocoa) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/937447974/YJCocoa/blob/master/LICENSE) [![CocoaPods](https://img.shields.io/cocoapods/v/YJCocoa.svg?style=flat)](http://cocoapods.org) ![Apps](https://img.shields.io/cocoapods/at/YJCocoa.svg?style=flat) ![QQ群](https://img.shields.io/badge/QQ群-557445088-blue.svg?style=flat)

YJ系列开源库

1. 支持 iOS 9.0 和 Swift 5 开发。
2. 按需加载，可根据自己的需求加载不同的开源库。

整体架构和苹果类似,每一层都有各自的开源库。

# 1 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101001.png)AppFrameworks

## 1.1 Foundation

### 1.1.1 Calendar

日历工具，快速获取天、时、分等。

### 1.1.2 Directory

快速获取应用内目录

### 1.1.3 Extension

Foundation 相关扩展

### 1.1.4 JSONModel

快速高效的转换模型和 Model。

### 1.1.2 Cache

Cache 缓存工具，在 NSCache 的基础上增加了 NSDictionary 的相关功能。

### 1.1.4  CodeInject

编译时注入代码，运行时提取函数或 Block 执行，一站式解决 APP 启动卡顿问题。

### 1.1.5 Log

1. NSLog打印优化，Unicode自动转化为中文输出。
2. YJLog 日志输出，支持自定义日志级别输出内容。

### 1.1.6 Safety

保护 APP 稳定运行，不 crash。

### 1.1.7 Scheduler

Scheduler 调度器，一站式解决代码耦合问题。

### 1.1.8 SingletonCenter

单例控制中心，可定制全局单例和局域单例。

### 1.1.9 Timer

替换NSTimer实现相关计时器功能。

多种生命周期：

1. 随着应用的回收而回收。
2. 随着当前使用类的回收而回收。如VC回收时，YJSTimer也会回收。

### 1.1.10 URL

1. URLEncode编码和URLDecode解码；
2. http链接解析，快速获取其中参数，支持URLDecode解码;
3. http链接组装，快速组装相关参数，支持URLEncode编码。

### 1.1.11 URLSession

大型APP网络架构，具有以下特性：

1. 兼容市面上任何一款网络SDK,并可以多个SDK协同工作；
2. 多种设计模式，按照项目需要随意组装架构；
3. 多种请求方式，可以面向接口请求服务器或面向对象请求服务器；
4. 支持网络重连。

## 1.2 UIKit

### 1.2.1 CollectionViewManager

UICollectionView封装

1. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为UICollectionView的控制中心使用。
2. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UICollectionViewCell的相关显示，缓存。UIViewController与UICollectionViewCell完全隔离。
3. 自带存储数据源，支持单数组和多数组显示的数据源。
4. 自动将数据从UIViewController传输到UICollectionViewCell，支持任意数据类型的传输。
5. 支持多种创建UICollectionViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。
6. 自动register注册UICollectionViewCell，自动显示UICollectionViewCell，自动缓存UICollectionViewCell。
7. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。
### 1.2.2 Extension

UIKit 相关扩展
### 1.2.3 NavigationBar

NavigationBar 主要用于配置导航按钮。
### 1.2.4 PageView

PageView 主要实现对 UIPageViewController 的封装，支持轮播图、导航图、小说翻页等多种翻页模式。

1. 多种配置模式适应任何多页面需求。
2. 任何间隔切换VC，内存释放稳定。
### 1.2.5 ScrollView

ScrollView 主用用于监听 UIScrollView 的滚动状态。
### 1.2.6 TableView

UITableView管理器

1. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为TableView的控制中心使用。
2. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UITableViewCell的相关显示，缓存。UIViewController与UITableViewCell完全隔离。
3. 自带存储数据源，支持UITableViewStylePlain和UITableViewStyleGrouped显示的数据源。
4. 自动将数据从UIViewController传输到UITableViewCell，支持任意数据类型的传输。
5. 自动register注册UITableViewCell，自动显示UITableViewCell，自动缓存UITableViewCell。
6. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。
### 1.2.7 URLRouter

URLRouter 主要通过路由跳转实现项目组件化

1. 自动注入，无需考虑加载时机。
2. 支持拦截处理未注入的url。
### 1.2.8 ViewControllerTransitioning

UIViewController 和 UINavigationController 转场动画自定义。

# 2 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101006.png)DeveloperTools

## 2.1 Leaks

内存泄漏分析器，用于捕获项目中有内存泄漏的UIViewController、UIView和Property属性。

## 2.2 MemoryInfo

主要用于获取运行过程中的RAM相关信息，如剩余内存。

## 2.3 Timeline

时间轴记录器，记录操作的耗时时间，主要用于启动优化。

## 2.4 TimeProfiler

时间分析器，主要用于分析引起主线程卡顿的代码。

1. 支持定制模块分析。
2. 支持设置分析频率和帧间隔。
3. 控制台打印 VC 加载时间。

# 3 OC

通过 Objective-C 代码实现的相关组件。

# 4 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101005.png)System

## 4.1 Dispatch

GCD 相关封装

## 4.2 Pthread

pthread 锁相关封装

## 4.2 Security

### 4.2.1 Keychain

面向对象管理 Keychain，支持自定义存储数据。

### 4.2.2 Random

快速生成指定位数的随机密码。

----------

# <a id="Appendix">Appendix

## Author

姓名：阳君

QQ：937447974

YJ技术支持群：557445088

如果你觉得这个框架很赞，请点击右上角的 Star 按钮；如果你对我的框架感兴趣，并想持续获得本人最新的框架源文件，欢迎点击右上角的 Fork 按钮。

## Copyright 2016-Now

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974


