#
#  Be sure to run `pod spec lint YJCocoa.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='china beijing'
# 文档发包:appledoc -c "阳君" --company-id "com.YJ" -p YJCocoa -v 3.0.0 -o ./Documentation ./Cocoa
# 验证podspec命令：pod spec lint YJCocoa.podspec --allow-warnings --verbose
# pod发包：pod trunk push YJCocoa.podspec --allow-warnings --verbose
# pod开发环境：#pod 'YJCocoa', :git => 'https://github.com/937447974/YJCocoa.git'

Pod::Spec.new do |s|

    # ――― Root specification
    s.name     = "YJCocoa"
    s.version  = "5.0.0"
    s.author   = { "阳君" => "937447974@qq.com" }
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.homepage = "https://github.com/937447974/YJCocoa"
#s.source = { :git => "https://github.com/937447974/YJCocoa.git", :branch => "master" }
s.source = { :git => "https://github.com/937447974/YJCocoa.git", :tag => "v#{s.version}" }
    s.summary  = "YJ系列开源库"
    s.description = <<-DESC
                      姓名：阳君
                      QQ：937447974
                      YJ技术支持群：557445088
                    DESC


    # ――― Platform
    s.platform = :ios
    s.ios.deployment_target = "7.0"


    # ——— Documentation And API Reference
    s.preserve_paths = 'Documentation/*.*'
    s.prepare_command = 'sh Documentation/docset-installed.sh'


    # ――― Build settings
    s.frameworks = "UIKit", "Foundation"
    s.requires_arc = true


    # ——— File patterns
    s.source_files = 'Cocoa/*.{h,m}'


    # ——— Subspecs
    s.default_subspec = 'AppFrameworks', 'System'

    # 1 App Frameworks
    s.subspec 'AppFrameworks' do |af|
        af.source_files = 'Cocoa/AppFrameworks/*.{h,m}'
        # 1.1 Foundation
        af.subspec 'Foundation' do |foundation|
            foundation.source_files = 'Cocoa/AppFrameworks/Foundation/*.{h,m}'
            # AOP
            foundation.subspec 'AOP' do |aop|
                aop.source_files = 'Cocoa/AppFrameworks/Foundation/AOP/*.{h,m}'
            end
            # DictionaryModel
            foundation.subspec 'DictionaryModel' do |dm|
                dm.source_files = 'Cocoa/AppFrameworks/Foundation/DictionaryModel/*.{h,m}'
                dm.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
            end
            # Directory
            foundation.subspec 'Directory' do |directory|
                directory.source_files = 'Cocoa/AppFrameworks/Foundation/Directory/*.{h,m}'
                directory.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
            end
            # FileManager
            foundation.subspec 'FileManager' do |fileManager|
                fileManager.source_files = 'Cocoa/AppFrameworks/Foundation/FileManager/*.{h,m}'
            end
            foundation.subspec 'Http' do |http|
                http.source_files = 'Cocoa/AppFrameworks/Foundation/Http/*.{h,m}'
            end
            foundation.subspec 'Log' do |log|
                log.source_files = 'Cocoa/AppFrameworks/Foundation/Log/*.{h,m}'
            end
            foundation.subspec 'PerformSelector' do |performSelector|
                performSelector.source_files = 'Cocoa/AppFrameworks/Foundation/PerformSelector/*.{h,m}'
            end
            foundation.subspec 'Singleton' do |singleton|
                singleton.source_files = 'Cocoa/AppFrameworks/Foundation/Singleton/*.{h,m}'
                singleton.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
            end
            foundation.subspec 'Timer' do |timer|
                timer.source_files = 'Cocoa/AppFrameworks/Foundation/Timer/*.{h,m}'
                timer.dependency 'YJCocoa/AppFrameworks/Foundation/PerformSelector'
                timer.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                timer.dependency 'YJCocoa/System/Security/Random'
            end
            foundation.subspec 'Other' do |other|
                other.source_files = 'Cocoa/AppFrameworks/Foundation/Other/*.{h,m}'
            end
        end
        # 1.2 UIKit
        af.subspec 'UIKit' do |uik|
            uik.source_files = 'Cocoa/AppFrameworks/UIKit/*.{h,m}'
            # AutoLayout
            uik.subspec 'AutoLayout' do |al|
                al.source_files = 'Cocoa/AppFrameworks/UIKit/AutoLayout/*.{h,m}'
                al.subspec 'UIView' do |v|
                    v.source_files = 'Cocoa/AppFrameworks/UIKit/AutoLayout/UIView/*.{h,m}'
                    v.dependency 'YJCocoa/AppFrameworks/UIKit/AutoLayout/LayoutAnchor'
                end
                al.subspec 'UIViewController' do |vc|
                    vc.source_files = 'Cocoa/AppFrameworks/UIKit/AutoLayout/UIViewController/*.{h,m}'
                    vc.dependency 'YJCocoa/AppFrameworks/UIKit/AutoLayout/LayoutAnchor'
                end
                al.subspec 'LayoutAnchor' do |la|
                    la.source_files = 'Cocoa/AppFrameworks/UIKit/AutoLayout/LayoutAnchor/*.{h,m}'
                    la.dependency 'YJCocoa/AppFrameworks/UIKit/AutoLayout/Extend'
                end
                al.subspec 'Extend' do |ale|
                    ale.source_files = 'Cocoa/AppFrameworks/UIKit/AutoLayout/Extend/*.{h,m}'
                end
            end
            # CollectionViewManager
            uik.subspec 'CollectionViewManager' do |cvm|
                cvm.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/CollectionViewManager/Core/*.{h,m}', 'Cocoa/AppFrameworks/UIKit/CollectionViewManager/CollectionCell/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/CollectionViewManager/CollectionCellObject'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/AOP'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/ViewGeometry'
                    core.dependency 'YJCocoa/System/Dispatch'
                end
                cvm.subspec 'CollectionCellObject' do |cco|
                    cco.source_files = 'Cocoa/AppFrameworks/UIKit/CollectionViewManager/CollectionCellObject/*.{h,m}'
                    cco.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
                end
            end
            # Color
            uik.subspec 'Color' do |color|
                color.source_files = 'Cocoa/AppFrameworks/UIKit/Color/*.{h,m}'
            end
            # UITextField和UITextView可输入长度控制
            uik.subspec 'InputLength' do |il|
                il.source_files  = "Cocoa/AppFrameworks/UIKit/InputLength/*.{h,m}"
            end
            # NavigationBar
            uik.subspec 'NavigationBar' do |nb|
                nb.source_files = 'Cocoa/AppFrameworks/UIKit/NavigationBar/*.{h,m}'
                nb.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/NavigationBar/Core/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/ViewGeometry'
                end
            end
            # PageView
            uik.subspec 'PageView' do |pv|
                pv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/PageView/*.{h,m}'
                    core.dependency 'YJCocoa/System/Dispatch'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/AutoLayout'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
                end
                pv.subspec 'ImagePage' do |ip|
                    ip.resources = 'Cocoa/AppFrameworks/UIKit/PageView/ImagePage/*.xib'
                    ip.source_files = 'Cocoa/AppFrameworks/UIKit/PageView/ImagePage/*.{h,m}'
                    ip.dependency 'YJCocoa/AppFrameworks/UIKit/PageView/Core'
                end
            end
            # UITableView
            uik.subspec 'TableViewManager' do |tvm|
                tvm.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/TableViewManager/Core/*.{h,m}', 'Cocoa/AppFrameworks/UIKit/TableViewManager/Suspension/*.{h,m}', 'Cocoa/AppFrameworks/UIKit/TableViewManager/TableCell/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/TableViewManager/TableCellObject'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/AOP'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/AutoLayout'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/ViewGeometry'
                    core.dependency 'YJCocoa/System/Dispatch'
                end
                tvm.subspec 'TableCellObject' do |tco|
                    tco.source_files = 'Cocoa/AppFrameworks/UIKit/TableViewManager/TableCellObject/*.{h,m}'
                    tco.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
                end
            end
            # UIView(UIViewGeometry)相关扩展，可快速设置fram相关
            uik.subspec 'ViewGeometry' do |vg|
                vg.source_files  = "Cocoa/AppFrameworks/UIKit/ViewGeometry/*.{h,m}"
            end
        end
    end

    # 2 AppServices
    s.subspec 'AppServices' do |as|
        as.source_files = 'Cocoa/AppServices/*.{h,m}'
        as.subspec 'CoreData' do |cd|
            cd.source_files = 'Cocoa/AppServices/CoreData/*.{h,m}'
            cd.subspec 'Core' do |cdCore|
                cdCore.source_files = 'Cocoa/AppServices/CoreData/Core/*.{h,m}'
                cdCore.dependency 'YJCocoa/AppFrameworks/Foundation/Timer'
            end
            cd.subspec 'Migration' do |cdMigration|
                cdMigration.source_files = 'Cocoa/AppServices/CoreData/Migration/*.{h,m}'
                cdMigration.dependency 'YJCocoa/AppServices/CoreData/Core'
                cdMigration.dependency 'YJCocoa/AppFrameworks/Foundation/Directory'
                cdMigration.dependency 'YJCocoa/AppFrameworks/Foundation/FileManager'
            end
            cd.subspec 'Object' do |cdObject|
                cdObject.source_files = 'Cocoa/AppServices/CoreData/Object/*.{h,m}'
                cdObject.dependency 'YJCocoa/AppServices/CoreData/Core'
            end
        end
    end

    # 3 System
    s.subspec 'System' do |system|
        system.source_files = 'Cocoa/System/*.{h,m}'
        system.subspec 'Dispatch' do |dispatch|
            dispatch.source_files = 'Cocoa/System/Dispatch/*.{h,m}'
        end
        system.subspec 'Security' do |security|
            security.source_files = 'Cocoa/System/Security/*.{h,m}'
            security.subspec 'Keychain' do |keychain|
                keychain.source_files = 'Cocoa/System/Security/Keychain/*.{h,m}'
                keychain.subspec 'Item' do |item|
                    item.source_files = 'Cocoa/System/Security/Keychain/Item/*.{h,m}'
                end
            end
            security.subspec 'Random' do |random|
                random.source_files = 'Cocoa/System/Security/Random/*.{h,m}'
            end
        end
    end


end
