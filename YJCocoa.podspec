#
#  Be sure to run `pod spec lint YJCocoa.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='china beijing'
# 文档发包:appledoc -c "阳君" --company-id "com.YJ" -p YJCocoa -v 1.0 -o ./Documentation ./Classes
# 验证podspec命令：pod spec lint或 pod spec lint --allow-warnings --verbose
# pod发包：pod trunk push YJCocoa.podspec --allow-warnings

Pod::Spec.new do |s|

    # ――― Root specification
    s.name     = "YJCocoa"
    s.version  = "1.2.0"
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
    end

    # 2 Core Services Layer
    s.subspec 'CoreServicesLayer' do |csl|
        csl.source_files = 'Cocoa/CoreServicesLayer/*.{h,m}'
        csl.default_subspec = 'Foundation'
        csl.subspec 'Foundation' do |foundation|
            foundation.source_files = 'Cocoa/CoreServicesLayer/Foundation/*.{h,m}'
        end
    end

    # 3 Core OS Layer
    s.subspec 'CoreOSLayer' do |col|
        col.source_files = 'Cocoa/CoreOSLayer/*.{h,m}'
        col.default_subspec = 'System'
        col.subspec 'System' do |system|
            system.source_files = 'Cocoa/CoreOSLayer/System/*.{h,m}'
        end
    end


end
