import Foundation

protocol AccessoryViewFactoryProtocol {
    static func createAccessoryView(from style: WalletStyleProtocol,
                                    target: Any?,
                                    completionSelector: Selector?) -> AccessoryViewProtocol
}

final class AccessoryViewFactory: AccessoryViewFactoryProtocol {
    //swiftlint:disable force_cast
    static func createAccessoryView(from style: WalletStyleProtocol, target: Any?,
                                    completionSelector: Selector?) -> AccessoryViewProtocol {
        let bundle = Bundle(for: self)
        let view = UINib(nibName: "AccessoryView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil).first as! AccessoryView

        view.backgroundColor = style.backgroundColor

        view.borderView.strokeColor = style.accessoryStyle.separator.color
        view.borderView.strokeWidth = style.accessoryStyle.separator.lineWidth

        view.titleLabel.textColor = style.accessoryStyle.title.color
        view.titleLabel.font = style.accessoryStyle.title.font

        style.accessoryStyle.action.apply(to: view.actionButton)

        if let target = target, let selector = completionSelector {
            view.actionButton.addTarget(target, action: selector, for: .touchUpInside)
        }

        return view
    }
    //swiftlint:enable force_cast
}
