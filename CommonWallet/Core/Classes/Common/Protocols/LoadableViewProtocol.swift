/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

protocol LoadableViewProtocol: class {
    var loadableContentView: UIView! { get }
    var shouldDisableInteractionWhenLoading: Bool { get }

    func didStartLoading()
    func didStopLoading()
}

private struct WalletLoadableViewProtocolConstants {
    static let activityIndicatorIdentifier = "ActivityIndicatorIdentifier"
}

private struct WalletLoadableViewKeys {
    static let loadableViewFactory: String = "LoadableViewFactory"
    static let transitionAnimationDuration: String = "TransitionAnimationDuration"
}

extension LoadableViewProtocol where Self: UIViewController {
    var loadingViewFactory: WalletLoadingOverlayFactoryProtocol {
        get {
            let optionalFactory = objc_getAssociatedObject(self, WalletLoadableViewKeys.loadableViewFactory)

            if let factory = optionalFactory as? WalletLoadingOverlayFactoryProtocol {
                return factory
            } else {
                return WalletLoadingOverlayFactory(style: WalletLoadingOverlayStyle.createDefault())
            }
        }

        set {
            objc_setAssociatedObject(self, WalletLoadableViewKeys.loadableViewFactory,
                                     newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var transitionAnimationDuration: TimeInterval {
        set {
            objc_setAssociatedObject(self, WalletLoadableViewKeys.transitionAnimationDuration,
                                     newValue, .OBJC_ASSOCIATION_COPY)
        }

        get {
            let optionalDuration = objc_getAssociatedObject(self, WalletLoadableViewKeys.transitionAnimationDuration)

            if let duration = optionalDuration as? TimeInterval {
                return duration
            } else {
                return 0.25
            }
        }
    }

    var loadableContentView: UIView! {
        return view
    }

    var shouldDisableInteractionWhenLoading: Bool {
        return true
    }

    func didStartLoading() {
        let activityIndicator = loadableContentView.subviews.first {
            $0.accessibilityIdentifier == WalletLoadableViewProtocolConstants.activityIndicatorIdentifier
        }

        guard activityIndicator == nil else {
            return
        }

        let newIndicator = loadingViewFactory.createLoadingView()
        newIndicator.accessibilityIdentifier = WalletLoadableViewProtocolConstants.activityIndicatorIdentifier
        newIndicator.frame = loadableContentView.bounds
        newIndicator.autoresizingMask = UIView.AutoresizingMask.flexibleWidth.union(.flexibleHeight)
        newIndicator.alpha = 0.0
        loadableContentView.addSubview(newIndicator)

        loadableContentView.isUserInteractionEnabled = shouldDisableInteractionWhenLoading

        newIndicator.startAnimating()

        UIView.animate(withDuration: transitionAnimationDuration) {
            newIndicator.alpha = 1.0
        }
    }

    func didStopLoading() {
        let activityIndicator = loadableContentView.subviews.first {
            $0.accessibilityIdentifier == WalletLoadableViewProtocolConstants.activityIndicatorIdentifier
        }

        guard let currentIndicator = activityIndicator as? LoadingView else {
            return
        }

        currentIndicator.accessibilityIdentifier = nil
        loadableContentView.isUserInteractionEnabled = true

        UIView.animate(withDuration: transitionAnimationDuration,
                       animations: {
                        currentIndicator.alpha = 0.0
        }, completion: { _ in
            currentIndicator.stopAnimating()
            currentIndicator.removeFromSuperview()
        })
    }
}
