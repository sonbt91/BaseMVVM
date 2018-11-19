# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!
inhibit_all_warnings!

workspace 'MVVMBaseProject'

# Define common pods shared between targets
def shared_pods
    pod 'SnapKit' #autolayout process library https://github.com/SnapKit/SnapKit
    pod 'CocoaLumberjack/Swift' #Handle logging
    pod 'Kingfisher'
    pod 'KeychainAccess' #Keychain access framework https://github.com/kishikawakatsumi/KeychainAccess
    pod 'IQKeyboardManagerSwift', '~> 6.0.4'
    pod 'Localize-Swift'
    pod 'DZNEmptyDataSet'
#    pod 'SwiftLint'

    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'Moya/RxSwift', '~> 11.0'
    pod 'SwiftyJSON'
    
end

target 'MVVMBaseProject' do
    shared_pods
end

target 'CodeBase' do
    project 'CodeBase/CodeBase'
    shared_pods
end

target 'Register' do
    project 'Register/Register'
    shared_pods
end

target 'Login' do
    project 'Login/Login'
    shared_pods
end
