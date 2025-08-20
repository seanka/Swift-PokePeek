# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "12.0"
    end
  end
end

target 'PokePeek' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PokePeek
  pod 'Alamofire', '5.6.4'
  pod 'Kingfisher', '7.6.2'
  pod 'RxSwift', '6.5.0'
  pod 'MBProgressHUD', '1.2.0'
  pod 'XLPagerTabStrip', '9.0.0'
end
