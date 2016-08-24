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
# pod发包：pod trunk push YJCocoa.podspec --allow-warnings
# pod开发环境：#pod 'YJCocoa', :git => 'https://github.com/937447974/YJCocoa.git'

Pod::Spec.new do |s|

    # ――― Root specification
    s.name     = "YJCocoa"
    s.version  = "3.0.0"
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
    s.ios.deployment_target = "6.0"


    # ——— Documentation And API Reference
    s.preserve_paths = 'Documentation/*.*'
    s.prepare_command = 'sh Documentation/docset-installed.sh'


    # ――― Build settings
    s.frameworks = "UIKit", "Foundation"
    s.requires_arc = true

    # ——— File patterns
    s.source_files = 'Cocoa/*.{h,m}'


    # ——— Subspecs
    s.default_subspec = 'CocoaTouchLayer', 'CoreServicesLayer', 'CoreOSLayer'

    # 1 Cocoa Touch Layer
    s.subspec 'CocoaTouchLayer' do |ctl|
        ctl.source_files = 'Cocoa/CocoaTouchLayer/*.{h,m}'
        ctl.subspec 'UIKit' do |uik|
            uik.source_files = 'Cocoa/CocoaTouchLayer/UIKit/*.{h,m}'
            # UITextField和UITextView可输入长度控制
            uik.subspec 'InputLength' do |il|
                il.source_files  = "Cocoa/CocoaTouchLayer/UIKit/InputLength/*.{h,m}"
            end
            # UIView(UIViewGeometry)相关扩展，可快速设置fram相关
            uik.subspec 'ViewGeometry' do |vg|
                vg.source_files  = "Cocoa/CocoaTouchLayer/UIKit/ViewGeometry/*.{h,m}"
            end
            # AutoLayout
            uik.subspec 'AutoLayout' do |al|
                al.source_files = 'Cocoa/CocoaTouchLayer/UIKit/AutoLayout/*.{h,m}'
                al.subspec 'UIView' do |v|
                    v.source_files = 'Cocoa/CocoaTouchLayer/UIKit/AutoLayout/UIView/*.{h,m}'
                    v.dependency 'YJCocoa/CocoaTouchLayer/UIKit/AutoLayout/LayoutAnchor'
                end
                al.subspec 'UIViewController' do |vc|
                    vc.source_files = 'Cocoa/CocoaTouchLayer/UIKit/AutoLayout/UIViewController/*.{h,m}'
                    vc.dependency 'YJCocoa/CocoaTouchLayer/UIKit/AutoLayout/LayoutAnchor'
                end
                al.subspec 'LayoutAnchor' do |la|
                    la.source_files = 'Cocoa/CocoaTouchLayer/UIKit/AutoLayout/LayoutAnchor/*.{h,m}'
                    la.dependency 'YJCocoa/CocoaTouchLayer/UIKit/AutoLayout/Extend'
                end
                al.subspec 'Extend' do |ale|
                    ale.source_files = 'Cocoa/CocoaTouchLayer/UIKit/AutoLayout/Extend/*.{h,m}'
                end
            end
            # NavigationBar
            uik.subspec 'NavigationBar' do |nb|
                nb.source_files = 'Cocoa/CocoaTouchLayer/UIKit/NavigationBar/*.{h,m}'
                nb.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/CocoaTouchLayer/UIKit/NavigationBar/Core/*.{h,m}'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/ViewGeometry'
                end
            end
            # PageView
            uik.subspec 'PageView' do |pv|
                pv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/CocoaTouchLayer/UIKit/PageView/*.{h,m}'
                    core.dependency 'YJCocoa/CoreOSLayer/System'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/AutoLayout'
                    core.dependency 'YJCocoa/CoreServicesLayer/Foundation/Other'
                end
                pv.subspec 'ImagePage' do |ip|
                    ip.resources = 'Cocoa/CocoaTouchLayer/UIKit/PageView/ImagePage/*.xib'
                    ip.source_files = 'Cocoa/CocoaTouchLayer/UIKit/PageView/ImagePage/*.{h,m}'
                    ip.dependency 'YJCocoa/CocoaTouchLayer/UIKit/PageView/Core'
                end
            end
            # UITableView
            uik.subspec 'TableView' do |tv|
                tv.source_files  = "Cocoa/CocoaTouchLayer/UIKit/TableView/*.{h,m}"
                tv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/CocoaTouchLayer/UIKit/TableView/DataSource/*.{h,m}', 'Cocoa/CocoaTouchLayer/UIKit/TableView/Delegate/*.{h,m}', 'Cocoa/CocoaTouchLayer/UIKit/TableView/TableCell/*.{h,m}', 'Cocoa/CocoaTouchLayer/UIKit/TableView/Suspension/*.{h,m}'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/TableView/TableCellObject'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/AutoLayout'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/ViewGeometry'
                    core.dependency 'YJCocoa/CoreOSLayer/System'
                end
                tv.subspec 'TableCellObject' do |tco|
                    tco.source_files = 'Cocoa/CocoaTouchLayer/UIKit/TableView/TableCellObject/*.{h,m}'
                    tco.dependency 'YJCocoa/CoreServicesLayer/Foundation/Other'
                end
            end
            # CollectionView
            uik.subspec 'CollectionView' do |cv|
                cv.source_files  = "Cocoa/CocoaTouchLayer/UIKit/CollectionView/*.{h,m}"
                cv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/CocoaTouchLayer/UIKit/CollectionView/DataSource/*.{h,m}', 'Cocoa/CocoaTouchLayer/UIKit/CollectionView/Delegate/*.{h,m}', 'Cocoa/CocoaTouchLayer/UIKit/CollectionView/CollectionCell/*.{h,m}'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/CollectionView/CollectionCellObject'
                end
                cv.subspec 'CollectionCellObject' do |cco|
                    cco.source_files = 'Cocoa/CocoaTouchLayer/UIKit/CollectionView/CollectionCellObject/*.{h,m}'
                    cco.dependency 'YJCocoa/CocoaTouchLayer/UIKit/ViewGeometry'
                    cco.dependency 'YJCocoa/CoreServicesLayer/Foundation/Other'
                    cco.dependency 'YJCocoa/CoreOSLayer/System'
                end
            end
        end
    end

    # 2 Core Services Layer
    s.subspec 'CoreServicesLayer' do |csl|
        csl.source_files = 'Cocoa/CoreServicesLayer/*.{h,m}'
        csl.subspec 'Foundation' do |foundation|
            foundation.source_files = 'Cocoa/CoreServicesLayer/Foundation/*.{h,m}'
            foundation.subspec 'Http' do |http|
                http.source_files = 'Cocoa/CoreServicesLayer/Foundation/Http/*.{h,m}'
            end
            foundation.subspec 'PerformSelector' do |performSelector|
                performSelector.source_files = 'Cocoa/CoreServicesLayer/Foundation/PerformSelector/*.{h,m}'
            end
            foundation.subspec 'Singleton' do |singleton|
                singleton.source_files = 'Cocoa/CoreServicesLayer/Foundation/Singleton/*.{h,m}'
                singleton.dependency 'YJCocoa/CoreServicesLayer/Foundation/Other'
            end
            foundation.subspec 'Timer' do |timer|
                timer.source_files = 'Cocoa/CoreServicesLayer/Foundation/Timer/*.{h,m}'
                timer.dependency 'YJCocoa/CoreServicesLayer/Foundation/PerformSelector'
                timer.dependency 'YJCocoa/CoreServicesLayer/Foundation/Singleton'
                timer.dependency 'YJCocoa/CoreOSLayer/Security/Randomization'
            end
            foundation.subspec 'Log' do |log|
                log.source_files = 'Cocoa/CoreServicesLayer/Foundation/Log/*.{h,m}'
            end
            foundation.subspec 'Other' do |other|
                other.source_files = 'Cocoa/CoreServicesLayer/Foundation/Other/*.{h,m}'
            end
        end
    end

    # 3 Core OS Layer
    s.subspec 'CoreOSLayer' do |col|
        col.source_files = 'Cocoa/CoreOSLayer/*.{h,m}'
        col.subspec 'Security' do |security|
            security.source_files = 'Cocoa/CoreOSLayer/Security/*.{h,m}'
            security.subspec 'Keychain' do |keychain|
                keychain.source_files = 'Cocoa/CoreOSLayer/Security/Keychain/*.{h,m}'
                keychain.subspec 'Item' do |item|
                    item.source_files = 'Cocoa/CoreOSLayer/Security/Keychain/Item/*.{h,m}'
                end
            end
            security.subspec 'Randomization' do |randomization|
                randomization.source_files = 'Cocoa/CoreOSLayer/Security/Randomization/*.{h,m}'
            end
        end
        col.subspec 'System' do |system|
            system.source_files = 'Cocoa/CoreOSLayer/System/*.{h,m}'
        end
    end


end
