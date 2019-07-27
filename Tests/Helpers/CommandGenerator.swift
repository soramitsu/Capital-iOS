import Foundation
import Cuckoo

func createMockedCommandFactory() -> MockWalletCommandFactoryProtocol {
    let command = MockWalletPresentationCommandProtocol()

    stub(command) { stub in
        when(stub).execute().thenDoNothing()
    }

    let commandFactory = MockWalletCommandFactoryProtocol()

    stub(commandFactory) { stub in
        when(stub).prepareSendCommand().then { return command }
        when(stub).prepareReceiveCommand().then { return command }
        when(stub).prepareWithdrawCommand().then { return command }
        when(stub).prepareScanReceiverCommand().then { return command }
        when(stub).prepareAssetDetailsCommand(for: any()).then { _ in return command }
    }

    return commandFactory
}
