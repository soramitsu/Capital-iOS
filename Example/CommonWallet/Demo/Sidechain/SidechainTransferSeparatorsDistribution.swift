/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet
import SoraUI

struct SidechainTransferSeparatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol  {
    var assetBorderType: BorderType {
        [.bottom]
    }

    var receiverBorderType: BorderType {
        [.bottom]
    }

    var amountWithFeeBorderType: BorderType {
        []
    }

    var amountWithoutFeeBorderType: BorderType {
        [.bottom]
    }

    var firstFeeBorderType: BorderType {
        [.top]
    }
    var middleFeeBorderType: BorderType {
        [.top]
    }

    var lastFeeBorderType: BorderType {
        [.top]
    }
    var singleFeeBorderType: BorderType {
        [.top]
    }

    var descriptionBorderType: BorderType {
        [.bottom]
    }
}
