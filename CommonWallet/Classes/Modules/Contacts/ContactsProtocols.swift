protocol ContactsViewProtocol: ControllerBackedProtocol {
    
    func set(viewModel: ContactListViewModelProtocol)
    func didStartSearch()
    func didStopSearch()
}


protocol ContactsPresenterProtocol: class {

    func setup()
    func search(_ pattern: String)
    func dismiss()

}


protocol ContactsCoordinatorProtocol: class {
    
    func send(to payload: AmountPayload)
    func scanInvoice()
    func dismiss()
    
}


protocol ContactsAssemblyProtocol: class {
    
	static func assembleView(with resolver: ResolverProtocol) -> ContactsViewProtocol?
    
}
