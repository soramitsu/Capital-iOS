/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

extension UIColor {
    class var accentColor: UIColor {
        UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }

    class var tretiaryColor: UIColor {
        UIColor(red: 2.0 / 255.0, green: 122.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0)
    }

    class var secondaryColor: UIColor {
        UIColor(red: 0.0, green: 161.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
    }

    class var darkGrey: UIColor {
        UIColor(white: 137.0 / 255.0, alpha: 1.0)
    }

    class var greyText: UIColor {
        UIColor(white: 97.0 / 255.0, alpha: 1.0)
    }

    class var bodyText: UIColor {
        UIColor(white: 0.0, alpha: 1.0)
    }

    class var thickBorder: UIColor {
        UIColor(white: 153.0 / 255.0, alpha: 0.55)
    }

    class var thinBorder: UIColor {
        UIColor(white: 153.0 / 255.0, alpha: 0.25)
    }

    class var background: UIColor {
        UIColor(white: 242.0 / 255.0, alpha: 1.0)
    }

    class var shade: UIColor {
        UIColor(white: 0.0, alpha: 0.04)
    }

    class var headerText: UIColor {
        UIColor(red: 25.0 / 255.0, green: 40.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
    }

    class var border: UIColor {
        UIColor(white: 151.0 / 255.0, alpha: 0.1)
    }
    
    class var search: UIColor {
        UIColor(red: 142 / 255, green: 142 / 255, blue: 147 / 255, alpha: 0.12)
    }

    class var panIndicator: UIColor {
        UIColor(red: 221.0 / 255.0, green: 221.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)
    }

    class var normalLinkColor: UIColor {
        UIColor(red: 2.0 / 255.0, green: 122.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0)
    }

    class var highlightedLinkColor: UIColor {
        normalLinkColor.withAlphaComponent(0.5)
    }
}
