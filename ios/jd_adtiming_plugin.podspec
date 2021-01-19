#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint jd_adtiming_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'jd_adtiming_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]'  => 'i386' }
  s.swift_version = '5.0'

  s.dependency 'FBAudienceNetwork', '6.2.1'
  s.dependency 'OpenMediationFacebookAdapter', '2.0.3'
  
  s.dependency 'UnityAds', '3.5.1'
  s.dependency 'OpenMediationUnityAdapter', '2.0.2'
  
  s.dependency 'AppLovinSDK', '6.14.6'
  s.dependency 'OpenMediationAppLovinAdapter', '2.0.2'
  
  s.dependency 'TapjoySDK', '12.7.0'
  s.dependency 'OpenMediationTapjoyAdapter', '2.0.2'
  
  s.dependency 'VungleSDK-iOS', '6.8.1'
  s.dependency 'OpenMediationVungleAdapter', '2.0.2'
  
  s.dependency 'AdTimingBidSDK', '5.0.1'
  s.dependency 'OpenMediationAdTimingAdapter', '2.0.2'
  
  s.dependency 'OpenMediation', '2.0.3'
  s.dependency 'OpenMediationTestSuite','1.3.0'
end
