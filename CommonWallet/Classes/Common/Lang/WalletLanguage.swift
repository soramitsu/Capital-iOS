/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


private let kDefaultsKeyName = "l10n_lang"


public enum WalletLanguage: String {
    
    case english = "en"
    case khmer = "km"

}


public extension WalletLanguage {
    
    var defaultLanguage: WalletLanguage {
        return .english
    }
    
    func save() {
        UserDefaults.standard.set(self.rawValue, forKey: kDefaultsKeyName)
        UserDefaults.standard.synchronize()
    }

    static func getLanguage() -> WalletLanguage {
        guard
            let langValue = UserDefaults.standard.string(forKey: kDefaultsKeyName),
            let lang = WalletLanguage(rawValue: langValue) else {
            UserDefaults.standard.set(WalletLanguage.english.rawValue, forKey: kDefaultsKeyName)
            UserDefaults.standard.synchronize()
            return .english
        }
        
        return lang
    }
    
    func getFormat(for key: String) -> String {
        let bundle = Bundle(for: BundleLoadHelper.self)

        guard
            let path = bundle.path(forResource: rawValue, ofType: "lproj"),
            let langBundle = Bundle(path: path) else {
                return ""
        }
        let localizedFormat = NSLocalizedString(key, tableName: nil, bundle: langBundle, value: "", comment: "")
        
        guard localizedFormat == key else {
            return localizedFormat
        }
        
        guard
            let defaultPath = bundle.path(forResource: defaultLanguage.rawValue, ofType: "lproj"),
            let defaultBundle = Bundle(path: defaultPath) else {
                return ""
        }
        
        return NSLocalizedString(key, tableName: nil, bundle: defaultBundle, value: "", comment: "")
    }
    
}


private final class BundleLoadHelper {}
