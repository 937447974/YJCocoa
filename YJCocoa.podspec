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
    s.version  = "3.1.0"
    s.author   = { "阳君" => "937447974@qq.com" }
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.homepage = "https://github.com/937447974/YJCocoa"
s.source = { :git => "https://github.com/937447974/YJCocoa.git", :branch => "developer" }
#s.source = { :git => "https://github.com/937447974/YJCocoa.git", :tag => "v#{s.version}" }
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
    s.default_subspec = 'AppFrameworks', 'System'

    # 1 App Frameworks
    s.subspec 'AppFrameworks' do |af|
        af.source_files = 'Cocoa/AppFrameworks/*.{h,m}'
        af.subspec 'Foundation' do |foundation|
            foundation.source_files = 'Cocoa/AppFrameworks/Foundation/*.{h,m}'
            foundation.subspec 'DictionaryModel' do |dm|
                dm.source_files = 'Cocoa/AppFrameworks/Foundation/DictionaryModel/*.{h,m}'
                dm.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
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
    end

    # 2 System
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
