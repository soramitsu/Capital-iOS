/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsLocalSearchEngineProtocol {
    func search(query: String,
                parameters: ContactModuleParameters,
                locale: Locale,
                delegate: ContactViewModelDelegate?,
                commandFactory: WalletCommandFactoryProtocol) -> [ContactViewModelProtocol]?
}

public protocol ContactsLocalSearchResultProtocol: ContactViewModelProtocol {}

public extension ContactsLocalSearchResultProtocol {
    var cellReuseIdentifier: String { ContactConstants.contactCellIdentifier }
    var itemHeight: CGFloat { ContactConstants.contactCellHeight }
}
