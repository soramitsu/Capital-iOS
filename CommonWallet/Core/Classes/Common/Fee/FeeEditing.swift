/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol FeeEditing: AnyObject {
    var delegate: FeeEditingDelegate? { get set}

    func startEditing(feeDescription: FeeDescription)
}

public protocol FeeEditingDelegate: AnyObject {
    func feeEditing(_ feeEditing: FeeEditing, didEdit feeDescription: FeeDescription)
}
