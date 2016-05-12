#
#  Be sure to run `pod spec lint YJCocoa.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 验证podspec命令：pod spec lint或 pod spec lint --allow-warnings
# pod发包：pod trunk push YJCocoa.podspec --allow-warnings

Pod::Spec.new do |s|

    # ――― Root specification
    s.name     = "YJCocoa"
    s.version  = "1.1.0"
    s.author   = { "阳君" => "937447974@qq.com" }
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.homepage = "https://github.com/937447974/YJCocoa"
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
    s.default_subspec = 'Foundation', 'System'

    #Core Services Layer
    s.subspec 'Foundation' do |foundation|
        foundation.source_files = 'Cocoa/Foundation/*.{h,m}'
    end

    #Core OS Layer
    s.subspec 'System' do |system|
        system.source_files = 'Cocoa/System/*.{h,m}'
    end

end
