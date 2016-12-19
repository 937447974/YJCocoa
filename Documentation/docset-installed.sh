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
osascript -e 'display notification "2016-12-19 | URLCode上线，支持URLEncode编码和URLDecode解码" with title "YJCocoa 5.2.0"'
osascript -e 'display notification "2016-12-19 | Http接入URLCode库，增加参数URLEncode编码和URLDecode解码的方法" with title "YJCocoa 5.2.0"'


