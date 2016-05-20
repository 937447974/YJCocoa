#
#  Be sure to run `pod spec lint YJCocoa.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='china beijing'
# 文档发包:appledoc -c "阳君" --company-id "com.YJ" -p YJCocoa -v 1.0 -o ./Documentation ./Classes
# 验证podspec命令：pod spec lint YJCocoa.podspec --allow-warnings --verbose
# pod发包：pod trunk push YJCocoa.podspec --allow-warnings

Pod::Spec.new do |s|

    # ――― Root specification
    s.name     = "YJ系列开源库"
    s.version  = "1.5.0"
    s.author   = { "阳君" => "937447974@qq.com" }
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.homepage = "https://github.com/937447974/YJCocoa"
#s.source = { :git => "https://github.com/937447974/YJCocoa.git", :branch => "developer" }
s.source = { :git => "https://github.com/937447974/YJCocoa.git", :tag => "v#{s.version}" }
    s.summary  = "YJ Cocoa"


    # ――― Platform
    s.platform = :ios
    s.ios.deployment_target = "6.0"


    # ――― Build settings
    s.frameworks = "UIKit", "Foundation"
    s.requires_arc = true


    # ——— Subspecs
    s.source_files = 'Cocoa/*.{h,m}'
    s.default_subspec = 'CocoaTouchLayer', 'CoreServicesLayer', 'CoreOSLayer'

    # 1 Cocoa Touch Layer
    s.subspec 'CocoaTouchLayer' do |ctl|
        ctl.source_files = 'Cocoa/CocoaTouchLayer/*.{h,m}'
        ctl.subspec 'UIKit' do |uik|
            uik.source_files = 'Cocoa/CocoaTouchLayer/UIKit/*.{h,m}'
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
            # CollectionView
            uik.subspec 'CollectionView' do |cv|
                cv.source_files = 'Cocoa/CocoaTouchLayer/UIKit/CollectionView/*.{h,m}'
                cv.dependency 'YJCocoa/CoreServicesLayer/Foundation'
                cv.dependency 'YJCocoa/CoreOSLayer/System'
            end
            # PageView
            uik.subspec 'PageView' do |pv|
                pv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/CocoaTouchLayer/UIKit/PageView/*.{h,m}'
                    core.dependency 'YJCocoa/CoreOSLayer/System'
                    core.dependency 'YJCocoa/CocoaTouchLayer/UIKit/AutoLayout'
                end
                pv.subspec 'ImagePage' do |ip|
                    ip.resources = 'Cocoa/CocoaTouchLayer/UIKit/PageView/ImagePage/*.xib'
                    ip.source_files = 'Cocoa/CocoaTouchLayer/UIKit/PageView/ImagePage/*.{h,m}'
                    ip.dependency 'YJCocoa/CocoaTouchLayer/UIKit/PageView/Core'
                end
            end
        end
    end

    # 2 Core Services Layer
    s.subspec 'CoreServicesLayer' do |csl|
        csl.source_files = 'Cocoa/CoreServicesLayer/*.{h,m}'
        csl.subspec 'Foundation' do |foundation|
            foundation.source_files = 'Cocoa/CoreServicesLayer/Foundation/*.{h,m}'
            foundation.subspec 'Log' do |log|
                log.source_files = 'Cocoa/CoreServicesLayer/Foundation/Log/*.{h,m}'
            end
        end
    end

    # 3 Core OS Layer
    s.subspec 'CoreOSLayer' do |col|
        col.source_files = 'Cocoa/CoreOSLayer/*.{h,m}'
        col.subspec 'System' do |system|
            system.source_files = 'Cocoa/CoreOSLayer/System/*.{h,m}'
        end
    end


end
