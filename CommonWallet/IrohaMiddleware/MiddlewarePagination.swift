/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

private struct PaginationContextKeys {
    static let offset = "paginationOffset"
}

extension PaginationContext {
    var offset: Int? {
        if
            let offsetString = self[PaginationContextKeys.offset],
            let value = Int(offsetString) {
            return value
         } else {
            return nil
        }
    }

    init(offset: Int) {
        self = [PaginationContextKeys.offset: String(offset)]
    }
}

struct MiddlewarePagination: Codable, Equatable {
    let offset: Int
    let count: Int
}

extension MiddlewarePagination {
    init(pagination: Pagination) {
        offset = pagination.context?.offset ?? 0
        count = pagination.count
    }
}
