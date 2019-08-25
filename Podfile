# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def required_pods
	pod 'RxSwift', '~> 4.0'
	pod 'Moya/RxSwift', '~> 13.0'
end

def rx_extensions_pods
	pod 'RxDataSources', '~> 3.1'
end

def helper_pods
	pod 'Eureka'
	pod 'Kingfisher', '~> 5.0'
	pod 'XCGLogger', '~> 7.0.0'
end

target 'Microblog' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Microblog
  required_pods
  helper_pods
  rx_extensions_pods

  target 'MicroblogTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
