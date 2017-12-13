![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016110201.png)

[![Language: Objective-C](https://img.shields.io/badge/language-Objective%20C-orange.svg?style=flat)](https://developer.apple.com/reference/objectivec) [![Platform](https://img.shields.io/cocoapods/p/YJCocoa.svg?style=flat)](http://cocoadocs.org/docsets/YJCocoa) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/937447974/YJCocoa/blob/master/LICENSE) [![CocoaPods](https://img.shields.io/cocoapods/v/YJCocoa.svg?style=flat)](http://cocoapods.org) ![Apps](https://img.shields.io/cocoapods/at/YJCocoa.svg?style=flat) ![QQ群](https://img.shields.io/badge/QQ群-557445088-blue.svg?style=flat)

YJ系列开源库

1. 支持 iOS 8.0 和 Swift 4.0 开发。
2. 按需加载，可根据自己的需求加载不同的开源库。

整体架构和苹果类似,每一层都有各自的开源库。

# 1 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101001.png)AppFrameworks

## 1.1 Foundation

### 1.1.1 AOP

AOP切面编程，将一对一的通信转换为一对多的通信。

### 1.1.2 Calendar

日历工具，快速将秒转换为天、时、分等。

### 1.1.3 DictionaryModel

快速高效的转换模型和Model。

### 1.1.4 Directory

快速获取应用内目录

### 1.1.5 FileManager

NSFileManager扩展，支持快速移动文件。主要是替换系统方法`moveItemAtPath:toPath:error:`和`moveItemAtURL:toURL:error:`

### 1.1.6 Http

1. http链接解析，快速获取其中参数，支持URLDecode解码;
2. http链接组装，快速组装相关参数，支持URLEncode编码。

### 1.1.7 KVO

1. 支持 Block 的方式监听 KeyValue 变化。
2. Observer 自动移除，无须手动调用 `removeObserver: forKeyPath:`移除。

### 1.1.8 Log

NSLog打印优化，Unicode自动转化为中文输出。

### 1.1.9 PerformSelector

合并 respondsToSelector 和 performSelector 方法，用于安全执行 Selector，可携带多个参数

### 1.1.10 Router

Router 是 NavigationRouter 的基础库，主要用于实现组件化开发，也可定制组件化开发方案。

1. 支持 Get 或 Post 跳转。
2. 支持长连接或短连接。
3. 支持作用域控制，单例模式，原型模式和内存警告模式。
	1. 单例模式：项目中只存在一份对应的控制器。
	2. 原型模式：每次跳转时都会重新创建一份对应的控制器。
	3. 内存警告模式：内存警告时，释放相关联的控制器。

### 1.1.11 Singleton

1. 通过宏定义，快速将任何类转换为单例类。如`YJNSSingletonW(NSMutableDictionary, @"identifier")`
2. 可定制全局单例和局域单例。

### 1.1.12 Swizzling

支持随时随地交换方法。

### 1.1.13 Timer

替换NSTimer实现相关计时器功能。

多种生命周期：

1. 随着应用的回收而回收。
2. 随着当前使用类的回收而回收。如VC回收时，YJSTimer也会回收。

### 1.1.14 URLCode

URLEncode编码和URLDecode解码

### 1.1.15 URLSession

大型APP网络架构，具有以下特性：

1. 兼容市面上任何一款网络SDK,并可以多个SDK协同工作；
2. 多种设计模式，按照项目需要随意组装架构；
3. 多种请求方式，可以面向接口请求服务器或面向对象请求服务器；
4. 支持网络重连。

## 1.2 UIKit

### 1.2.1 AutoLayout

AutoLayout主要实现NSLayoutConstraint的相关扩展和封装，它能使我们关于屏幕布局的开发越来越简单。
 
1. IOS和Swift的编程代码**一模一样**。
2. 代码写法模仿Apple关于约束的原生伪代码，增加代码可阅读性。
3. 将IOS9推出的NSLayoutAnchor迁移到IOS6上使用。

### 1.2.2 CollectionViewManager

UICollectionView封装

1. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为UICollectionView的控制中心使用。
2. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UICollectionViewCell的相关显示，缓存。UIViewController与UICollectionViewCell完全隔离。
3. 自带存储数据源，支持单数组和多数组显示的数据源。
4. 自动将数据从UIViewController传输到UICollectionViewCell，支持任意数据类型的传输。
5. 支持多种创建UICollectionViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。
6. 支持UICollectionViewFlowLayout动态布局；可设置一行显示个数，系统自动计算item宽度；可开启高度自适应，框架会根据计算的宽度动态缩放宽。
7. 自动register注册UICollectionViewCell，自动显示UICollectionViewCell，自动缓存UICollectionViewCell。
8. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存高度策略：
	1. 根据相同的UICollectionViewCell类缓存高度；
	2. 根据NSIndexPath对应的位置缓存高度；
	3. 根据类名和NSIndexPath双重绑定缓存高度。

### 1.2.3 Color

UIColor相关。

1. 函数生成UIColor，支持RGB和十六进制。
2. 点语法快速设置背景色。

### 1.2.4 InputLength

UITextField和UITextView可输入长度控制。

### 1.2.5 NavigationBar

NavigationBar主要实现对UINavigationBar的封装，可快速自定义配置UINavigationBar。

### 1.2.6 NavigationRouter

NavigationRouter 主要用于实现项目组件化，基础库是 Router。

### 1.2.7 PageViewManager

PageViewManager 主要实现对 UIPageViewController 的封装，支持轮播图、导航图、小说翻页等多种翻页模式。

1. 多种配置模式适应任何多页面需求。
2. 任何间隔切换VC，内存释放稳定。

### 1.2.8 ScrollViewManager

ScrollViewManager主用用于监听UIScrollView的滚动状态。

### 1.2.9 TableViewManager

UITableView管理器

1. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为TableView的控制中心使用。
2. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UITableViewCell的相关显示，缓存。UIViewController与UITableViewCell完全隔离。
3. 自带存储数据源，支持UITableViewStylePlain和UITableViewStyleGrouped显示的数据源。
4. 自动将数据从UIViewController传输到UITableViewCell，支持任意数据类型的传输。
5. 支持多种创建UITableViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。
6. 自动register注册UITableViewCell，自动显示UITableViewCell，自动缓存UITableViewCell。
7. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存高度策略：
	1. 根据相同的UITableViewCell类缓存高度；
	2. 根据NSIndexPath对应的位置缓存高度；
	3. 根据类名和NSIndexPath双重绑定缓存高度。

### 1.2.10 ViewGeometry

UIView(UIViewGeometry)相关扩展，可快速设置frame、bounds和center。

# 2 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101002.png)AppServices

## 2.1 CoreData

CoreData封装

1. 多级托管对象上下文管理，有NSPrivateQueueConcurrencyType和NSMainQueueConcurrencyType。
2. APP进入后台或crash前，自动保存数据，保证数据不丢失。
3. 可定制自动间隔保存，如每3分钟执行一次数据库保存操作。
3. 手动保存数据，支持前台保存和后台保存。
4. 通过迁移管理器做数据库版本升级时，可时时获取升级进度。

# 3 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101006.png)DeveloperTools

## 3.1 Leaks

内存泄漏分析器，用于捕获项目中有内存泄漏的UIViewController、UIView和Property属性。

## 3.2 MemoryInfo

主要用于获取运行过程中的RAM相关信息，如剩余内存。

## 3.3 TimeProfiler

时间分析器，主要用于分析引起主线程卡顿的代码。

1. 支持定制模块分析。
2. 支持设置分析频率和帧间隔。
3. 控制台打印 VC 加载时间。

# 4 ![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016101005.png)System

## 4.1 Dispatch

GCD相关封装

## 4.2 Security

### 4.2.1 Keychain

面向对象管理Keychain，支持自定义存储数据。

### 4.2.2 Random

快速生成指定位数的随机密码。

----------

# <a id="Appendix">Appendix

## Author

姓名：阳君

QQ：937447974

YJ技术支持群：557445088

职位：滴滴 iOS 高级工程师

如果你觉得这个框架很赞，请点击右上角的Star按钮；如果你对我的框架感兴趣，并想持续获得本人最新的框架源文件，欢迎点击右上角的Fork按钮。

如果你也想来和我们一起在滴滴从事iOS研发工作，欢迎投递简历到937447974@qq.com。

## Revision History

| 版本 | 时间  | 描述 |
| ---- | ---- | ---- |
| 1.0 | 2016-05-11 | 项目上线 |
| 1.1.0 | 2016-05-12 | GCD封装 |
| 1.2.0 | 2016-05-16 | YJCocoa拆分，可根据自己的需求选择相关库 |
| 1.3.0 | 2016-05-20 | YJCocoa引入‘YJCocoa/CoreServicesLayer/Foundation/Log’。NSLog打印优化，Unicode自动转化为中文输出。|
| 1.4.0 | | YJCocoa引入‘YJCocoa/CocoaTouchLayer/UIKit/AutoLayout'。YJAutoLayout主要实现NSLayoutConstraint的相关扩展和封装，它能使我们关于屏幕布局的开发越来越简单。 |
| 1.4.1 | | YJCocoa.h自动引入‘YJCocoa/CocoaTouchLayer/UIKit/AutoLayout' |
| 1.5.0 | | YJCocoa引入‘YJCocoa/CocoaTouchLayer/UIKit/PageView'。PageView主要实现对轮播图、导航图、小说翻页等多种翻页模式封装。|
| 1.6.0 | 2016-05-21 | YJCocoa引入‘YJCocoa/CocoaTouchLayer/UIKit/TableView'。UITableView封装。|
| 1.7.0 | | YJCocoa/CocoaTouchLayer/UIKit/CollectionView上线，UICollectionView封装 |
| 1.7.1 | 2016-05-23 | 部分方法调整，说明文档更新 |
| 1.7.2 | 2016-05-25 | system中gcd封装升级，支持串行和并行 |
| 1.8.0 | 2016-05-26 | 新库'YJCocoa/CoreServicesLayer/Foundation/Singleton'上线,单例管理中心解决项目级单例滥用问题。 |
| 1.9.0 | | 新库‘YJCocoa/CoreServicesLayer/Foundation/HttpAnalysis’上线，快速解析http链接获取其中参数 |
| 2.0.0 | | YJCocoa开发文档首次发包 |
| 2.0.1 | | 新库'YJCocoa/CocoaTouchLayer/UIKit/InputLength'上线，UITextField和UITextView增加可输入长度控制 |
| 2.0.2 | | ‘YJCocoa/CocoaTouchLayer/UIKit/PageView’升级，任何间隔切换VC，内存释放稳定。 |
| | 2016-05-30 | ‘TableView’和‘CollectionView’升级，增加快速刷新cell的方法。|
| | 2016-05-31 | ‘AutoLayout’升级，增加动画修改约束和快速查找约束的方法。 |
| 2.1.0 | 2016-06-01 | ‘UIViewGeometry’上线。UIView(UIViewGeometry)相关扩展，可快速设置frame。|
| 2.1.1 | 2016-06-08 | 修复'InputLength'引起UITextView崩溃问题 |
| 2.2.0 | 2016-06-30 | HttpAnalysis库更名为Http,增加组装http相关参数的方法。 |
| | 2016-07-06 | NavigationBar库上线,可自定义配置UINavigationBar；TableView和CollectionView支持分页请求数据。|
| | 2016-07-07 | System库删除dispatch_async_UI block；TableView和CollectionView支持用户滚动监听 |
| 2.2.1 | 2016-07-08 | CollectionView支持SectionHeaderView和SectionFooterView显示 |
| 2.2.2 | 2016-07-11 | System支持弱引用__weakSelf和强引用__strongSelf |
| | 2016-07-12 | TableView和CollectionView支持用户滑动到底部监听 |
| | 2016-07-13 | 修复NavigationBar在IOS7崩溃 |
| 2.3.0 | 2016-07-22 | TableView和CollectionView支持动态配置创建cell的方式(XIB、class和SB)；TableView中YJTableViewDelegate升级清楚缓存高的方法。 |
| | 2016-07-25 | PerformSelector库上线，用于安全执行Selector，可携带多个参数。 | 
| | 2016-07-29 | ‘CoreOSLayer/Security/Randomization’库上线，可快速生成指定位数的随机密码。 |
| | 2016-08-02 | ‘CoreOSLayer/Security/Keychain’库上线，面向对象管理Keychain，支持自定义存储数据。 |
| | | 修复YJNavigationBar和其他第三方SDK冲突，YJ后添加后缀C。 |
| 2.4.0 | 2016-08-05 | Log升级，新增方法NSLogS(id obj)，可快速打印对象。 |
| | | Timer上线，替换NSTimer实现相关计时器功能。|
| | | System升级，新增同步主线程方法dispatch_sync_main。|
| 2.4.1 | 2016-08-10 | AutoLayout修复bug：二次执行相同代码无法修改约束。 |
| | 2016-08-17 | Timer升级，修复主线程卡顿崩溃，时间间隔可支持0.001秒。 |
| 2.4.2 | 2016-08-19 | ViewGeometry升级，支持快速设置UIView.bounds。|
| | 2016-08-23 | TableView升级，支持快速实现悬浮cell。|
| 3.0.0 | 2016-08-24 | YJCocoa架构升级,每一层都有特定的类前缀。 |
| 3.0.1 | 2016-09-01 | http解析器和组装器升级 |
| | 2016-09-08 | UIKit层代码优化 |
| 3.1.0 | 2016-09-26 | DictionaryModel上线，支持快速高效的转换模型和Model。|
| 4.0.0 | 2016-10-11 | 依据苹果新的框架结构，YJCocoa架构重组。|
| 4.1.0 | 2016-10-12 | Directory上线，可快速获取应用内目录。 |
| | 2016-10-14 | AOP上线，支持将一对一的通信转换为一对多的通信。|
| | 2016-10-15 | TableView和CollectionView支持AOP代理 |
| 4.1.1 | 2016-10-17 | TableView架构升级，并更名为TableViewManager |
| | 2016-10-18 | CollectionView架构升级，并更名为CollectionViewManager |
| 4.2.0 | 2016-10-20 | ViewGeometry支持获取UIScrollView中控件在屏幕的位置 |
| | 2016-10-20 | Color上线，支持函数生成UIColor，及点语法设置背景色 |
| 4.2.1 | 2016-10-22 | DictionaryModel修复NSString值设置到number属性崩溃问题 |
| 4.3.0 | 2016-10-25 | FileManager上线，支持快速移动文件 |
| 4.3.1 | 2016-11-02 | UITableView和UICollectionView数据源越界保护，由crash改为log输出。
| 5.0.0 | 2016-11-03 | YJCocoa最低支持由iOS6升级到iOS7 |
| | | CoreData上线，支持并发操作、自动保存、前台保存、后台保存以及数据库版本升级 |
| | | NavigationBar升级，支持自定义按钮 |
| | 2016-11-06 | PerformSelector移除类YJNSPerformSelector |
| 5.0.1 | 2016-11-08 | CollectionViewManager修复`+ (YJUICollectionCellCreate)cellCreate`失效错误 |
| | | DictionaryModel增加对NSURL属性的自动转换 |
| 5.0.2 | 2016-11-15 | cellModel属性添加__kindof关键字 |
| | 2016-12-02 | Http修复锚点解析 | 
| | | CollectionViewManager中代理方法collectionViewManagerloadingPageData更名为collectionViewManagerLoadingPageData |
| | 2016-12-06 | CollectionViewManager增加collectionView:didSelectItemAtIndexPath:数据源越界保护。 |
| | 2016-12-07 | CollectionViewManager和CollectionViewManager增加对Cell. reuseIdentifier属性的防空处理 |
| | | DictionaryModel增加对NSURL和NSNumber属性相对于字典中数据的容错处理 |
| 5.1.0 | 2016-12-09 | URLSession上线，大型APP网络架构，兼容任何一款网络SDK，并将其转化为面向对象请求，且支持断网重连 |
| 5.1.1 | 2016-12-14 | AOP修复崩溃错误 |
| | 2016-12-15 | CollectionViewManager和TableViewManager增加数据源越界保护 |
| | 2016-12-16 | TableViewManager增加+ (YJUITableViewCellCreate)cellCreate方法强制实现 |
| | | CollectionViewManager和TableViewManager增加重用标识符 |
| | | 修复部分警告代码 |
| 5.2.0 | 2016-12-19 | URLCode上线，支持URLEncode编码和URLDecode解码 |
| | | Http接入URLCode库，增加参数URLEncode编码和URLDecode解码的方法 |
| 5.3.0 | 2016-12-20 | Router上线，是NavigationRouter的基础库 |
| | | NavigationRouter上线，主要用于实现项目组件化 |
| 5.4.0 | 2016-12-23 | ScrollViewManager上线，支持监听UIScrollView的滚动状态 |
| | | CollectionViewManager接入ScrollViewManager库实现滑动监听和分页加载 |
| | | TableViewManager接入ScrollViewManager库实现滑动监听和分页加载 |
| 5.4.1 | 2016-12-26 | ScrollViewManager支持设置边缘和边界提示区域 |
| | | Router和NavigationRouter架构升级 |
| 5.5.0 | 2016-12-28 | Router支持Get跳转 |
| | 2017-01-04 | 修复YJNSTimer超边界计时 |
| | 2017-01-05 | Calendar上线，支持快速将秒转换为天、时、分等 |
| | | Timer接入Calendar做时间解析器 |
| 5.5.1 | 2017-01-09 | URLSession架构升级，支持螺旋开发架构 |
| 6.0.0 | 2017-01-10 | Dispatch增加创建GCD倒计时的方法 |
| | 2017-01-10 | TimeProfiler上线，支持抓取主线程耗性能的代码 |
| | 2017-01-11 | DeveloperTools层上线，集成相关开发工具 |
| | 2017-01-12 | Swizzling上线，支持随时随地交换方法。 |
| | 2017-01-13 | Leaks上线，用于捕获项目中有内存泄漏的UIViewController、UIView和Property属性。 |
| 6.0.1 | 2017-01-17 | Swizzling和Leaks log打印优化 |
| | 2017-01-18 | Timer倒计时time=0时自动失效，正计时去掉上限 |
| 6.0.2 | 2017-02-04 | 修复Http URLEncode解析崩溃 |
| 6.1.0 | 2017-02-09 | TimeProfiler支持直接打印主线程卡顿堆栈信息 |
| | | PageView架构升级 |
| | 2017-02-12 | Swizzling增加class方法交换 |
| | 2017-02-14 | URLSession架构升级 |
| 6.2.0 | 2017-03-01 | NavigationBar修复部分机型启动崩溃错误 |
| | 2017-03-02 | Singleton性能优化，启用pthread_mutex锁 |
| | 2017-03-13 | Dispatch增加pthread锁架构 |
| | 2017-03-13 | Router和NavigationRouter架构升级 |
| | 2017-03-13 | TimeProfiler启用RunLoop监听主线程 |
| | 2017-03-13 | Singleton增加单例宏 |
| | 2017-03-14 | DictionaryModel、Directory、Router、Swizzling、Timer、URLSession、CoreData、Leaks和TimeProfiler库启用Singleton单例宏 |
| | 2017-03-15 | MemoryInfo上线，主要用于获取运行过程中的RAM相关信息，如剩余内存。|
| 6.3.0 | 2017-03-28 | URLSession 崩溃修复 |
| | 2017-03-31 | YJUIScrollViewManager 代理错误设置修复 |
| | 2017-04-17 | Dispatch 中 __weakSelf 改为 @weakSelf，__strongSelf 改为 @strongSelf。|
| | 2017-04-19 | CollectionViewManager 和 TableViewManager 移除同步和异步刷新 cell 的方法 |
| | 2017-04-25 | TimeProfiler 增加页面分析器，控制台打印 VC 加载时间。 |
| 6.4.0 | 2017-05-04 | PageView 升级为 PageViewManager，主要实现对 UIPageViewController 的封装，支持轮播图、导航图、小说翻页等多种翻页模式。|
| 6.5.0 | 2017-05-29 | TableViewManager 移除 cell 悬浮支持 |
| | 2017-06-02 | Leaks 增加白名单，可添加无须内存分析的类 |
| | 2017-06-14 | Dispatch 增加 dispatch_async_default(dispatch_block_t block) 方法 |
| 6.6.0 | 2017-07-19 | Dispatch 移除并发队列方法 |
| | 2017-07-21 | DictionaryModel 增加模型转换时根据外部属性key动态设置方法 |
| 7.0.0 | 2017-09-25 | 兼容 Xcode 9，消除警告提示 |
| 7.1.0 | 2017-10-18 | Log 库升级，支持 iOS 11 控制台 NSArray 和 NSDictionary 中文输出 |
| | | Router 和 NavigationRouter 架构升级，增加路由器的作用域控制，实现了热翻页效果。 |
| 8.0.0 | 2017-11-30 | 优化 strongSelf 宏，提示性能 |
| | 2017-12-13 | 升级支持最低版本为 iOS 8.0 和 Swift 4.0 |
| | | 增加 KVO 库，支持 block 回调和自动移除 Observer |

## Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974