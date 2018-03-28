Pod::Spec.new do |s|
s.name             = 'PXSiriWave'
s.version          = '0.0.0'
s.summary          = 'iOS: Siri Waveform effect similar to 9'

s.description      = <<-DESC
iOS: Siri Waveform effect similar to 9
DESC

s.homepage         = 'https://github.com/prscX/PXSiriWave9'
s.license          = { :type => 'APACHE', :file => 'LICENSE' }
s.author           = { 'Pranav Raj Singh Chauhan' => 'pranavchauhan01@gmail.com' }
s.source           = { :git => 'https://github.com/prscX/PXSiriWave9.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'
s.source_files = 'PXSiriWave/*'

end
## Execute push: $pod trunk push PXSiriWave.podspec
