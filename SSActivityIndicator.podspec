Pod::Spec.new do |s|

  s.name         = "SSActivityIndicator"
  s.version      = "0.1.2"
  s.summary      = "A dynamic Activity Indicator "
  s.description  = <<-DESC
                   * A rotating 'Activity Indicator' module. 
				   * Custom Indactor Image / Custom Size / Custom Color / Custom Speed
				   * (Optional) Add text under indicator 
				   * (Optional) Animation for text
				   * Simple Fade In / Fade Out Animation
                   DESC
  s.homepage     = "https://github.com/benediktveith/SSActivityIndicator"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Benedikt Veith"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/benediktveith/SSActivityIndicator.git", :tag => "0.1.2" }
  s.source_files  = "SSActivityIndicator/*.{h,m}"
end
