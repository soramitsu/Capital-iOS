/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


//swiftlint:disable all
public enum L10n {

    static var sharedLanguage: WalletLanguage = WalletLanguage.defaultLanguage

    public enum Account {
        /// Account details
        public static var detailsTitle: String { return localize("account.details_title") }
    }

    public enum Amount {
        /// Transaction fee
        public static var fee: String { return localize("amount.fee") }
        /// Amount to send
        public static var send: String { return localize("amount.send") }
        /// Amount
        public static var title: String { return localize("amount.title") }
        /// Total amount
        public static var total: String { return localize("amount.total") }

        public enum Error {
            /// Sorry, we couldn't find asset information you want to send. Please, try again later.
            public static var asset: String { return localize("amount.error.asset") }
            /// Sorry, balance checking request failed. Please, try again later.
            public static var balance: String { return localize("amount.error.balance") }
            /// Sorry, you don't have enough funds to transfer specified amount.
            public static var noFunds: String { return localize("amount.error.no_funds") }
            /// Sorry, we coudn't contact transfer provider. Please, try again later.
            public static var transfer: String { return localize("amount.error.transfer") }
        }
    }

    public enum AssetSelection {
        /// No asset
        public static var noAsset: String { return localize("asset_selection.no_asset") }
    }

    public enum Common {
        /// My account is:
        public static var accountShare: String { return localize("common.account_share") }
        /// All
        public static var all: String { return localize("common.all") }
        /// Close
        public static var close: String { return localize("common.close") }
        /// Description
        public static var description: String { return localize("common.description") }
        /// Description (optional)
        public static var descriptionOptional: String { return localize("common.description_optional") }
        /// Done
        public static var done: String { return localize("common.done") }
        /// Error
        public static var error: String { return localize("common.error") }
        /// Incoming
        public static var incoming: String { return localize("common.incoming") }
        /// Next
        public static var next: String { return localize("common.next") }
        /// Not now
        public static var notNow: String { return localize("common.not_now") }
        /// OK
        public static var ok: String { return localize("common.ok") }
        /// Open settings
        public static var openSettings: String { return localize("common.open_settings") }
        /// Outgoing
        public static var outgoing: String { return localize("common.outgoing") }
        /// Receive
        public static var receive: String { return localize("common.receive") }
        /// Search
        public static var search: String { return localize("common.search") }
        /// Send
        public static var send: String { return localize("common.send") }
        /// Show less
        public static var showLess: String { return localize("common.show_less") }
        /// Show more
        public static var showMore: String { return localize("common.show_more") }
        /// Today
        public static var today: String { return localize("common.today") }
        /// transfer fee
        public static var transferFee: String { return localize("common.transfer_fee") }
        /// withdrawal fee
        public static var withdrawalFee: String { return localize("common.withdrawal_fee") }
        /// Yesterday
        public static var yesterday: String { return localize("common.yesterday") }

        public enum Input {
            /// %@ lowercase hex symbols starting with 0x
            public static func validatorHint(_ p1: String) -> String {
                return localize("common.input.validator_hint", p1)
            }
            /// Maximum %@ symbols
            public static func validatorMaxHint(_ p1: String) -> String {
                return localize("common.input.validator_max_hint", p1)
            }
        }
    }

    public enum Confirmation {
        /// Please check and confirm details
        public static var hint: String { return localize("confirmation.hint") }
        /// Confirmation
        public static var title: String { return localize("confirmation.title") }
    }

    public enum Contacts {
        /// Scan QR code
        public static var scan: String { return localize("contacts.scan") }
        /// Search results
        public static var searchResults: String { return localize("contacts.search_results") }
        /// Contacts
        public static var title: String { return localize("contacts.title") }
    }

    public enum Filter {
        /// Assets
        public static var assets: String { return localize("filter.assets") }
        /// Date range
        public static var dateRange: String { return localize("filter.dateRange") }
        /// From
        public static var from: String { return localize("filter.from") }
        /// Reset
        public static var reset: String { return localize("filter.reset") }
        /// Set filter
        public static var title: String { return localize("filter.title") }
        /// To
        public static var to: String { return localize("filter.to") }
        /// Type
        public static var type: String { return localize("filter.type") }
    }

    public enum History {
        /// Recent events
        public static var title: String { return localize("history.title") }
    }

    public enum InvoiceScan {
        /// Scan code from receiver
        public static var scan: String { return localize("invoice_scan.scan") }
        /// Upload from gallery
        public static var upload: String { return localize("invoice_scan.upload") }

        public enum Error {
            /// Unfortunatelly, access to the camera is restricted.
            public static var cameraRestricted: String { return localize("invoice_scan.error.camera_restricted") }
            /// Unfortunatelly, you denied access to camera previously. Would you like to allow access now?
            public static var cameraRestrictedPreviously: String { return localize("invoice_scan.error.camera_restricted_previously") }
            /// Camera Access
            public static var cameraTitle: String { return localize("invoice_scan.error.camera_title") }
            /// Can't extract receiver's data
            public static var extractFail: String { return localize("invoice_scan.error.extract_fail") }
            /// Unfortunatelly, access to the photos is restricted.
            public static var galleryRestricted: String { return localize("invoice_scan.error.gallery_restricted") }
            /// Unfortunatelly, you denied access to photos previously. Would you like to allow access now?
            public static var galleryRestrictedPreviously: String { return localize("invoice_scan.error.gallery_restricted_previously") }
            /// Photos Access
            public static var galleryTitle: String { return localize("invoice_scan.error.gallery_title") }
            /// Can't process selected image
            public static var invalidImage: String { return localize("invoice_scan.error.invalid_image") }
            /// Sender and Receiver must be different
            public static var match: String { return localize("invoice_scan.error.match") }
            /// No valid receiver information found
            public static var noInfo: String { return localize("invoice_scan.error.no_info") }
            /// Please, check internet connection
            public static var noInternet: String { return localize("invoice_scan.error.no_internet") }
            /// Receiver couldn't be found
            public static var noReceiver: String { return localize("invoice_scan.error.no_receiver") }
        }
    }

    public enum Receive {
        /// Can't generate QR code
        public static var errorQrGeneration: String { return localize("receive.error_qr_generation") }
        /// Receive assets
        public static var title: String { return localize("receive.title") }
    }

    public enum Status {
        /// Pending
        public static var pending: String { return localize("status.pending") }
        /// Rejected
        public static var rejected: String { return localize("status.rejected") }
        /// Success
        public static var success: String { return localize("status.success") }
        /// Status
        public static var title: String { return localize("status.title") }
    }

    public enum Transaction {
        /// Date and time
        public static var date: String { return localize("transaction.date") }
        /// Transaction details
        public static var details: String { return localize("transaction.details") }
        /// All done
        public static var done: String { return localize("transaction.done") }
        /// Fee
        public static var fee: String { return localize("transaction.fee") }
        /// Identifier
        public static var id: String { return localize("transaction.id") }
        /// Funds are being sent
        public static var pendingDescription: String { return localize("transaction.pending_description") }
        /// Reason
        public static var reason: String { return localize("transaction.reason") }
        /// Recipient
        public static var recipient: String { return localize("transaction.recipient") }
        /// Send back
        public static var sendBack: String { return localize("transaction.send_back") }
        /// Sender
        public static var sender: String { return localize("transaction.sender") }
        /// Amount sent
        public static var sent: String { return localize("transaction.sent") }
        /// Type
        public static var type: String { return localize("transaction.type") }

        public enum Error {
            /// Transaction failed. Please, try again later.
            public static var fail: String { return localize("transaction.error.fail") }
        }
    }

    public enum Withdraw {
        /// Withdraw
        public static var title: String { return localize("withdraw.title") }
        /// Total amount %@%@
        public static func totalAmount(_ p1: String, _ p2: String) -> String {
            return localize("withdraw.total_amount", p1, p2)
        }

        public enum Error {
            /// Sorry, balance checking request failed. Please, try again later.
            public static var balance: String { return localize("withdraw.error.balance") }
            /// Sorry, we couldn't contact withdraw provider. Please, try again later.
            public static var connection: String { return localize("withdraw.error.connection") }
            /// Withdraw failed. Please, try again later.
            public static var fail: String { return localize("withdraw.error.fail") }
            /// Sorry, we couldn't find asset information you want to send. Please, try again later.
            public static var noAsset: String { return localize("withdraw.error.no_asset") }
            /// Sorry, you don't have enough funds to transfer specified amount.
            public static var tooPoor: String { return localize("withdraw.error.too_poor") }
        }
    }
}


extension L10n {

    fileprivate static func localize(_ key: String, _ args: CVarArg...) -> String {
        let format = getFormat(for: key, localization: sharedLanguage.rawValue)
        return String(format: format, arguments: args)
    }

    fileprivate static func getFormat(for key: String, localization: String) -> String {
        let bundle = Bundle(for: BundleLoadHelper.self)

        guard
            let path = bundle.path(forResource: localization, ofType: "lproj"),
            let langBundle = Bundle(path: path) else {
                return ""
        }

        return NSLocalizedString(key, tableName: nil, bundle: langBundle, value: "", comment: "")
    }

}


private final class BundleLoadHelper {}
//swiftlint:enable all