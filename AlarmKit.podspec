#
# Be sure to run `pod lib lint AlarmKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AlarmKit"
  s.version          = "0.1.0"
  s.summary          = "A simple way to create scheduled and repeating alarms in Swift."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       A simple way to create scheduled and repeating alarms in Swift. Can be used in iOS or OSX to make alarm clock apps, notification systems, or more.
                       DESC

  s.homepage         = "https://github.com/brimizer/AlarmKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Daniel Brim" => "brimizer@gmail.com" }
  s.source           = { :git => "https://github.com/brimizer/AlarmKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/brimizer'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'
  s.resource_bundles = {
    'AlarmKit' => ['Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
end
