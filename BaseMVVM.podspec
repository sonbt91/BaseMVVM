Pod::Spec.new do |s|
  s.name             = 'BaseMVVM'
  s.version          = '1.1.0'
  s.summary          = 'My base MVVM Pod'
 
  s.description      = <<-DESC
Used for projects that applies MVVM architect
                       DESC
 
  s.homepage         = 'https://github.com/sonbt91/BaseMVVM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Son Bui' => 'sonbt91@gmail.com' }
  s.source           = { :git => 'https://github.com/sonbt91/BaseMVVM.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = '*'
 
end


Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "BaseMVVM"
s.summary = "BaseMVVM lets a user select an ice cream flavor."
s.requires_arc = true

# 2
s.version = "1.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Son Bui" => "sonbt91@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/sonbt91/BaseMVVM"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/sonbt91/BaseMVVM.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"
s.dependency 'SnapKit'
s.dependency 'CocoaLumberjack/Swift'
s.dependency 'Kingfisher'
s.dependency 'KeychainAccess'
s.dependency 'IQKeyboardManagerSwift', '~> 6.0.4'
s.dependency 'Localize-Swift'
s.dependency 'DZNEmptyDataSet'
s.dependency 'RxSwift',    '~> 4.0'
s.dependency 'RxCocoa',    '~> 4.0'
s.dependency 'Moya/RxSwift', '~> 11.0'
s.dependency 'SwiftyJSON'

# 8
#s.source_files = "BaseMVVM/**/*.{swift}"
s.source_files = "BaseMVVM/*"

# 9
s.resources = "BaseMVVM/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end

