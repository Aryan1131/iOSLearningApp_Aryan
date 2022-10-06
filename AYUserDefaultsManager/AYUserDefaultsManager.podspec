Pod::Spec.new do |spec|
  spec.name         = 'AYUserDefaultsManager'
  spec.version      = '3.1.0'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/tonymillion/Reachability'
  spec.authors      = { 'Aryan Yadav' => 'aryanyadav@navi.com' }
  spec.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  spec.source       = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' }
  spec.source_files = "AYUserDefaultsManager", "AYUserDefaultsManager/**/*.{swift,xib}"
  spec.framework    = 'SystemConfiguration'
end