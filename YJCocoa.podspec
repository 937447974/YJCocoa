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
    s.version  = "8.6.0"
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
    s.ios.deployment_target = "8.0"
    
    
    # ——— Documentation And API Reference
    s.preserve_paths = 'Documentation/*.*'
    s.prepare_command = 'sh Documentation/docset-installed.sh'
    
    
    # ――― Build settings
    s.frameworks = "UIKit", "Foundation"
    s.requires_arc = true
    
    
    # ——— File patterns
    s.source_files = 'Cocoa/*.{h,m}'
    
    # ——— Subspecs
    s.default_subspec = 'AppFrameworks', 'AppServices', 'System'
    
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
            # Cache
            foundation.subspec 'Cache' do |cache|
                cache.source_files = 'Cocoa/AppFrameworks/Foundation/Cache/*.{h,m}'
                cache.dependency 'YJCocoa/System/Pthread'
            end
            # Calendar
            foundation.subspec 'Calendar' do |calendar|
                calendar.source_files = 'Cocoa/AppFrameworks/Foundation/Calendar/*.{h,m}'
            end
            # CodeInject
            foundation.subspec 'CodeInject' do |sub|
                sub.source_files = 'Cocoa/AppFrameworks/Foundation/CodeInject/*.{h,m}'
            end
            # DictionaryModel
            foundation.subspec 'DictionaryModel' do |dm|
                dm.source_files = 'Cocoa/AppFrameworks/Foundation/DictionaryModel/*.{h,m}'
                dm.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                dm.dependency 'YJCocoa/System/Dispatch'
            end
            # Directory
            foundation.subspec 'Directory' do |directory|
                directory.source_files = 'Cocoa/AppFrameworks/Foundation/Directory/*.{h,m}'
                directory.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                directory.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
            end
            # FileManager
            foundation.subspec 'FileManager' do |fileManager|
                fileManager.source_files = 'Cocoa/AppFrameworks/Foundation/FileManager/*.{h,m}'
            end
            foundation.subspec 'Http' do |http|
                http.source_files = 'Cocoa/AppFrameworks/Foundation/Http/*.{h,m}'
                http.dependency 'YJCocoa/AppFrameworks/Foundation/URLCode'
            end
            # KVO
            foundation.subspec 'KVO' do |kvo|
                kvo.source_files = 'Cocoa/AppFrameworks/Foundation/KVO/*.{h,m}'
            end
            foundation.subspec 'Log' do |log|
                log.source_files = 'Cocoa/AppFrameworks/Foundation/Log/*.{h,m}'
            end
            foundation.subspec 'NotificationCenter' do |nc|
                nc.source_files = 'Cocoa/AppFrameworks/Foundation/NotificationCenter/*.{h,m}'
            end
            foundation.subspec 'Other' do |other|
                other.source_files = 'Cocoa/AppFrameworks/Foundation/Other/*.{h,m}'
                other.dependency 'YJCocoa/System/Dispatch'
            end
            foundation.subspec 'Safety' do |sub|
                sub.source_files = 'Cocoa/AppFrameworks/Foundation/Safety/**/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                sub.dependency 'YJCocoa/System/Pthread'
            end
            foundation.subspec 'Scheduler' do |sub|
                sub.source_files = 'Cocoa/AppFrameworks/Foundation/Scheduler/**/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/CodeInject'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/NotificationCenter'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Safety'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                sub.dependency 'YJCocoa/System/Dispatch'
            end
            foundation.subspec 'Singleton' do |sub|
                sub.source_files = 'Cocoa/AppFrameworks/Foundation/Singleton/**/*'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                sub.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
                sub.dependency 'YJCocoa/System/Pthread'
            end
            # Swizzling
            foundation.subspec 'Swizzling' do |swizzling|
                swizzling.source_files = 'Cocoa/AppFrameworks/Foundation/Swizzling/*.{h,m}'
                swizzling.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                swizzling.dependency 'YJCocoa/System/Dispatch'
            end
            # Timer
            foundation.subspec 'Timer' do |timer|
                timer.source_files = 'Cocoa/AppFrameworks/Foundation/Timer/*.{h,m}'
                timer.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                timer.dependency 'YJCocoa/System/Security/Random'
            end
            # URLCode
            foundation.subspec 'URLCode' do |urlCode|
                urlCode.source_files = 'Cocoa/AppFrameworks/Foundation/URLCode/*.{h,m}'
            end
            # Router
            foundation.subspec 'URLRouter' do |router|
                router.source_files = 'Cocoa/AppFrameworks/Foundation/URLRouter/**/*.{h,m}'
                router.dependency 'YJCocoa/AppFrameworks/Foundation/Http'
                router.dependency 'YJCocoa/AppFrameworks/Foundation/Scheduler'
            end
            # URLSession
            foundation.subspec 'URLSession' do |session|
                session.source_files = 'Cocoa/AppFrameworks/Foundation/URLSession/*.{h,m}'
                session.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/Foundation/URLSession/Core/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/Cache'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/URLSession/Request'
                end
                session.subspec 'Request' do |request|
                    request.source_files = 'Cocoa/AppFrameworks/Foundation/URLSession/Request/*.{h,m}'
                    request.dependency 'YJCocoa/AppFrameworks/Foundation/DictionaryModel'
                    request.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                end
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
            # CollectionView
            uik.subspec 'CollectionView' do |cv|
                cv.source_files = 'Cocoa/AppFrameworks/UIKit/CollectionView/*.{h,m}'
                cv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/CollectionView/{Cell,Manager}/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/CollectionView/CellObject'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/ScrollViewManager'
                    core.dependency 'YJCocoa/System/Dispatch'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                end
                cv.subspec 'CellObject' do |co|
                    co.source_files = 'Cocoa/AppFrameworks/UIKit/CollectionView/CellObject/*.{h,m}'
                    co.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
                end
            end
            # Color
            uik.subspec 'Color' do |color|
                color.source_files = 'Cocoa/AppFrameworks/UIKit/Color/*.{h,m}'
            end
            # UITextField和UITextView可输入长度控制
            uik.subspec 'InputLength' do |il|
                il.source_files  = 'Cocoa/AppFrameworks/UIKit/InputLength/*.{h,m}'
            end
            # NavigationBar
            uik.subspec 'NavigationBar' do |nb|
                nb.source_files = 'Cocoa/AppFrameworks/UIKit/NavigationBar/*.{h,m}'
                nb.dependency 'YJCocoa/AppFrameworks/UIKit/ViewGeometry'
            end
            # NavigationRouter
            uik.subspec 'NavigationRouter' do |nr|
                nr.source_files = 'Cocoa/AppFrameworks/UIKit/NavigationRouter/*.{h,m}'
                nr.dependency 'YJCocoa/AppFrameworks/Foundation/URLRouter'
            end
            # PageView
            uik.subspec 'PageView' do |pv|
                pv.source_files = 'Cocoa/AppFrameworks/UIKit/PageView/*.{h,m}'
                pv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/PageView/{Cell,Manager}/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/PageView/CellObject'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/Timer'
                end
                pv.subspec 'CellObject' do |co|
                    co.source_files = 'Cocoa/AppFrameworks/UIKit/PageView/CellObject/*.{h,m}'
                end
            end
            # ScrollViewManager
            uik.subspec 'ScrollViewManager' do |svm|
                svm.source_files = 'Cocoa/AppFrameworks/UIKit/ScrollViewManager/*.{h,m}'
                svm.dependency 'YJCocoa/AppFrameworks/Foundation/AOP'
                svm.dependency 'YJCocoa/AppFrameworks/UIKit/ViewGeometry'
            end
            # UITableView
            uik.subspec 'TableView' do |tv|
                tv.source_files = 'Cocoa/AppFrameworks/UIKit/TableView/*.{h,m}'
                tv.subspec 'Core' do |core|
                    core.source_files = 'Cocoa/AppFrameworks/UIKit/TableView/{Manager,Cell}/*.{h,m}'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/TableView/CellObject'
                    core.dependency 'YJCocoa/AppFrameworks/UIKit/ScrollViewManager'
                    core.dependency 'YJCocoa/AppFrameworks/Foundation/Log'
                end
                tv.subspec 'CellObject' do |co|
                    co.source_files = 'Cocoa/AppFrameworks/UIKit/TableView/CellObject/*.{h,m}'
                    co.dependency 'YJCocoa/AppFrameworks/Foundation/Other'
                end
            end
            # ViewControllerTransitioning
            uik.subspec 'ViewControllerTransitioning' do |vct|
                vct.source_files = 'Cocoa/AppFrameworks/UIKit/ViewControllerTransitioning/YJUIViewControllerTransitioning.h'
                vct.subspec 'Core' do |co|
                    co.source_files = 'Cocoa/AppFrameworks/UIKit/ViewControllerTransitioning/Core/*.{h,m}'
                    co.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                    co.dependency 'YJCocoa/AppFrameworks/UIKit/ViewGeometry'
                end
                vct.subspec 'PresentDismiss' do |pd|
                    pd.source_files = 'Cocoa/AppFrameworks/UIKit/ViewControllerTransitioning/PresentDismiss/*.{h,m}'
                    pd.dependency 'YJCocoa/AppFrameworks/UIKit/ViewControllerTransitioning/Core'
                end
                vct.subspec 'PushPop' do |pp|
                    pp.source_files = 'Cocoa/AppFrameworks/UIKit/ViewControllerTransitioning/PushPop/*.{h,m}'
                    pp.dependency 'YJCocoa/AppFrameworks/UIKit/ViewControllerTransitioning/Core'
                end
            end
            # UIView(UIViewGeometry)相关扩展，可快速设置fram相关
            uik.subspec 'ViewGeometry' do |vg|
                vg.source_files  = 'Cocoa/AppFrameworks/UIKit/ViewGeometry/*.{h,m}'
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
                cdCore.dependency 'YJCocoa/System/Dispatch'
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
    
    #3 DeveloperTools
    s.subspec 'DeveloperTools' do |dt|
        dt.source_files = 'Cocoa/DeveloperTools/*.{h,m}'
        # Leaks
        dt.subspec 'Leaks' do |leaks|
            leaks.source_files = 'Cocoa/DeveloperTools/Leaks/*.{h,m}'
            leaks.subspec 'Core' do |lcore|
                lcore.source_files = 'Cocoa/DeveloperTools/Leaks/Core/*.{h,m}'
                lcore.dependency 'YJCocoa/AppFrameworks/Foundation/Singleton'
                lcore.dependency 'YJCocoa/System/Dispatch'
            end
            leaks.subspec 'UIView' do |luiv|
                luiv.source_files = 'Cocoa/DeveloperTools/Leaks/UIView/*.{h,m}'
                luiv.dependency 'YJCocoa/AppFrameworks/Foundation/Swizzling'
                luiv.dependency 'YJCocoa/DeveloperTools/Leaks/Core'
            end
            leaks.subspec 'UIViewController' do |luivc|
                luivc.source_files = 'Cocoa/DeveloperTools/Leaks/UIViewController/*.{h,m}'
                luivc.dependency 'YJCocoa/AppFrameworks/Foundation/Swizzling'
                luivc.dependency 'YJCocoa/DeveloperTools/Leaks/Core'
            end
        end
        # MemoryInfo
        dt.subspec 'MemoryInfo' do |mi|
            mi.source_files = 'Cocoa/DeveloperTools/MemoryInfo/*.{h,m}'
        end
        dt.subspec 'Timeline' do |tl|
            tl.source_files = 'Cocoa/DeveloperTools/Timeline/*'
        end
        # TimeProfiler
        dt.subspec 'TimeProfiler' do |tp|
            tp.source_files = 'Cocoa/DeveloperTools/TimeProfiler/*.{h,m}'
            tp.dependency 'YJCocoa/AppFrameworks/Foundation/Swizzling'
        end
    end
    
    # 4 System
    s.subspec 'System' do |system|
        system.source_files = 'Cocoa/System/*.{h,m}'
        system.subspec 'Dispatch' do |dispatch|
            dispatch.source_files = 'Cocoa/System/Dispatch/*.{h,m}'
            dispatch.dependency 'YJCocoa/System/Other'
        end
        system.subspec 'Other' do |other|
            other.source_files = 'Cocoa/System/Other/*.{h,m}'
        end
        # pthread
        system.subspec 'Pthread' do |pthread|
            pthread.source_files = 'Cocoa/System/Pthread/*.{h,m}'
            pthread.dependency 'YJCocoa/System/Other'
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


