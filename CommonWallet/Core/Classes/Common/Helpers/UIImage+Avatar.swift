/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


extension UIImage {
    public static func createAvatar(fullName: String,
                                    style: WalletNameIconStyleProtocol) -> UIImage? {
        let nameComponents = fullName.components(separatedBy: .whitespaces)
        let firstName = nameComponents.first ?? ""
        let lastName = nameComponents.last ?? ""

        let firstLetter = String(firstName.prefix(1)).uppercased()
        let secondLetter = String(lastName.prefix(1)).uppercased()

        return createAvatar(symbols: firstLetter + secondLetter,
                            radius: style.radius,
                            fillColor: style.background,
                            textFont: style.title.font,
                            textColor: style.title.color,
                            strokeColor: style.stroke?.color,
                            strokeWidth: style.stroke?.lineWidth ?? 0.0)
    }

    public static func createAvatar(symbols: String,
                                    radius: CGFloat,
                                    fillColor: UIColor,
                                    textFont: UIFont,
                                    textColor: UIColor,
                                    strokeColor: UIColor? = nil,
                                    strokeWidth: CGFloat = 0.0) -> UIImage? {
        let size = CGSize(width: 2.0 * radius, height: 2.0 * radius)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.setFillColor(fillColor.cgColor)

        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                                      radius: radius,
                                      startAngle: 0.0,
                                      endAngle: 2.0 * CGFloat.pi,
                                      clockwise: true)

        bezierPath.fill()

        if let strokeColor = strokeColor, strokeWidth > 0.0 {
            context.setStrokeColor(strokeColor.cgColor)
            context.setLineWidth(strokeWidth)

            let strokePath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                                          radius: radius - strokeWidth / 2.0,
                                          startAngle: 0.0,
                                          endAngle: 2.0 * CGFloat.pi,
                                          clockwise: true)

            strokePath.stroke()
        }

        let attributes: [NSAttributedString.Key: Any] = [.font: textFont, .foregroundColor: textColor]

        let drawingSize = (symbols as NSString).boundingRect(with: size,
                                                             options: .usesLineFragmentOrigin,
                                                             attributes: attributes,
                                                             context: nil).size

        let boundingRect = CGRect(x: size.width / 2.0 - drawingSize.width / 2.0,
                                  y: size.height / 2.0 - drawingSize.height / 2.0,
                                  width: drawingSize.width, height: drawingSize.height)

        (symbols as NSString).draw(in: boundingRect, withAttributes: attributes)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

}
