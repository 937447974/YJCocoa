#
# Be sure to run `pod lib lint FrameworkA.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name     = 'FrameworkA'
  s.version  = '0.1.0'
  s.summary  = 'A short description of FrameworkA.'
  s.homepage = 'https://github.com/937447974@qq.com/FrameworkA'
  #s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = { '937447974@qq.com' => '937447974@qq.com' }
  s.source   = { :git => 'https://github.com/937447974@qq.com/FrameworkA.git', :tag => s.version.to_s }
  
  # ――― Platform
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  
  # ——— Dependency
  s.dependency 'YJCocoa/AppFrameworks/Foundation/CodeInject'
  
  # ——— File patterns
  s.source_files = 'FrameworkA/Classes/**/*'
  
end
