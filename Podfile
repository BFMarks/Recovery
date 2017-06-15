# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'RecoveryAI' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RecoveryAI
  #pod 'Charts', '~> 3.0.1'
  #pod 'RealmSwift', '~> 2.0.2'
  pod 'SwiftCharts', '~> 0.5'
  pod "PubNub", "~> 4"
  pod 'Alamofire', '~> 4.3'
  pod 'DocuSignESign', '~> 2.0.0'
  pod "Button", "~> 4"
  pod 'AppsFlyerFramework', '~> 4.7'
  pod 'KochavaTrackeriOS'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end


end
