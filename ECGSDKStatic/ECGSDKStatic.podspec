#
# Be sure to run `pod lib lint ECGSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ECGSDKStatic'
  s.version          = '0.3.3'
  s.summary          = 'SIMO ECG Analysis Lib(Static)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An ECG Processing Library
                       DESC

  s.homepage         = 'https://github.com/GrayLand119/ecgi_ring_sdk_ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guilin Lan' => '441726442@qq.com' }
  # s.source           = { :git => 'https://github.com/GrayLand119/ecgi_ring_sdk_ios.git', :tag => s.version.to_s }
  s.source           = { :path => '.' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # s.ios.deployment_target = '13.0'
  s.platform = :ios, '13.0'

  # s.source_files  = "ECGSDK.xcframework/**/*.h"
  # s.vendored_frameworks = 'ECGSDK.xcframework'
  # s.public_header_files = 'ECGSDK.xcframework/**/*.h'
  
  s.source_files  = "ECGSDK.framework/**/*.h", "TensorFlowLiteC.framework/**/*.h", "TFLTensorFlowLite.framework/**/*.h"
  s.vendored_frameworks = 'ECGSDK.framework', 'TensorFlowLiteC.framework', 'TFLTensorFlowLite.framework'
  s.public_header_files = 'ECGSDK.framework/**/*.h', 'TensorFlowLiteC.framework/**/*.h', 'TFLTensorFlowLite.framework/**/*.h'

  s.frameworks = 'UIKit', 'Foundation', 'ECGSDK', 'TensorFlowLiteC', 'TFLTensorFlowLite'
  
  s.resource_bundles = {
    'ECGSDK' => ['ECGSDK.framework/*.tflite']
  }
  
end
