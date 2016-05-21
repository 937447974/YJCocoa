# YJCocoa

YJ系列开源库

支持iOS6.0和Swift开发。

---

## YJCocoa/CocoaTouchLayer/UIKit/AutoLayout

AutoLayout主要实现NSLayoutConstraint的相关扩展和封装，它能使我们关于屏幕布局的开发越来越简单。

## YJCocoa/CocoaTouchLayer/UIKit/PageView

PageView主要实现对轮播图、导航图、小说翻页等多种翻页模式封装。

## YJCocoa/CocoaTouchLayer/UIKit/TableView

UITableView封装

1. 支持iOS6.0和Swift开发。
2. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为TableView的控制中心使用。
3. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UITableViewCell的相关显示，缓存。UIViewController与UITableViewCell完全隔离。
4. 自带存储数据源，支持UITableViewStylePlain和UITableViewStyleGrouped显示的数据源。
5. 自动将数据从UIViewController传输到UITableViewCell，支持任意数据类型的传输，如项目中常用的CellModel、Dictionary字典。
6. 自动register注册UITableViewCell，自动显示UITableViewCell，自动缓存UITableViewCell。多种缓存策略，可根据创建UITableViewCell的类名或UITableViewCell在UITableView的显示位置缓存cell。
7. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存策略，可根据创建UITableViewCell的类名或UITableViewCell在UITableView的显示位置缓存高度。
8. 自动优化UITableView滑动卡顿。
8. 支持多种点击cell的监听方式，可使用protocol或block。
9. 支持多种创建UITableViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。

---

## YJCocoa/CoreServicesLayer/Foundation/Log

NSLog打印优化，Unicode自动转化为中文输出。

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

##Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974