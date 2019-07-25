import Foundation


public protocol InvoiceScanModuleBuilderProtocol: class {
    @discardableResult
    func with(viewStyle: InvoiceScanViewStyleProtocol) -> Self
}
