import Foundation

protocol ControllerBackedProtocol: class {
    var controller: UIViewController { get }
}

extension ControllerBackedProtocol where Self: UIViewController {
    var controller: UIViewController {
        return self
    }
}
