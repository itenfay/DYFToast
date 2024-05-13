#
# Be sure to run `pod lib lint DYFToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DYFToast'
    s.version          = '2.0.5'
    s.summary          = 'Realize the simulation of Android's Toast in iOS.'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    TODO: This project uses chain programming and point syntax operation to realize the simulation of Android's Toast in iOS, and its code is concise and efficient.
    DESC

    s.homepage         = 'https://github.com/chenxing640/DYFToast'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'TengFei' => 'hansen981@126.com' }
    s.source           = { :git => 'https://github.com/chenxing640/DYFToast.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'
    # s.osx.deployment_target     = "10.7"
    # s.watchos.deployment_target = "2.0"
    # s.tvos.deployment_target    = "9.0"

    s.source_files = 'DYFToast/Classes/**/*'
    s.public_header_files = "DYFToast/Classes/**/*.h"

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.resource_bundles = {
    #   'DYFToast' => ['DYFToast/Assets/*.png']
    # }

    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'

end
