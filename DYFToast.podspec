Pod::Spec.new do |s|

  s.name         = "DYFToast"
  s.version      = "2.0.4"
  s.summary      = "Realize the simulation of Android's Toast in iOS."
  s.description  = <<-DESC
	This project uses chain programming and point syntax operation to realize the simulation of Android's Toast in iOS, and its code is concise and efficient.
                   DESC

  s.homepage     = "https://github.com/dgynfi/DYFToast"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "dyf" => "vinphy.teng@foxmail.com" }

  s.platform     = :ios

  s.ios.deployment_target       = "8.0"
  # s.osx.deployment_target     = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target    = "9.0"

  s.source       = { :git => "https://github.com/dgynfi/DYFToast.git", :tag => s.version.to_s }

  s.source_files = "Classes", "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.frameworks = "Foundation", "UIKit", "CoreGraphics"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end

