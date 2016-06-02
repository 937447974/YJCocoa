# coding=utf-8
#!/bin/sh
#!/usr/bin/python

#1 需安装brew install the_silver_searcher
#2 项目根目录运行

#姓名：阳君
#QQ：937447974
#YJ技术支持群：557445088

import os
import re
import glob
import shutil
import time


depth = 5 # 查询深度,一个文件夹一级
imageFolder = "YJ/Assets.xcassets" # 图片资源文件夹
project = os.path.basename(rootPath) # 工程名

rootPath = os.getcwd() # 当前目录,工程根目录
tempPath = os.path.join(rootPath, "YJTempFolder") # 临时文件夹
weakPath = os.path.join(rootPath, "YJWeakImages") # 弱应用文件夹,存放已删除文件


# 主函数
def main():
    
    # 创建文件夹
    createFolder()
    
    # 文件移除项目
    sourceFolder = os.path.join(rootPath, imageFolder)
    if not os.path.exists(sourceFolder) :
        print '源文件%s不存在' % (sourceFolder)
        return
    shutil.move(sourceFolder, tempPath)
    
    # 需要检索的图片文件
    imagePaths = []
    for i in range(depth):
        imagePaths += glob.glob(os.path.join(tempPath, '%s*.imageset' % ('*/' * i)))
    
    # 照片弱引用检索
    weakImgs = []
    for i in range(0, len(imagePaths)):
        imagePath = imagePaths[i]
        imageName = os.path.basename(imagePath)[:-9]
        command = 'ag "%s" %s' % (imageName, project)
        result = os.popen(command).read()
        if result == '': # 弱引用
            weakImgs.append(imagePath)
            shutil.move(os.path.join(rootPath, imagePath), weakPath)
            print 'remove %s' % (imagePaths[i])

    # 文件移回项目
    shutil.move(tempPath+'/'+os.path.basename(sourceFolder), sourceFolder[:-len(os.path.basename(sourceFolder))])
    
    # 删除文件夹
    removeFolder()
    
    # 文档记录
    textPath = 'YJWeakImages.txt'
    text = '\n操作时间：%s \n\n删除文件：\n' % (time.strftime('%Y-%m-%d %X', time.localtime())).join(sorted(weakImgs))
    os.system('echo "%s" > %s' % (text, textPath))
    print 'weakImages result:%d' % (len(weakImgs))


# 创建文件夹
def createFolder():
    # 临时文件夹
    if os.path.exists(tempPath) :
        shutil.rmtree(tempPath)
    os.makedirs(tempPath)
    # 弱引用文件夹
    if os.path.exists(weakPath) :
        shutil.rmtree(weakPath)
    os.makedirs(weakPath)


# 移除文件夹
def removeFolder():
    if os.path.exists(tempPath) :
        shutil.rmtree(tempPath)


# 开始运行
if __name__ == '__main__':
    main()



