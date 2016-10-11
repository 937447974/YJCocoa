#!/bin/sh

# 路径声明
docset_name=com.YJ.YJCocoa.docset
docset_path=Documentation/${docset_name}
docset_dest_dir=~/Library/Developer/Shared/Documentation/DocSets
docset_dest_path=${docset_dest_dir}/${docset_name}

# 对比已有的文档，如果有不同则用最新的覆盖已有的
#diff --recursive ${docset_path} ${docset_dest_path} > /dev/null
#if [[ $? != 0 ]] ; then
#
#	# 目录不存在则创建
#	if [ ! -d ${docset_dest_dir} ]; then
#  		mkdir -p ${docset_dest_dir}
#	fi
#	
#	# 复制文件
#	cp -a -f ${docset_path} ${docset_dest_path}
#
#    # 在通知中心显示提示
#    osascript -e 'display notification "请重启Xcode后在Help -> Documentation And API Reference中查看文档" with title "YJCocoa开发文档已安装"'
#
#fi

# 删除开发文档
#目录存在则删除
if [ -d ${docset_dest_path} ]; then
    rm -rf ${docset_dest_path}
    osascript -e 'display notification "请重启Xcode后在Help -> Documentation And API Reference中查看" with title "YJCocoa开发文档已删除"'
fi

# 更新记录
#osascript -e 'display notification "2.0.0 | 2016-05-26 | YJCocoa开发文档首次发包" with title "YJCocoa"'
#osascript -e 'display notification "2.0.1 | 2016-05-26 | 新库.../UIKit/InputLength上线，UITextField和UITextView增加可输入长度控制" with title "YJCocoa"'

#osascript -e 'display notification "2.0.2 | 2016-05-26 | ‘YJCocoa/CocoaTouchLayer/UIKit/PageView’升级，任何间隔切换VC，内存释放稳定。" with title "YJCocoa"'
#osascript -e 'display notification "2.0.2 | 2016-05-30 | ‘TableView’和‘CollectionView’升级，增加快速刷新cell的方法。" with title "YJCocoa"'
#osascript -e 'display notification "2.0.2 | 2016-05-31 | ‘AutoLayout’升级，增加动画修改约束和快速查找约束的方法。" with title "YJCocoa"'
#osascript -e 'display notification "2.1.0 | 2016-06-01 | ‘UIViewGeometry’上线。UIView(UIViewGeometry)相关扩展，可快速设置frame" with title "YJCocoa"'

#osascript -e 'display notification "2.1.1 | 2016-06-08 | 修复‘InputLength’引起UITextView崩溃问题" with title "YJCocoa"'

#osascript -e 'display notification "2.2.0 | 2016-06-30 | HttpAnalysis库更名为Http,增加组装http相关参数的方法。" with title "YJCocoa"'
#osascript -e 'display notification "2.2.0 | 2016-07-06 | NavigationBar库上线,可自定义配置UINavigationBar" with title "YJCocoa"'
#osascript -e 'display notification "2.2.0 | 2016-07-06 | TableView和CollectionView支持分页请求数据。" with title "YJCocoa"'
#osascript -e 'display notification "2.2.0 | 2016-07-06 | CollectionView支持分页请求数据" with title "YJCocoa"'
#osascript -e 'display notification "2.2.0 | 2016-07-07 | System库删除dispatch_async_UI block" with title "YJCocoa"'
#osascript -e 'display notification "2.2.0 | 2016-07-07 | TableView和CollectionView支持用户滑动监听" with title "YJCocoa"'

#osascript -e 'display notification "2.2.1 | 2016-07-08 | CollectionView支持SectionHeaderView和SectionFooterView显示" with title "YJCocoa"'

#osascript -e 'display notification "2.2.2 | 2016-07-11 | System支持弱引用__weakSelf和强引用__strongSelf" with title "YJCocoa"'
#osascript -e 'display notification "2.2.2 | 2016-07-12 | TableView和CollectionView支持用户滑动到底部监听" with title "YJCocoa"'

#osascript -e 'display notification "2.2.3 | 2016-07-13 | 修复NavigationBar在IOS7崩溃" with title "YJCocoa"'

#osascript -e 'display notification "2.3.0 | 2016-07-22 | TableView和CollectionView支持动态配置创建cell的方式(XIB、class和SB)" with title "YJCocoa"'
#osascript -e 'display notification "2.3.0 | 2016-07-22 | TableView中YJTableViewDelegate升级清楚缓存高的方法" with title "YJCocoa"'
#osascript -e 'display notification "2.3.0 | 2016-07-25 | PerformSelector库上线，用于安全执行Selector，可携带多个参数。" with title "YJCocoa"'
#osascript -e 'display notification "2.3.0 | 2016-07-25 | Randomization库上线，可快速生成指定位数的随机密码。" with title "YJCocoa"'
#osascript -e 'display notification "2.3.0 | 2016-08-02 | Keychain库上线，面向对象管理Keychain，支持自定义存储数据。" with title "YJCocoa"'
#osascript -e 'display notification "2.3.0 | 2016-08-02 | 修复YJNavigationBar和其他第三方SDK冲突，YJ后添加后缀C。" with title "YJCocoa"'

#osascript -e 'display notification "2.4.0 | 2016-08-05 | Log升级，新增方法NSLogS(id obj)，可快速打印对象。" with title "YJCocoa"'
#osascript -e 'display notification "2.4.0 | 2016-08-05 | Timer上线，替换NSTimer实现相关计时器功能。" with title "YJCocoa"'
#osascript -e 'display notification "2.4.0 | 2016-08-05 | System升级，新增同步主线程方法dispatch_sync_main。" with title "YJCocoa"'

#osascript -e 'display notification "2.4.1 | 2016-08-10 | AutoLayout修复bug：二次执行相同代码无法修改约束。" with title "YJCocoa"'
#osascript -e 'display notification "2.4.1 | 2016-08-17 | Timer升级，修复主线程卡顿崩溃，时间间隔可支持0.001秒。" with title "YJCocoa"'

#osascript -e 'display notification "2.4.2 | 2016-08-19 | ViewGeometry升级，支持快速设置UIView.bounds。" with title "YJCocoa"'
#osascript -e 'display notification "2.4.2 | 2016-08-23 | TableView升级，支持快速实现悬浮cell。" with title "YJCocoa"'

#osascript -e 'display notification "3.0.0 | 2016-08-24 | YJCocoa架构升级,每一层都有特定的类前缀。" with title "YJCocoa"'

#osascript -e 'display notification "3.0.1 | 2016-09-01 | http解析器和组装器升级" with title "YJCocoa"'
#osascript -e 'display notification "3.0.1 | 2016-09-08 | UIKit层代码优化" with title "YJCocoa"'

#osascript -e 'display notification "3.1.0 | 2016-09-26 | DictionaryModel上线，支持快速高效的转换模型和Model。" with title "YJCocoa"'

osascript -e 'display notification "4.0.0 | 2016-10-11 | 依据苹果新的框架结构，YJCocoa架构重组。" with title "YJCocoa"'



