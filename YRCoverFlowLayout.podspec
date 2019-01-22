#
# Be sure to run `pod lib lint YRActivityIndicator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YRCoverFlowLayout'
  s.version          = '1.3.0'
  s.summary          = 'Simple cover animation flow layout for collection view'
  s.description      = <<-DESC
This custom layout enhances your collection view with cover flow effect.
You don’t need to worry about items(cells) positions, spaces between them, etc. because it’s already done in YRCoverFlowLayout! You simply design your cell and return them as usual in datasource methods and YRCoverFlowLayout handles the rest.
DESC
  s.homepage         = 'https://github.com/solomidSF/YRCoverFlowLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yurii Romanchenko' => 'yuri.boorie@gmail.com' }
  s.source           = { :git => 'https://github.com/solomidSF/YRCoverFlowLayout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/YRCoverFlowLayout/*'
  
  # s.resource_bundles = {
  #   'YRCoverFlowLayout' => ['YRCoverFlowLayout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
