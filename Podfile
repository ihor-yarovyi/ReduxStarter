# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'
source 'https://github.com/ihor-yarovyi/PodSpecs'
source 'https://cdn.cocoapods.org/'

workspace 'ReduxApp'

def swiftLint
  pod 'SwiftLint'
end

def networkLayer 
  pod 'NetworkLayer', '0.1.6'
end

def databaseLayer
  pod 'DatabaseLayer'
end

def swiftGen
  pod 'SwiftGen'
end

def reduxStore
  pod 'ReduxStore'
end

def predicateKit
  pod 'PredicateKit'
end

target 'ReduxApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ReduxApp
  swiftLint
  networkLayer

  target 'Resources' do
    inherit! :search_paths
    swiftGen
  end

  target 'Redux' do
    inherit! :search_paths
    reduxStore
  end

  target 'SideEffects' do
    inherit! :search_paths
    reduxStore
    predicateKit
  end

  target 'NetworkClient' do
    inherit! :search_paths
    networkLayer
  end

  target 'DatabaseClient' do
    inherit! :search_paths
    databaseLayer
    predicateKit
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end