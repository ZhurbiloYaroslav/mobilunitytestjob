# Uncomment the next line to define a global platform for your project
platform :ios, '13.1'
use_frameworks!

def shared_pods
  pod 'IGListKit', '4.0.0'
end

target 'MobilunityTestJob' do
  shared_pods
  pod 'R.swift', '5.1.0'
  pod 'Swinject', '2.7.1'
  pod 'RxSwift', '5.1.1'
  pod 'Alamofire', '5.0.5'

end

target 'MobilunityTestJobTests' do
    pod 'OHHTTPStubs/Swift', '8.0.0'
    shared_pods
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if config.name == 'OHHTTPStubs/Swift'
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
          end
        end
    end
end
