/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import FireMock
import CommonWallet
import RobinHood

protocol ServiceMockProtocol: FireMockProtocol {}

enum UrlMockType {
    case full
    case regex
}

extension ServiceMockProtocol {
    var afterTime: TimeInterval {
        return 1.0
    }

    var statusCode: Int {
        return 200
    }

    static func register(mock: Self,
                         networkResolver: WalletNetworkResolverProtocol,
                         requestType: WalletRequestType,
                         mockMethod: MockHTTPMethod,
                         urlMockType: UrlMockType = .full) throws {
        let urlTemplate = networkResolver.urlTemplate(for: requestType)

        switch urlMockType {
        case .full:
            guard let url = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }
            FireMock.register(mock: mock, forURL: url, httpMethod: mockMethod)
        case .regex:
            let regex = try EndpointBuilder(urlTemplate: urlTemplate).buildRegex()
            FireMock.register(mock: mock, regex: regex, httpMethod: mockMethod)
        }
    }

    var bundle: Bundle {
        return Bundle(for: LoadableBundleClass.self)
    }
}
