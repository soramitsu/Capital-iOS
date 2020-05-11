/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

public protocol OperationDefinitionSeparatorsDistributionProtocol {
    var assetBorderType: BorderType { get }
    var receiverBorderType: BorderType { get }
    var amountWithFeeBorderType: BorderType { get }
    var amountWithoutFeeBorderType: BorderType { get }
    var firstFeeBorderType: BorderType { get }
    var middleFeeBorderType: BorderType { get }
    var lastFeeBorderType: BorderType { get }
    var singleFeeBorderType: BorderType { get }
    var descriptionBorderType: BorderType { get }
}

struct DefaultSeparatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol {
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
        [.bottom]
    }
    var middleFeeBorderType: BorderType {
        [.bottom]
    }

    var lastFeeBorderType: BorderType {
        [.bottom]
    }
    var singleFeeBorderType: BorderType {
        [.bottom]
    }

    var descriptionBorderType: BorderType {
        []
    }
}
