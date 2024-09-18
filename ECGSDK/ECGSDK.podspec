#
# Be sure to run `pod lib lint ECGSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ECGSDK'
  s.version          = '0.0.4'
  s.summary          = 'SIMO ECG Analysis Lib'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An ECG Processing Library
                       DESC

  s.homepage         = 'https://github.com/Shenzhen-Simo-Technology-co-LTD/ecgi_ring_sdk_ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guilin Lan' => '441726442@qq.com' }
  # s.source           = { :git => 'https://github.com/Shenzhen-Simo-Technology-co-LTD/ecgi_ring_sdk_ios.git', :tag => s.version.to_s }
  s.source           = { :path => '.' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # s.ios.deployment_target = '13.0'
  s.platform = :ios, '13.0'

  s.source_files  = "ECGSDK.xcframework/**/*.h"
  # s.source_files = 'ECGSDK.xcframework/ios-arm64/ECGSDK.framework/Headers/*.h'
  s.vendored_frameworks = 'ECGSDK.xcframework'
  s.public_header_files = 'ECGSDK.xcframework/**/*.h'
  
  # s.resource_bundles = {
  #   'ECGSDK' => ['ECGSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'ECGSDK'
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.dependency 'TensorFlowLiteObjC', '~>2.14.0'
  
end
