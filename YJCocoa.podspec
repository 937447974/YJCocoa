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
    s.version  = "8.7.0"
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
    s.ios.deployment_target = "9.0"

    # ――― Build settings
    s.requires_arc = true
    s.pod_target_xcconfig = {
        'SWIFT_VERSION' => '5.0'
    }

    # ——— File patterns
    s.source_files = 'YJCocoa/Classes/**/*'

    # ——— Subspecs
#s.default_subspec = 'AppFrameworks'

    # 1 App Frameworks
    s.subspec 'AppFrameworks' do |af|
        af.source_files = 'YJCocoa/Classes/AppFrameworks/*'
        # 1.1 Foundation
        af.subspec 'Foundation' do |foundation|
            # AOP
            foundation.subspec 'AOP' do |aop|
                aop.source_files = 'YJCocoa/Classes/AppFrameworks/Foundation/AOP/*.swift'
            end
        end
    end

end


