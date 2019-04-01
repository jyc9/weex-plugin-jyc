# coding: utf-8

Pod::Spec.new do |s|
  s.name         = "WeexPluginJyc"
  s.version      = "0.0.1"
  s.summary      = "Weex Plugin"

  s.description  = <<-DESC
                   Weexplugin Source Description
                   DESC

  s.homepage     = "https://github.com"
  s.license = {
    :type => 'Copyright',
    :text => <<-LICENSE
            copyright
    LICENSE
  }
  s.authors      = {
                     "yourname" =>"youreamail"
                   }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  s.source       = { :git => 'https://github.com/jyc9/weex-jyc.git', :tag => 'please input you github tag' }
  s.source_files  = "ios/Sources/**/*.{h,m,mm}"
  s.public_header_files = 'ios/Sources/*.h'
  s.resource = ['ios/resouces/jycKit.bundle', 'ios/resouces/*.plist']
  s.requires_arc = true
  s.dependency "WeexPluginLoader"
  s.dependency "WeexSDK"
  s.dependency "SDWebImage", '3.7.5'
  s.subspec 'Core' do |cs|
      cs.dependency 'BeeKit'
  end
end
