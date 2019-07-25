Pod::Spec.new do |s|
  s.name             = 'CommonWallet'
  s.version          = '1.0.0'
  s.summary          = 'Soramitsu Common Wallet Implementation'

  s.description      = <<-DESC
Library allow fast integration of Soramitsu Wallet implementation into client applications for payment purpose. Implemetation includes both customizable UI and logic to communicate with Iroha blockchain.
                       DESC

  s.homepage         = 'https://github.com/soramitsu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrei Marin' => 'marin@soramitsu.co.jp', 'Ruslan Rezin' => 'rezin@soramitsu.co.jp' }
  s.source           = { :git => 'https://github.com/soramitsu/common-wallet-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'CommonWallet/Classes/**/*.swift'
  s.resources = ['CommonWallet/**/*.xcdatamodeld', 'CommonWallet/**/*.xib','CommonWallet/Assets/**/*']

  s.frameworks = 'UIKit', 'CoreImage'
  s.dependency 'IrohaCommunication'
  s.dependency 'RobinHood'
  s.dependency 'SoraUI'

  s.test_spec do |ts|
    ts.source_files = 'Tests/**/*'
    ts.dependency 'Cuckoo'
    ts.dependency 'OHHTTPStubs/Swift'
    ts.resources = ['Tests/**/*.json']
  end

end
