Pod::Spec.new do |s|
  s.name             = 'CommonWallet'
  s.version          = '1.6.0'
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

  s.source_files = 'CommonWallet/Classes/**/*.swift'
  s.resources = ['CommonWallet/**/*.xcdatamodeld', 'CommonWallet/**/*.xib','CommonWallet/Assets/**/*']

  s.frameworks = 'UIKit', 'CoreImage'
  s.dependency 'IrohaCommunication', '~> 3.4.1'
  s.dependency 'RobinHood', '~> 2.0.0'
  s.dependency 'SoraUI', '~> 1.8.7'
  s.dependency 'SoraFoundation/DateProcessing', '~> 0.3.0'
  s.dependency 'SoraFoundation/NotificationHandlers', '~> 0.3.0'
  s.dependency 'SoraFoundation/Localization', '~> 0.3.0'

  s.test_spec do |ts|
    ts.source_files = 'Tests/**/*'
    ts.dependency 'Cuckoo'
    ts.dependency 'OHHTTPStubs/Swift'
    ts.resources = ['Tests/**/*.json']
  end

end
