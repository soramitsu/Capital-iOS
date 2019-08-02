/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

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
        when(stub).prepareWithdrawCommand(for: any(), assetId: any()).then { (_, _) in return command }
        when(stub).prepareScanReceiverCommand(defaultAssetId: any()).then { _ in return command }
        when(stub).prepareAssetDetailsCommand(for: any()).then { _ in return command }
    }

    return commandFactory
}
