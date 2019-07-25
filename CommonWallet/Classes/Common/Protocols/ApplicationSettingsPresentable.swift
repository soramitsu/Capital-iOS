import UIKit

protocol ApplicationSettingsPresentable {
    func askOpenApplicationSettins(with message: String, title: String?, from view: ControllerBackedProtocol?)
}

extension ApplicationSettingsPresentable {
    func askOpenApplicationSettins(with message: String, title: String?, from view: ControllerBackedProtocol?) {
        var currentController = view?.controller

        if currentController == nil {
            currentController = UIApplication.shared.delegate?.window??.rootViewController
        }

        guard let controller = currentController else {
            return
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Not Now", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }

        alert.addAction(closeAction)
        alert.addAction(settingsAction)

        controller.present(alert, animated: true, completion: nil)
    }
}
