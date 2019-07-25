import Foundation


protocol InvoiceScanConfigurationProtocol {
    var viewStyle: InvoiceScanViewStyleProtocol { get }
}


struct InvoiceScanConfiguration: InvoiceScanConfigurationProtocol {
    var viewStyle: InvoiceScanViewStyleProtocol
}
