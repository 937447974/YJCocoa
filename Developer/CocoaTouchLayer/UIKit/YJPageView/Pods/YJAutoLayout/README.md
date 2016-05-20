#1 YJAutoLayout

YJAutoLayout主要实现NSLayoutConstraint的相关扩展和封装，它能使我们关于屏幕布局的开发越来越简单。

##1.1 YJAutoLayout的优点

1. 支持iOS6.0和Swift开发。 
2. IOS和Swift的编程代码**一模一样**。
3. 代码写法模仿Apple关于约束的原生伪代码，增加代码可阅读性。
4. 将IOS9推出的NSLayoutAnchor迁移到IOS6上使用。

##1.2 YJAutoLayout的缺点。

1. 需要学习原生AutoLayout的使用。[Auto Layout Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/index.html)

##1.3 YJAutoLayout/Extend

YJAutoLayout/Extend是YJAutoLayout的衍生库，它主要是封装了NSLayoutConstraint的一些公用开发。如果项目中使用NSLayoutConstraint做开发，可以使用到它。不过推荐使用YJAutoLayout做AutoLayout开发。


##1.4 导入YJAutoLayout

导入YJAutoLayout可使用pod导入，相关命令：

```pod
platform :ios, '6.0'
pod 'YJAutoLayout'
```

或

```pod
platform :ios, '6.0'
pod 'YJAutoLayout', :git => 'https://github.com/937447974/YJAutoLayout.git'
```

pod导入后即可在项目中看见相关文件。

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016042501.png)

#2 使用介绍

NSLayoutConstraint原始代码

```objc
[NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attr2 multiplier:m constant:c];
```

转化为伪代码

```
view1.attr1 = view2.attr2 * m + c
```

如attr1 = NSLayoutAttributeLeading，attr2 = NSLayoutAttributeTrailing

则使用YJAutoLayout可转换为

```objc
view1.leadingLayout.equalTo(view2.trailingLayout).multipliers(m).constants(c)
```

> 当m=1时，可不写`.multipliers(m)`;
> 
> 当c=0时，可不写.constants(c)

#2 实战演示 

##2.1 基础实战
接下来完成一个如下所示的约束图。

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2015121806.jpg)

根据演示图，列出相关伪代码

```
Yellow View.Leading = Superview.LeadingMargin +20.0
Yellow View.Top = Top Layout Guide.Bottom + 20.0
Bottom Layout Guide.Top = Yellow View.Bottom + 20.0
 
Green View.Trailing = Superview.TrailingMargin
Green View.Top = Top Layout Guide.Bottom + 20.0
Bottom Layout Guide.Top = Green View.Bottom + 20.0
 
Green View.Leading = Yellow View.Trailing + 30.0
Yellow View.Width = Green View.Width
```

使用YJAutoLayout表示

```objc
// 1 yellow约束
yellowView.leadingLayout.equalTo(self.view.leadingLayout).constants(20);
yellowView.topLayout.equalTo(self.topLayoutSupport.bottomLayout).constants(20);
self.bottomLayoutSupport.topLayout.equalTo(yellowView.bottomLayout).constants(20);
// 2 green约束
greenView.topLayout.equalTo(self.topLayoutSupport.bottomLayout).constants(20);
self.view.trailingLayout.equalTo(greenView.trailingLayout).constants(20);
self.bottomLayoutSupport.topLayout.equalTo(greenView.bottomLayout).constants(20);
// 3 green和yellow的共有约束
greenView.leadingLayout.equalTo(yellowView.trailingLayout).constants(30);
greenView.widthLayout.equalTo(yellowView.widthLayout);
```

##2.2 高级实战

你还可以多个约束同时设置。

上面的效果图即可改为

```objc
// 1 yellow约束
_yellowView.topSpaceToSuper(20).bottomSpaceToSuper(20).leadingSpaceToSuper(20);
// 2 green约束
_greenView.topSpaceToSuper(20).bottomSpaceToSuper(20).trailingSpaceToSuper(20);
// 3 green和yellow的共有约束
_greenView.leadingLayout.equalTo(_yellowView.trailingLayout).constants(30);
_greenView.widthLayout.equalTo(_yellowView.widthLayout);
```

如果是等bounds还可以使用如下写法。

```objc
self.yellowView.topSpaceToSuper(0).leadingSpaceToSuper(0).bottomSpaceToSuper(0).trailingSpaceToSuper(0);
// 等价
self.yellowView.sizeLayoutTo(self.view);
self.yellowView.centerLayoutTo(self.view);
// 等价
self.yellowView.boundsLayoutTo(self.view);  
```

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
| 2016-04-22 | 项目启动 |
| 2016-04-22 | 1.0 YJAutoLayout库和YJAutoLayout/Extend库完成 |
| 2016-04-25 | 1.0.1 YJAutoLayout使用文档完成 |
| 2016-04-26 | 1.1.0 UIView+YJViewLayoutConstraintCreation增加多个约束方法 |

##Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974/Blog