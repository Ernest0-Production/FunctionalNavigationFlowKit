Pod::Spec.new do |spec|

  spec.name         = "FunctionalNavigationFlowKit"
  spec.version      = "0.0.5"
  spec.summary      = "Functional way of declarative description of UI navigation."
  spec.homepage     = "https://github.com/Ernest0-Production/FunctionalNavigationFlowKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Ernest" => "magatar136@yandex.ru" }
  spec.social_media_url   = "https://t.me/Ernest0n"

  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  spec.swift_versions = '5.0'

  spec.source       = {
    :git => "https://github.com/Ernest0-Production/FunctionalNavigationFlowKit.git",
    :branch => "main",
    :tag => "#{spec.version}"
   }

  spec.source_files  = "Sources/FunctionalNavigationFlowKit/**/*.swift"
end
