#
#  Be sure to run `pod spec lint YJCocoa.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='YJCocoa'
# 文档发包:appledoc -c "阳君" --company-id "com.YJ" -p YJCocoa -v 3.0.0 -o ./Documentation ./Cocoa
# 验证podspec命令：pod spec lint YJCocoa.podspec --verbose --allow-warnings 
# pod发包：pod trunk push YJCocoa.podspec --verbose --allow-warnings
# pod开发环境：#pod 'YJCocoa', :git => 'https://github.com/937447974/YJCocoa.git'

Pod::Spec.new do |s|
    
    # ――― Root specification
    s.name     = "YJCocoa"
    s.version  = "9.4.0"
    s.author   = { "阳君" => "937447974@qq.com" }
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.homepage = "https://github.com/937447974/YJCocoa"
    s.source = { :git => "https://github.com/937447974/YJCocoa.git", :tag => s.version }
    s.summary  = "YJ系列开源库"
    s.description = <<-DESC
                    姓名：阳君
                    QQ：937447974
                    YJ技术支持群：557445088
                    DESC
    
    # ――― Platform
    s.platform = :ios
    s.ios.deployment_target = '9.0'
    s.swift_version = '5.1'
    s.pod_target_xcconfig = { 'APPLICATION_EXTENSION_API_ONLY' => 'NO' }
    
    # ——— Subspecs
    s.default_subspec = 'AppFrameworks', 'DeveloperTools', 'System'
    
    # 1 App Frameworks
    s.subspec 'AppFrameworks' do |af|
        # 1.1 Foundation
        af.subspec 'Foundation' do |foundation|
            foundation.subspec 'Calendar' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Calendar/*'
            end
            foundation.subspec 'Directory' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Directory/*'
            end
            foundation.subspec 'Extension' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Extension/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
            end
            foundation.subspec 'JSONModel' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/JSONModel/**/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Safety'
            end
            foundation.subspec 'Log' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Log/*'
            end
            foundation.subspec 'Safety' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Safety/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                sub.dependency 'YJCocoa/System/Pthread'
            end
            foundation.subspec 'Scheduler' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Scheduler/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Extension'
                sub.dependency 'YJCocoa/System/Dispatch'
            end
            foundation.subspec 'SingletonCenter' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/SingletonCenter/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Safety'
            end
            foundation.subspec 'Timer' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/Timer/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
            end
            foundation.subspec 'URL' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/URL/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Extension'
            end
            foundation.subspec 'URLSession' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/URLSession/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/JSONModel'
                sub.dependency 'YJCocoa/System/Dispatch'
            end
        end
        # 1.2 Foundation
        af.subspec 'UIKit' do |ui|
            ui.subspec 'CollectionView' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/CollectionView/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
            end
            ui.subspec 'Extension' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/Extension/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                sub.dependency 'YJCocoa/System/Dispatch'
            end
            ui.subspec 'LinkTextView' do |ltv|
                ltv.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/LinkTextView/*'
            end
            ui.subspec 'NavigationBar' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/NavigationBar/*'
                sub.dependency 'YJCocoa/AppFrameworks/UIKit/Extension'
            end
            ui.subspec 'PageView' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/PageView/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                sub.dependency 'YJCocoa/AppFrameworks/UIKit/Extension'
            end
            ui.subspec 'ScrollView' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/ScrollView/*'
                sub.dependency 'YJCocoa/AppFrameworks/UIKit/Extension'
            end
            ui.subspec 'TableView' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/TableView/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                sub.dependency 'YJCocoa/UIKit/Extension'
            end
            ui.subspec 'TouchView' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/TouchView/*'
            end
            ui.subspec 'URLRouter' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/URLRouter/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Scheduler'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/URL'
                sub.dependency 'YJCocoa/AppFrameworks/UIKit/Extension'
            end
            ui.subspec 'ViewControllerTransitioning' do |sub|
                sub.source_files = 'YJCocoa/Classes/AppFrameworks/UIKit/ViewControllerTransitioning/*'
                sub.dependency 'YJCocoa/AppFrameworks/UIKit/Extension'
            end
        end
    end
    
    # 2 DeveloperTools
    s.subspec 'DeveloperTools' do |dt|
        dt.subspec 'Leaks' do |sub|
            sub.source_files = 'YJCocoa/Classes/DeveloperTools/Leaks/*'
            sub.dependency 'YJCocoa/AppFrameworks/Foundation/Extension'
            sub.dependency 'YJCocoa/AppFrameworks/Foundation/Safety'
            sub.dependency 'YJCocoa/AppFrameworks/Foundation/SingletonCenter'
            sub.dependency 'YJCocoa/System/Dispatch'
        end
        dt.subspec 'Timeline' do |sub|
            sub.source_files = 'YJCocoa/Classes/DeveloperTools/Timeline/*'
            sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
        end
    end
   
    # 3 System
    s.subspec 'System' do |system|
        system.subspec 'Dispatch' do |sub|
            sub.source_files = 'YJCocoa/Classes/System/Dispatch/*'
        end
        system.subspec 'Pthread' do |sub|
            sub.source_files = 'YJCocoa/Classes/System/Pthread/*'
        end
        system.subspec 'Security' do |sub|
            sub.source_files = 'YJCocoa/Classes/System/Security/**/*'
        end
    end
    
end


