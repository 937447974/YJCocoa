# YJCocoa

YJ系列开源库

支持iOS6.0和Swift开发。

---

## YJCocoa/CocoaTouchLayer/UIKit/AutoLayout

AutoLayout主要实现NSLayoutConstraint的相关扩展和封装，它能使我们关于屏幕布局的开发越来越简单。
 
2. IOS和Swift的编程代码**一模一样**。
3. 代码写法模仿Apple关于约束的原生伪代码，增加代码可阅读性。
4. 将IOS9推出的NSLayoutAnchor迁移到IOS6上使用。


## YJCocoa/CocoaTouchLayer/UIKit/PageView

PageView主要实现对轮播图、导航图、小说翻页等多种翻页模式封装。

1. 支持iOS6.0和Swift开发。
2. 多种配置模式适应任何多页面需求。
3. 0.02秒切换VC时，内存释放稳定。

## YJCocoa/CocoaTouchLayer/UIKit/TableView

UITableView封装

1. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为TableView的控制中心使用。
2. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UITableViewCell的相关显示，缓存。UIViewController与UITableViewCell完全隔离。
3. 自带存储数据源，支持UITableViewStylePlain和UITableViewStyleGrouped显示的数据源。
4. 自动将数据从UIViewController传输到UITableViewCell，支持任意数据类型的传输，如项目中常用的CellModel、Dictionary字典。
5. 自动优化UITableView滑动卡顿，支持同步和异步刷新UITableViewCell。
6. 支持多种点击cell的监听方式，可使用protocol或block。
7. 支持多种创建UITableViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。
8. 自动register注册UITableViewCell，自动显示UITableViewCell，自动缓存UITableViewCell。多种缓存策略：
	1. 根据相同的UITableViewCell类名缓存Cell；
	2. 根据NSIndexPath对应的位置缓存Cell；
	3. 据类名和NSIndexPath双重绑定缓存Cell。
9. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存高度策略：
	1. 根据相同的UITableViewCell类缓存高度；
	2. 根据NSIndexPath对应的位置缓存高度；
	3. 根据类名和NSIndexPath双重绑定缓存高度。


## YJCocoa/CocoaTouchLayer/UIKit/CollectionView

UICollectionView封装

1. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为UICollectionView的控制中心使用。
2. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UICollectionViewCell的相关显示，缓存。UIViewController与UICollectionViewCell完全隔离。
3. 自带存储数据源，支持单数组和多数组显示的数据源。
4. 自动将数据从UIViewController传输到UICollectionViewCell，支持任意数据类型的传输，如项目中常用的CellModel、Dictionary字典。
5. 自动优化UICollectionView滑动卡顿，支持同步和异步刷新UICollectionViewCell。
6. 支持多种点击cell的监听方式，可使用protocol或block。
7. 支持多种创建UICollectionViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。
8. 支持UICollectionViewFlowLayout动态布局；可设置一行显示个数，系统自动计算item宽度；可开启高度自适应，框架会根据计算的宽度动态缩放宽。
9. 自动register注册UICollectionViewCell，自动显示UICollectionViewCell，自动缓存UICollectionViewCell。多种缓存策略：
	1. 根据相同的UITableViewCell类名缓存Cell；
	2. 根据NSIndexPath对应的位置缓存Cell；
	3. 据类名和NSIndexPath双重绑定缓存Cell。
10. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存高度策略：
	1. 根据相同的UITableViewCell类缓存高度；
	2. 根据NSIndexPath对应的位置缓存高度；
	3. 根据类名和NSIndexPath双重绑定缓存高度。

---

## YJCocoa/CoreServicesLayer/Foundation/Log

NSLog打印优化，Unicode自动转化为中文输出。

---

## YJCocoa/CoreOSLayer/System

GCD相关封装

----------

#<a id="Appendix">Appendix

##Author

姓名：阳君

QQ：937447974

YJ技术支持群：557445088

职位：聚美优品iOS攻城师

如果你觉得这个框架很赞，请点击右上角的Star按钮；如果你对我的框架感兴趣，并想持续获得本人最新的框架源文件，欢迎点击右上角的Fork按钮。

如果你也想来和我们一起在聚美优品(北京)从事iOS研发工作，欢迎投递简历到937447974@qq.com。

##Revision History

| 时间 | 描述 |
| ---- | ---- |
| 2016-05-11 | 1.0 项目上线 |
| 2016-05-12 | 1.1.0 GCD封装 |
| 2016-05-16 | 1.2.0 YJCocoa拆分，可根据自己的需求选择相关库 |
| 2016-05-20 | 1.3.0 YJCocoa引入‘YJCocoa/CoreServicesLayer/Foundation/Log’。NSLog打印优化，Unicode自动转化为中文输出。|
| 2016-05-20 | 1.4.0 YJCocoa引入‘YJCocoa/CocoaTouchLayer/UIKit/AutoLayout'。YJAutoLayout主要实现NSLayoutConstraint的相关扩展和封装，它能使我们关于屏幕布局的开发越来越简单。 |
| 2016-05-20 | 1.4.1 YJCocoa.h自动引入‘YJCocoa/CocoaTouchLayer/UIKit/AutoLayout' |
| 2016-05-20 | 1.5.0 YJCocoa引入‘YJCocoa/CocoaTouchLayer/UIKit/PageView'。PageView主要实现对轮播图、导航图、小说翻页等多种翻页模式封装。|
| 2016-05-21 | 1.6.0 YJCocoa引入‘YJCocoa/CocoaTouchLayer/UIKit/TableView'。UITableView封装。|
| 2016-05-21 | 1.7.0 YJCocoa/CocoaTouchLayer/UIKit/CollectionView上线，UICollectionView封装 |
| 2016-05-23 | 1.7.1 部分方法调整，说明文档更新 |

##Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974