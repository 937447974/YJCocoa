#!/bin/sh

# 路径声明
docset_name=com.YJ.YJCocoa.docset
docset_path=Documentation/${docset_name}
docset_dest_dir=~/Library/Developer/Shared/Documentation/DocSets
docset_dest_path=${docset_dest_dir}/${docset_name}

# 对比已有的文档，如果有不同则用最新的覆盖已有的
diff --recursive ${docset_path} ${docset_dest_path} > /dev/null
if [[ $? != 0 ]] ; then

	# 目录不存在则创建
	if [ ! -d ${docset_dest_dir} ]; then
  		mkdir -p ${docset_dest_dir}
	fi
	
	# 复制文件
	cp -a -f ${docset_path} ${docset_dest_path}

    # 在通知中心显示提示
    osascript -e 'display notification "请重启Xcode后在Help -> Documentation And API Reference中查看文档" with title "YJCocoa开发文档已安装"'

fi

# 更新记录
#osascript -e 'display notification "2.0.0 | 2016-05-26 | YJCocoa开发文档首次发包" with title "YJCocoa"'
#osascript -e 'display notification "2.0.1 | 2016-05-26 | 新库.../UIKit/InputLength上线，UITextField和UITextView增加可输入长度控制" with title "YJCocoa"'

#osascript -e 'display notification "2.0.2 | 2016-05-26 | ‘YJCocoa/CocoaTouchLayer/UIKit/PageView’升级，任何间隔切换VC，内存释放稳定。" with title "YJCocoa"'
#osascript -e 'display notification "2.0.2 | 2016-05-30 | ‘TableView’和‘CollectionView’升级，增加快速刷新cell的方法。" with title "YJCocoa"'
#osascript -e 'display notification "2.0.2 | 2016-05-31 | ‘AutoLayout’升级，增加动画修改约束和快速查找约束的方法。" with title "YJCocoa"'
#osascript -e 'display notification "2.1.0 | 2016-06-01 | ‘UIViewGeometry’上线。UIView(UIViewGeometry)相关扩展，可快速设置frame" with title "YJCocoa"'

#osascript -e 'display notification "2.1.1 | 2016-06-08 | 修复‘InputLength’引起UITextView崩溃问题" with title "YJCocoa"'

osascript -e 'display notification "2.2.0 | 2016-06-30 | HttpAnalysis库更名为Http,增加组装http相关参数的方法。" with title "YJCocoa"'
osascript -e 'display notification "2.2.0 | 2016-07-06 | NavigationBar库上线,可自定义配置UINavigationBar" with title "YJCocoa"'