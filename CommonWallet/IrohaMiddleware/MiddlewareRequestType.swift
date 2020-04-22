/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public enum MiddlewareRequestType {
    case balance
    case transfer
    case transferMetadata
    case history
    case search
    case contacts
    case withdrawalMetadata
    case withdraw
}
