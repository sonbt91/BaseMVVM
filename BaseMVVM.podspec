Pod::Spec.new do |s|
  s.name             = 'BaseMVVM'
  s.version          = '0.1.0'
  s.summary          = 'My base MVVM Pod'
 
  s.description      = <<-DESC
Used for projects that applies MVVM architect
                       DESC
 
  s.homepage         = 'https://github.com/sonbt91/BaseMVVM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Son Bui' => 'sonbt91@gmail.com' }
  s.source           = { :git => 'https://github.com/sonbt91/BaseMVVM.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = '*'
 
end