#
# Be sure to run `pod lib lint HongLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HongLibrary'
  s.version          = '0.1.0'
  s.summary          = 'A short description of HongLibrary.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liujh1125/HongLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liujh1125' => 'liujh1125@gmail.com' }
  s.source           = { :git => 'https://github.com/liujh1125/HongLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HongLibrary/Classes/**/*.{h,m,a,c}'

  # s.resource_bundles = {
  #   'HongLibrary' => ['HongLibrary/Assets/*.png']
  # }
  s.resources =  ['Pod/Assets/**/*.{png,jpg}','Pod/Classes/*.{xib,storyboard,html,bundle}','Pod/Classes/**/**/*.{png,xib,storyboard,html,bundle}']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.frameworks = 'UIKit', 'MapKit', 'CoreLocation'


  s.libraries = "sqlite3"

  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'GPUImage'
  s.dependency 'MBProgressHUD'
  s.dependency 'JSONModel'
  s.dependency 'Masonry'
  s.dependency 'FMDB', '~> 2.6.2'
end
