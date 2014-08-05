Pod::Spec.new do |s|
  s.name         = "NBNPhotoChooser"
  s.version      = "0.0.6"
  s.platform     = :ios, 6.0
  s.summary      = "NBNPhotoChooser is an example implementation of the Tumblr Photo Chooser."
  s.homepage     = "https://github.com/nerdishbynature/NBNPhotoChooser"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Piet Brauer" => "piet@nerdishbynature.com" }
  s.source       = { :git => "https://github.com/nerdishbynature/NBNPhotoChooser.git", :tag => "#{s.version}" }
  s.source_files = 'Classes/**/*.{h,m}'
  s.resource_bundle = { s.name => 'Assets/*' }
  s.requires_arc = true
end
