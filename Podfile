platform :ios, '9.0'

target 'Flash Chat' do
  use_frameworks!

pod 'Alamofire'
pod 'SwiftyJSON'
pod 'SVProgressHUD'
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'ChameleonFramework'

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
end
end
end

end
