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

    let assetCommand = MockAssetDetailsCommadProtocol()

    stub(assetCommand) { stub in
        when(stub).execute().thenDoNothing()
        when(stub).ignoredWhenSingleAsset.get.thenReturn(true)
        when(stub).ignoredWhenSingleAsset.set(any()).thenDoNothing()
    }

    let commandFactory = MockWalletCommandFactoryProtocol()

    stub(commandFactory) { stub in
        when(stub).prepareSendCommand(for: any()).then { _ in return command }
        when(stub).prepareReceiveCommand(for: any()).then { _ in return command }
        when(stub).prepareWithdrawCommand(for: any(), optionId: any()).then { (_, _) in return command }
        when(stub).prepareScanReceiverCommand().then { _ in return command }
        when(stub).prepareAssetDetailsCommand(for: any()).then { _ in return assetCommand }
        when(stub).prepareTransactionDetailsCommand(with: any()).then { _ in return command }
    }

    return commandFactory
}
