# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'Clean-MVVM'
project 'Domain/Domain.project'
project 'Data/Data.project'
project 'Presentation/Presentation.project'
project 'Clean-MVVM/Clean-MVVM.project'

def pods 
    pod 'RxSwift', '~> 5'
end

target 'Clean-MVVM' do
  project 'Clean-MVVM/Clean-MVVM.project'

    target 'Clean-MVVMTests' do
      pod 'RxSwift', '~> 5'

      # Test
      pod 'RxTest', '~> 5'
      pod 'Nimble', '~> 9'
    end

end

target 'Domain' do 
    project 'Domain/Domain.project'
    pods
end

target 'Data' do 
    project 'Data/Data.project'
    pods
end

target 'Presentation' do 
    project 'Presentation/Presentation.project'
    pods
    pod 'RxCocoa', '~> 5'
    pod 'RxDataSources', '~> 4.0'

    pod 'Kingfisher', '~> 6.0'
    pod 'SnapKit', '~> 5.0.0'
    pod 'Then', '~> 2.7.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == "Nimble"
            target.build_configurations.each do |config|
                xcconfig_path = config.base_configuration_reference.real_path
                xcconfig = File.read(xcconfig_path)
                new_xcconfig = xcconfig.sub('lswiftXCTest', 'lXCTestSwiftSupport')
                File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
            end
        end
    end
end