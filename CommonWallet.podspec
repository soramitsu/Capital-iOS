Pod::Spec.new do |s|
  s.name             = 'CommonWallet'
  s.version          = '1.14.0'

  s.summary          = 'Soramitsu Common Wallet Implementation'

  s.description      = <<-DESC
Library allow fast integration of Soramitsu Wallet implementation into client applications for payment purpose. Implemetation includes both customizable UI and logic to communicate with Iroha blockchain.
                       DESC

  s.homepage         = 'https://github.com/soramitsu'
  s.license          = { :type => 'GPL 3.0', :file => 'LICENSE' }
  s.author           = { 'Andrei Marin' => 'marin@soramitsu.co.jp', 'Ruslan Rezin' => 'rezin@soramitsu.co.jp' }
  s.source           = { :git => 'https://github.com/soramitsu/Capital-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'VALID_ARCHS' => 'x86_64 armv7 arm64'  }

  s.subspec 'Core' do |core|
      core.source_files = 'CommonWallet/Core/Classes/**/*.swift'
      core.resources = ['CommonWallet/Core/**/*.xcdatamodeld', 'CommonWallet/Core/**/*.xib','CommonWallet/Core/Assets/**/*']

      core.frameworks = 'UIKit', 'CoreImage'

      core.dependency 'RobinHood', '~> 2.6.0'
      core.dependency 'SoraUI', '~> 1.10.0'
      core.dependency 'SoraFoundation/DateProcessing', '~> 0.9.0'
      core.dependency 'SoraFoundation/NotificationHandlers', '~> 0.9.0'
      core.dependency 'SoraFoundation/Localization', '~> 0.9.0'
  end

  s.subspec 'IrohaMiddleware' do |im|
      im.source_files = 'CommonWallet/IrohaMiddleware/**/*.swift'

      im.dependency 'CommonWallet/Core'
      im.dependency 'IrohaCommunication', '~> 4.0.0'
      im.dependency 'RobinHood', '~> 2.6.0'
  end

  s.test_spec do |ts|
    ts.source_files = 'Tests/**/*'
    ts.dependency 'Cuckoo'
    ts.dependency 'OHHTTPStubs/Swift', '~> 8.0.0'
    ts.resources = ['Tests/**/*.json']
  end

end
