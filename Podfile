# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'TrichJournal' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TrichJournal
  
  pod 'CSV.swift', '~> 2.4.3'
  pod 'DGCharts'


  target 'TrichJournalTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TrichJournalUITests' do
    # Pods for testing
  end
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
                 target.build_configurations.each do |config|
                     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
     config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
                   end
               end
           end
       end

end
