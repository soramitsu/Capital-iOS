protocol DashboardViewProtocol: ControllerBackedProtocol {}

protocol DashboardPresenterProtocol: class {
    func reload()
}

protocol DashboardCoordinatorProtocol: class {}

protocol DashboardAssemblyProtocol: class {
	static func assembleView(with resolver: ResolverProtocol) -> DashboardViewProtocol?
}
