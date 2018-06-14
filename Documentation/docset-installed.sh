#!/bin/sh

# 路径声明
#docset_name=com.YJ.YJCocoa.docset
#docset_path=Documentation/${docset_name}
#docset_dest_dir=~/Library/Developer/Shared/Documentation/DocSets
#docset_dest_path=${docset_dest_dir}/${docset_name}

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
#if [ -d ${docset_dest_path} ]; then
#    rm -rf ${docset_dest_path}
#    osascript -e 'display notification "请重启Xcode后在Help -> Documentation And API Reference中查看" with title "YJCocoa开发文档已删除"'
#fi

# 更新记录
osascript -e 'display notification "1. NSNotificationCenter 上线，主要用于 block 回调通知，并支持自动释放。" with title "YJCocoa 8.2.0"'
osascript -e 'display notification "2. TableViewManager 升级为 TableView 库，增加 YJUITableView 组件。" with title "YJCocoa 8.2.0"'
osascript -e 'display notification "3. CollectionViewManager 升级为CollectionView 库，增加 YJUICollectionView 组件。" with title "YJCocoa 8.2.0"'
osascript -e 'display notification "4. PageViewManager 升级为 PageView 库，增加 YJUIPageViewController 组件。" with title "YJCocoa 8.2.0"'

osascript -e 'display notification "5. Dispatch 增加 strongSelfReturn 宏，支持self不存在时直接返回默认值。" with title "YJCocoa 8.2.0"'
osascript -e 'display notification "6. URLSession、DictionaryModel 修复相关 bug。" with title "YJCocoa 8.2.0"'



