/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import OHHTTPStubs
import CommonWallet
import RobinHood


protocol ServiceMockProtocol {

    var mockFile: String { get }

}


enum UrlMockType {

    case full
    case regex

}

extension ServiceMockProtocol {
    
    var statusCode: Int32 {
        return 200
    }

    static func register(mock: Self,
                         networkResolver: WalletNetworkResolverProtocol,
                         requestType: WalletRequestType,
                         httpMethod: HttpMethod,
                         urlMockType: UrlMockType = .full,
                         body: Data? = nil) throws {
        let urlTemplate = networkResolver.urlTemplate(for: requestType)
        
        let response: OHHTTPStubsResponseBlock = { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFileInBundle(mock.mockFile, mock.bundle)!,
                statusCode: mock.statusCode,
                headers: ["Content-Type": "application/json"]
            )
        }

        switch urlMockType {
        case .full:
            stub(condition: isAbsoluteURLString(urlTemplate), response: response)
        case .regex:
            guard
                let urlString = urlTemplate.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: urlString) else {
                throw NetworkBaseError.invalidUrl
            }
            
            if let body = body {
                stub(condition: hasBody(body), response: response)
            } else {
                stub(condition: isPath(url.path), response: response)
            }
        }
    }

    var bundle: Bundle {
        return Bundle(for: LoadableBundleClass.self)
    }
    
}
