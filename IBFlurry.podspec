#
# Be sure to run `pod lib lint IBFlurry.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "IBFlurry"
  s.version          = "0.1.0"
  s.summary          = "Flurry in Interface builder."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Tag views in Interface build to log Flurry events.
                       DESC

  s.homepage         = "https://github.com/darkcl/IBFlurry"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Yeung Yiu Hung" => "hkclex@gmail.com" }
  s.source           = { :git => "https://github.com/darkcl/IBFlurry.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/darkcl_dev'

  s.ios.deployment_target = '7.0'

  s.source_files = 'IBFlurry/Classes/**/*'
  s.resource_bundles = {
    'IBFlurry' => ['IBFlurry/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Flurry-iOS-SDK/FlurrySDK', '~> 7.1.0'
end
