import Cuckoo
@testable import CommonWallet

import Foundation
import UIKit


 class MockAlertPresentable: AlertPresentable, Cuckoo.ProtocolMock {
    
     typealias MocksType = AlertPresentable
    
     typealias Stubbing = __StubbingProxy_AlertPresentable
     typealias Verification = __VerificationProxy_AlertPresentable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AlertPresentable?

     func enableDefaultImplementation(_ stub: AlertPresentable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)  {
        
    return cuckoo_manager.call("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)",
            parameters: (title, message, actions, completion),
            escapingParameters: (title, message, actions, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showAlert(title: title, message: message, actions: actions, completion: completion))
        
    }
    

	 struct __StubbingProxy_AlertPresentable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAlertPresentable.self, method: "showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AlertPresentable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.__DoNotUse<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return cuckoo_manager.verify("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AlertPresentableStub: AlertPresentable {
    

    

    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockReloadable: Reloadable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Reloadable
    
     typealias Stubbing = __StubbingProxy_Reloadable
     typealias Verification = __VerificationProxy_Reloadable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Reloadable?

     func enableDefaultImplementation(_ stub: Reloadable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var reloadableDelegate: ReloadableDelegate? {
        get {
            return cuckoo_manager.getter("reloadableDelegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.reloadableDelegate)
        }
        
        set {
            cuckoo_manager.setter("reloadableDelegate",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.reloadableDelegate = newValue)
        }
        
    }
    

    

    
    
    
     func reload()  {
        
    return cuckoo_manager.call("reload()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reload())
        
    }
    

	 struct __StubbingProxy_Reloadable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var reloadableDelegate: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockReloadable, ReloadableDelegate> {
	        return .init(manager: cuckoo_manager, name: "reloadableDelegate")
	    }
	    
	    
	    func reload() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockReloadable.self, method: "reload()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Reloadable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var reloadableDelegate: Cuckoo.VerifyOptionalProperty<ReloadableDelegate> {
	        return .init(manager: cuckoo_manager, name: "reloadableDelegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func reload() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reload()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ReloadableStub: Reloadable {
    
    
     var reloadableDelegate: ReloadableDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (ReloadableDelegate?).self)
        }
        
        set { }
        
    }
    

    

    
     func reload()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockReloadableDelegate: ReloadableDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = ReloadableDelegate
    
     typealias Stubbing = __StubbingProxy_ReloadableDelegate
     typealias Verification = __VerificationProxy_ReloadableDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ReloadableDelegate?

     func enableDefaultImplementation(_ stub: ReloadableDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func didInitiateReload(on reloadable: Reloadable)  {
        
    return cuckoo_manager.call("didInitiateReload(on: Reloadable)",
            parameters: (reloadable),
            escapingParameters: (reloadable),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didInitiateReload(on: reloadable))
        
    }
    

	 struct __StubbingProxy_ReloadableDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func didInitiateReload<M1: Cuckoo.Matchable>(on reloadable: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Reloadable)> where M1.MatchedType == Reloadable {
	        let matchers: [Cuckoo.ParameterMatcher<(Reloadable)>] = [wrap(matchable: reloadable) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReloadableDelegate.self, method: "didInitiateReload(on: Reloadable)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ReloadableDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func didInitiateReload<M1: Cuckoo.Matchable>(on reloadable: M1) -> Cuckoo.__DoNotUse<(Reloadable), Void> where M1.MatchedType == Reloadable {
	        let matchers: [Cuckoo.ParameterMatcher<(Reloadable)>] = [wrap(matchable: reloadable) { $0 }]
	        return cuckoo_manager.verify("didInitiateReload(on: Reloadable)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ReloadableDelegateStub: ReloadableDelegate {
    

    

    
     func didInitiateReload(on reloadable: Reloadable)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockContainableObserver: ContainableObserver, Cuckoo.ProtocolMock {
    
     typealias MocksType = ContainableObserver
    
     typealias Stubbing = __StubbingProxy_ContainableObserver
     typealias Verification = __VerificationProxy_ContainableObserver

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ContainableObserver?

     func enableDefaultImplementation(_ stub: ContainableObserver) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func willChangePreferredContentHeight()  {
        
    return cuckoo_manager.call("willChangePreferredContentHeight()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.willChangePreferredContentHeight())
        
    }
    
    
    
     func didChangePreferredContentHeight(to newContentHeight: CGFloat)  {
        
    return cuckoo_manager.call("didChangePreferredContentHeight(to: CGFloat)",
            parameters: (newContentHeight),
            escapingParameters: (newContentHeight),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didChangePreferredContentHeight(to: newContentHeight))
        
    }
    

	 struct __StubbingProxy_ContainableObserver: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func willChangePreferredContentHeight() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockContainableObserver.self, method: "willChangePreferredContentHeight()", parameterMatchers: matchers))
	    }
	    
	    func didChangePreferredContentHeight<M1: Cuckoo.Matchable>(to newContentHeight: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CGFloat)> where M1.MatchedType == CGFloat {
	        let matchers: [Cuckoo.ParameterMatcher<(CGFloat)>] = [wrap(matchable: newContentHeight) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContainableObserver.self, method: "didChangePreferredContentHeight(to: CGFloat)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ContainableObserver: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func willChangePreferredContentHeight() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("willChangePreferredContentHeight()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didChangePreferredContentHeight<M1: Cuckoo.Matchable>(to newContentHeight: M1) -> Cuckoo.__DoNotUse<(CGFloat), Void> where M1.MatchedType == CGFloat {
	        let matchers: [Cuckoo.ParameterMatcher<(CGFloat)>] = [wrap(matchable: newContentHeight) { $0 }]
	        return cuckoo_manager.verify("didChangePreferredContentHeight(to: CGFloat)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ContainableObserverStub: ContainableObserver {
    

    

    
     func willChangePreferredContentHeight()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didChangePreferredContentHeight(to newContentHeight: CGFloat)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockContainable: Containable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Containable
    
     typealias Stubbing = __StubbingProxy_Containable
     typealias Verification = __VerificationProxy_Containable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Containable?

     func enableDefaultImplementation(_ stub: Containable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var contentView: UIView {
        get {
            return cuckoo_manager.getter("contentView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.contentView)
        }
        
    }
    
    
    
     var contentInsets: UIEdgeInsets {
        get {
            return cuckoo_manager.getter("contentInsets",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.contentInsets)
        }
        
    }
    
    
    
     var preferredContentHeight: CGFloat {
        get {
            return cuckoo_manager.getter("preferredContentHeight",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.preferredContentHeight)
        }
        
    }
    
    
    
     var observable: WalletViewModelObserverContainer<ContainableObserver> {
        get {
            return cuckoo_manager.getter("observable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.observable)
        }
        
    }
    

    

    
    
    
     func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool)  {
        
    return cuckoo_manager.call("setContentInsets(_: UIEdgeInsets, animated: Bool)",
            parameters: (contentInsets, animated),
            escapingParameters: (contentInsets, animated),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setContentInsets(contentInsets, animated: animated))
        
    }
    

	 struct __StubbingProxy_Containable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var contentView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockContainable, UIView> {
	        return .init(manager: cuckoo_manager, name: "contentView")
	    }
	    
	    
	    var contentInsets: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockContainable, UIEdgeInsets> {
	        return .init(manager: cuckoo_manager, name: "contentInsets")
	    }
	    
	    
	    var preferredContentHeight: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockContainable, CGFloat> {
	        return .init(manager: cuckoo_manager, name: "preferredContentHeight")
	    }
	    
	    
	    var observable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockContainable, WalletViewModelObserverContainer<ContainableObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable")
	    }
	    
	    
	    func setContentInsets<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ contentInsets: M1, animated: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(UIEdgeInsets, Bool)> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, Bool)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContainable.self, method: "setContentInsets(_: UIEdgeInsets, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Containable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var contentView: Cuckoo.VerifyReadOnlyProperty<UIView> {
	        return .init(manager: cuckoo_manager, name: "contentView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var contentInsets: Cuckoo.VerifyReadOnlyProperty<UIEdgeInsets> {
	        return .init(manager: cuckoo_manager, name: "contentInsets", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var preferredContentHeight: Cuckoo.VerifyReadOnlyProperty<CGFloat> {
	        return .init(manager: cuckoo_manager, name: "preferredContentHeight", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var observable: Cuckoo.VerifyReadOnlyProperty<WalletViewModelObserverContainer<ContainableObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func setContentInsets<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ contentInsets: M1, animated: M2) -> Cuckoo.__DoNotUse<(UIEdgeInsets, Bool), Void> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, Bool)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return cuckoo_manager.verify("setContentInsets(_: UIEdgeInsets, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ContainableStub: Containable {
    
    
     var contentView: UIView {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView).self)
        }
        
    }
    
    
     var contentInsets: UIEdgeInsets {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIEdgeInsets).self)
        }
        
    }
    
    
     var preferredContentHeight: CGFloat {
        get {
            return DefaultValueRegistry.defaultValue(for: (CGFloat).self)
        }
        
    }
    
    
     var observable: WalletViewModelObserverContainer<ContainableObserver> {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletViewModelObserverContainer<ContainableObserver>).self)
        }
        
    }
    

    

    
     func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockDraggableDelegate: DraggableDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = DraggableDelegate
    
     typealias Stubbing = __StubbingProxy_DraggableDelegate
     typealias Verification = __VerificationProxy_DraggableDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DraggableDelegate?

     func enableDefaultImplementation(_ stub: DraggableDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var presentationNavigationItem: UINavigationItem? {
        get {
            return cuckoo_manager.getter("presentationNavigationItem",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.presentationNavigationItem)
        }
        
    }
    

    

    
    
    
     func wantsTransit(to draggableState: DraggableState, animating: Bool)  {
        
    return cuckoo_manager.call("wantsTransit(to: DraggableState, animating: Bool)",
            parameters: (draggableState, animating),
            escapingParameters: (draggableState, animating),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.wantsTransit(to: draggableState, animating: animating))
        
    }
    

	 struct __StubbingProxy_DraggableDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var presentationNavigationItem: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDraggableDelegate, UINavigationItem?> {
	        return .init(manager: cuckoo_manager, name: "presentationNavigationItem")
	    }
	    
	    
	    func wantsTransit<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(to draggableState: M1, animating: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(DraggableState, Bool)> where M1.MatchedType == DraggableState, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState, Bool)>] = [wrap(matchable: draggableState) { $0.0 }, wrap(matchable: animating) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDraggableDelegate.self, method: "wantsTransit(to: DraggableState, animating: Bool)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DraggableDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var presentationNavigationItem: Cuckoo.VerifyReadOnlyProperty<UINavigationItem?> {
	        return .init(manager: cuckoo_manager, name: "presentationNavigationItem", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func wantsTransit<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(to draggableState: M1, animating: M2) -> Cuckoo.__DoNotUse<(DraggableState, Bool), Void> where M1.MatchedType == DraggableState, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState, Bool)>] = [wrap(matchable: draggableState) { $0.0 }, wrap(matchable: animating) { $0.1 }]
	        return cuckoo_manager.verify("wantsTransit(to: DraggableState, animating: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DraggableDelegateStub: DraggableDelegate {
    
    
     var presentationNavigationItem: UINavigationItem? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UINavigationItem?).self)
        }
        
    }
    

    

    
     func wantsTransit(to draggableState: DraggableState, animating: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockDraggable: Draggable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Draggable
    
     typealias Stubbing = __StubbingProxy_Draggable
     typealias Verification = __VerificationProxy_Draggable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Draggable?

     func enableDefaultImplementation(_ stub: Draggable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var draggableView: UIView {
        get {
            return cuckoo_manager.getter("draggableView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.draggableView)
        }
        
    }
    
    
    
     var delegate: DraggableDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    
    
    
     var scrollPanRecognizer: UIPanGestureRecognizer? {
        get {
            return cuckoo_manager.getter("scrollPanRecognizer",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.scrollPanRecognizer)
        }
        
    }
    

    

    
    
    
     func set(dragableState: DraggableState, animated: Bool)  {
        
    return cuckoo_manager.call("set(dragableState: DraggableState, animated: Bool)",
            parameters: (dragableState, animated),
            escapingParameters: (dragableState, animated),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(dragableState: dragableState, animated: animated))
        
    }
    
    
    
     func set(contentInsets: UIEdgeInsets, for state: DraggableState)  {
        
    return cuckoo_manager.call("set(contentInsets: UIEdgeInsets, for: DraggableState)",
            parameters: (contentInsets, state),
            escapingParameters: (contentInsets, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(contentInsets: contentInsets, for: state))
        
    }
    
    
    
     func canDrag(from state: DraggableState) -> Bool {
        
    return cuckoo_manager.call("canDrag(from: DraggableState) -> Bool",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.canDrag(from: state))
        
    }
    
    
    
     func animate(progress: Double, from oldState: DraggableState, to newState: DraggableState, finalFrame: CGRect)  {
        
    return cuckoo_manager.call("animate(progress: Double, from: DraggableState, to: DraggableState, finalFrame: CGRect)",
            parameters: (progress, oldState, newState, finalFrame),
            escapingParameters: (progress, oldState, newState, finalFrame),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.animate(progress: progress, from: oldState, to: newState, finalFrame: finalFrame))
        
    }
    

	 struct __StubbingProxy_Draggable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var draggableView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDraggable, UIView> {
	        return .init(manager: cuckoo_manager, name: "draggableView")
	    }
	    
	    
	    var delegate: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockDraggable, DraggableDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    var scrollPanRecognizer: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDraggable, UIPanGestureRecognizer?> {
	        return .init(manager: cuckoo_manager, name: "scrollPanRecognizer")
	    }
	    
	    
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(dragableState: M1, animated: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(DraggableState, Bool)> where M1.MatchedType == DraggableState, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState, Bool)>] = [wrap(matchable: dragableState) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDraggable.self, method: "set(dragableState: DraggableState, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(contentInsets: M1, for state: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(UIEdgeInsets, DraggableState)> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, DraggableState)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDraggable.self, method: "set(contentInsets: UIEdgeInsets, for: DraggableState)", parameterMatchers: matchers))
	    }
	    
	    func canDrag<M1: Cuckoo.Matchable>(from state: M1) -> Cuckoo.ProtocolStubFunction<(DraggableState), Bool> where M1.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDraggable.self, method: "canDrag(from: DraggableState) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func animate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(progress: M1, from oldState: M2, to newState: M3, finalFrame: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Double, DraggableState, DraggableState, CGRect)> where M1.MatchedType == Double, M2.MatchedType == DraggableState, M3.MatchedType == DraggableState, M4.MatchedType == CGRect {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, DraggableState, DraggableState, CGRect)>] = [wrap(matchable: progress) { $0.0 }, wrap(matchable: oldState) { $0.1 }, wrap(matchable: newState) { $0.2 }, wrap(matchable: finalFrame) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDraggable.self, method: "animate(progress: Double, from: DraggableState, to: DraggableState, finalFrame: CGRect)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Draggable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var draggableView: Cuckoo.VerifyReadOnlyProperty<UIView> {
	        return .init(manager: cuckoo_manager, name: "draggableView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var delegate: Cuckoo.VerifyOptionalProperty<DraggableDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var scrollPanRecognizer: Cuckoo.VerifyReadOnlyProperty<UIPanGestureRecognizer?> {
	        return .init(manager: cuckoo_manager, name: "scrollPanRecognizer", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(dragableState: M1, animated: M2) -> Cuckoo.__DoNotUse<(DraggableState, Bool), Void> where M1.MatchedType == DraggableState, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState, Bool)>] = [wrap(matchable: dragableState) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return cuckoo_manager.verify("set(dragableState: DraggableState, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(contentInsets: M1, for state: M2) -> Cuckoo.__DoNotUse<(UIEdgeInsets, DraggableState), Void> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, DraggableState)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("set(contentInsets: UIEdgeInsets, for: DraggableState)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func canDrag<M1: Cuckoo.Matchable>(from state: M1) -> Cuckoo.__DoNotUse<(DraggableState), Bool> where M1.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("canDrag(from: DraggableState) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func animate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(progress: M1, from oldState: M2, to newState: M3, finalFrame: M4) -> Cuckoo.__DoNotUse<(Double, DraggableState, DraggableState, CGRect), Void> where M1.MatchedType == Double, M2.MatchedType == DraggableState, M3.MatchedType == DraggableState, M4.MatchedType == CGRect {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, DraggableState, DraggableState, CGRect)>] = [wrap(matchable: progress) { $0.0 }, wrap(matchable: oldState) { $0.1 }, wrap(matchable: newState) { $0.2 }, wrap(matchable: finalFrame) { $0.3 }]
	        return cuckoo_manager.verify("animate(progress: Double, from: DraggableState, to: DraggableState, finalFrame: CGRect)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DraggableStub: Draggable {
    
    
     var draggableView: UIView {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView).self)
        }
        
    }
    
    
     var delegate: DraggableDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (DraggableDelegate?).self)
        }
        
        set { }
        
    }
    
    
     var scrollPanRecognizer: UIPanGestureRecognizer? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIPanGestureRecognizer?).self)
        }
        
    }
    

    

    
     func set(dragableState: DraggableState, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(contentInsets: UIEdgeInsets, for state: DraggableState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func canDrag(from state: DraggableState) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func animate(progress: Double, from oldState: DraggableState, to newState: DraggableState, finalFrame: CGRect)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockControllerBackedProtocol: ControllerBackedProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ControllerBackedProtocol
    
     typealias Stubbing = __StubbingProxy_ControllerBackedProtocol
     typealias Verification = __VerificationProxy_ControllerBackedProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ControllerBackedProtocol?

     func enableDefaultImplementation(_ stub: ControllerBackedProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    

    

    

	 struct __StubbingProxy_ControllerBackedProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockControllerBackedProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockControllerBackedProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	}

	 struct __VerificationProxy_ControllerBackedProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class ControllerBackedProtocolStub: ControllerBackedProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockCoordinatorProtocol: CoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_CoordinatorProtocol
     typealias Verification = __VerificationProxy_CoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CoordinatorProtocol?

     func enableDefaultImplementation(_ stub: CoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var resolver: ResolverProtocol {
        get {
            return cuckoo_manager.getter("resolver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.resolver)
        }
        
    }
    

    

    

	 struct __StubbingProxy_CoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var resolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCoordinatorProtocol, ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver")
	    }
	    
	    
	}

	 struct __VerificationProxy_CoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var resolver: Cuckoo.VerifyReadOnlyProperty<ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class CoordinatorProtocolStub: CoordinatorProtocol {
    
    
     var resolver: ResolverProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ResolverProtocol).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockImageGalleryDelegate: ImageGalleryDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = ImageGalleryDelegate
    
     typealias Stubbing = __StubbingProxy_ImageGalleryDelegate
     typealias Verification = __VerificationProxy_ImageGalleryDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ImageGalleryDelegate?

     func enableDefaultImplementation(_ stub: ImageGalleryDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func didCompleteImageSelection(from gallery: ImageGalleryPresentable, with selectedImages: [UIImage])  {
        
    return cuckoo_manager.call("didCompleteImageSelection(from: ImageGalleryPresentable, with: [UIImage])",
            parameters: (gallery, selectedImages),
            escapingParameters: (gallery, selectedImages),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didCompleteImageSelection(from: gallery, with: selectedImages))
        
    }
    
    
    
     func didFail(in gallery: ImageGalleryPresentable, with error: Error)  {
        
    return cuckoo_manager.call("didFail(in: ImageGalleryPresentable, with: Error)",
            parameters: (gallery, error),
            escapingParameters: (gallery, error),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didFail(in: gallery, with: error))
        
    }
    

	 struct __StubbingProxy_ImageGalleryDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func didCompleteImageSelection<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from gallery: M1, with selectedImages: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(ImageGalleryPresentable, [UIImage])> where M1.MatchedType == ImageGalleryPresentable, M2.MatchedType == [UIImage] {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageGalleryPresentable, [UIImage])>] = [wrap(matchable: gallery) { $0.0 }, wrap(matchable: selectedImages) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockImageGalleryDelegate.self, method: "didCompleteImageSelection(from: ImageGalleryPresentable, with: [UIImage])", parameterMatchers: matchers))
	    }
	    
	    func didFail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(in gallery: M1, with error: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(ImageGalleryPresentable, Error)> where M1.MatchedType == ImageGalleryPresentable, M2.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageGalleryPresentable, Error)>] = [wrap(matchable: gallery) { $0.0 }, wrap(matchable: error) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockImageGalleryDelegate.self, method: "didFail(in: ImageGalleryPresentable, with: Error)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ImageGalleryDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func didCompleteImageSelection<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from gallery: M1, with selectedImages: M2) -> Cuckoo.__DoNotUse<(ImageGalleryPresentable, [UIImage]), Void> where M1.MatchedType == ImageGalleryPresentable, M2.MatchedType == [UIImage] {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageGalleryPresentable, [UIImage])>] = [wrap(matchable: gallery) { $0.0 }, wrap(matchable: selectedImages) { $0.1 }]
	        return cuckoo_manager.verify("didCompleteImageSelection(from: ImageGalleryPresentable, with: [UIImage])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didFail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(in gallery: M1, with error: M2) -> Cuckoo.__DoNotUse<(ImageGalleryPresentable, Error), Void> where M1.MatchedType == ImageGalleryPresentable, M2.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageGalleryPresentable, Error)>] = [wrap(matchable: gallery) { $0.0 }, wrap(matchable: error) { $0.1 }]
	        return cuckoo_manager.verify("didFail(in: ImageGalleryPresentable, with: Error)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ImageGalleryDelegateStub: ImageGalleryDelegate {
    

    

    
     func didCompleteImageSelection(from gallery: ImageGalleryPresentable, with selectedImages: [UIImage])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didFail(in gallery: ImageGalleryPresentable, with error: Error)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockImageGalleryPresentable: ImageGalleryPresentable, Cuckoo.ProtocolMock {
    
     typealias MocksType = ImageGalleryPresentable
    
     typealias Stubbing = __StubbingProxy_ImageGalleryPresentable
     typealias Verification = __VerificationProxy_ImageGalleryPresentable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ImageGalleryPresentable?

     func enableDefaultImplementation(_ stub: ImageGalleryPresentable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func presentImageGallery(from view: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)  {
        
    return cuckoo_manager.call("presentImageGallery(from: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)",
            parameters: (view, delegate),
            escapingParameters: (view, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentImageGallery(from: view, delegate: delegate))
        
    }
    

	 struct __StubbingProxy_ImageGalleryPresentable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func presentImageGallery<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(from view: M1, delegate: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(ControllerBackedProtocol?, ImageGalleryDelegate)> where M1.OptionalMatchedType == ControllerBackedProtocol, M2.MatchedType == ImageGalleryDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<(ControllerBackedProtocol?, ImageGalleryDelegate)>] = [wrap(matchable: view) { $0.0 }, wrap(matchable: delegate) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockImageGalleryPresentable.self, method: "presentImageGallery(from: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ImageGalleryPresentable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func presentImageGallery<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(from view: M1, delegate: M2) -> Cuckoo.__DoNotUse<(ControllerBackedProtocol?, ImageGalleryDelegate), Void> where M1.OptionalMatchedType == ControllerBackedProtocol, M2.MatchedType == ImageGalleryDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<(ControllerBackedProtocol?, ImageGalleryDelegate)>] = [wrap(matchable: view) { $0.0 }, wrap(matchable: delegate) { $0.1 }]
	        return cuckoo_manager.verify("presentImageGallery(from: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ImageGalleryPresentableStub: ImageGalleryPresentable {
    

    

    
     func presentImageGallery(from view: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import SoraUI


 class MockLoadableViewProtocol: LoadableViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = LoadableViewProtocol
    
     typealias Stubbing = __StubbingProxy_LoadableViewProtocol
     typealias Verification = __VerificationProxy_LoadableViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LoadableViewProtocol?

     func enableDefaultImplementation(_ stub: LoadableViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var loadableContentView: UIView! {
        get {
            return cuckoo_manager.getter("loadableContentView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.loadableContentView)
        }
        
    }
    
    
    
     var shouldDisableInteractionWhenLoading: Bool {
        get {
            return cuckoo_manager.getter("shouldDisableInteractionWhenLoading",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.shouldDisableInteractionWhenLoading)
        }
        
    }
    

    

    
    
    
     func didStartLoading()  {
        
    return cuckoo_manager.call("didStartLoading()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStartLoading())
        
    }
    
    
    
     func didStopLoading()  {
        
    return cuckoo_manager.call("didStopLoading()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStopLoading())
        
    }
    

	 struct __StubbingProxy_LoadableViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var loadableContentView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockLoadableViewProtocol, UIView?> {
	        return .init(manager: cuckoo_manager, name: "loadableContentView")
	    }
	    
	    
	    var shouldDisableInteractionWhenLoading: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockLoadableViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "shouldDisableInteractionWhenLoading")
	    }
	    
	    
	    func didStartLoading() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoadableViewProtocol.self, method: "didStartLoading()", parameterMatchers: matchers))
	    }
	    
	    func didStopLoading() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoadableViewProtocol.self, method: "didStopLoading()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LoadableViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var loadableContentView: Cuckoo.VerifyReadOnlyProperty<UIView?> {
	        return .init(manager: cuckoo_manager, name: "loadableContentView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var shouldDisableInteractionWhenLoading: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "shouldDisableInteractionWhenLoading", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func didStartLoading() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStartLoading()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStopLoading() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStopLoading()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LoadableViewProtocolStub: LoadableViewProtocol {
    
    
     var loadableContentView: UIView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView?).self)
        }
        
    }
    
    
     var shouldDisableInteractionWhenLoading: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    

    

    
     func didStartLoading()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStopLoading()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockPickerPresentable: PickerPresentable, Cuckoo.ProtocolMock {
    
     typealias MocksType = PickerPresentable
    
     typealias Stubbing = __StubbingProxy_PickerPresentable
     typealias Verification = __VerificationProxy_PickerPresentable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: PickerPresentable?

     func enableDefaultImplementation(_ stub: PickerPresentable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)  {
        
    return cuckoo_manager.call("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)",
            parameters: (titles, initialIndex, delegate),
            escapingParameters: (titles, initialIndex, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentPicker(for: titles, initialIndex: initialIndex, delegate: delegate))
        
    }
    
    
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)  {
        
    return cuckoo_manager.call("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)",
            parameters: (minDate, maxDate, delegate, locale),
            escapingParameters: (minDate, maxDate, delegate, locale),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentDatePicker(for: minDate, maxDate: maxDate, delegate: delegate, locale: locale))
        
    }
    

	 struct __StubbingProxy_PickerPresentable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String], Int, ModalPickerViewDelegate?)> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPickerPresentable.self, method: "presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", parameterMatchers: matchers))
	    }
	    
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPickerPresentable.self, method: "presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_PickerPresentable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.__DoNotUse<([String], Int, ModalPickerViewDelegate?), Void> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return cuckoo_manager.verify("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.__DoNotUse<(Date?, Date?, ModalDatePickerViewDelegate?, Locale), Void> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return cuckoo_manager.verify("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PickerPresentableStub: PickerPresentable {
    

    

    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import UIKit


 class MockSharingPresentable: SharingPresentable, Cuckoo.ProtocolMock {
    
     typealias MocksType = SharingPresentable
    
     typealias Stubbing = __StubbingProxy_SharingPresentable
     typealias Verification = __VerificationProxy_SharingPresentable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: SharingPresentable?

     func enableDefaultImplementation(_ stub: SharingPresentable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func share(sources: [Any], from view: ControllerBackedProtocol?, with completionHandler: SharingCompletionHandler?)  {
        
    return cuckoo_manager.call("share(sources: [Any], from: ControllerBackedProtocol?, with: SharingCompletionHandler?)",
            parameters: (sources, view, completionHandler),
            escapingParameters: (sources, view, completionHandler),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.share(sources: sources, from: view, with: completionHandler))
        
    }
    

	 struct __StubbingProxy_SharingPresentable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func share<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(sources: M1, from view: M2, with completionHandler: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([Any], ControllerBackedProtocol?, SharingCompletionHandler?)> where M1.MatchedType == [Any], M2.OptionalMatchedType == ControllerBackedProtocol, M3.OptionalMatchedType == SharingCompletionHandler {
	        let matchers: [Cuckoo.ParameterMatcher<([Any], ControllerBackedProtocol?, SharingCompletionHandler?)>] = [wrap(matchable: sources) { $0.0 }, wrap(matchable: view) { $0.1 }, wrap(matchable: completionHandler) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSharingPresentable.self, method: "share(sources: [Any], from: ControllerBackedProtocol?, with: SharingCompletionHandler?)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SharingPresentable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func share<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(sources: M1, from view: M2, with completionHandler: M3) -> Cuckoo.__DoNotUse<([Any], ControllerBackedProtocol?, SharingCompletionHandler?), Void> where M1.MatchedType == [Any], M2.OptionalMatchedType == ControllerBackedProtocol, M3.OptionalMatchedType == SharingCompletionHandler {
	        let matchers: [Cuckoo.ParameterMatcher<([Any], ControllerBackedProtocol?, SharingCompletionHandler?)>] = [wrap(matchable: sources) { $0.0 }, wrap(matchable: view) { $0.1 }, wrap(matchable: completionHandler) { $0.2 }]
	        return cuckoo_manager.verify("share(sources: [Any], from: ControllerBackedProtocol?, with: SharingCompletionHandler?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SharingPresentableStub: SharingPresentable {
    

    

    
     func share(sources: [Any], from view: ControllerBackedProtocol?, with completionHandler: SharingCompletionHandler?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockAccountListViewProtocol: AccountListViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AccountListViewProtocol
    
     typealias Stubbing = __StubbingProxy_AccountListViewProtocol
     typealias Verification = __VerificationProxy_AccountListViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AccountListViewProtocol?

     func enableDefaultImplementation(_ stub: AccountListViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    
    
    
     var contentView: UIView {
        get {
            return cuckoo_manager.getter("contentView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.contentView)
        }
        
    }
    
    
    
     var contentInsets: UIEdgeInsets {
        get {
            return cuckoo_manager.getter("contentInsets",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.contentInsets)
        }
        
    }
    
    
    
     var preferredContentHeight: CGFloat {
        get {
            return cuckoo_manager.getter("preferredContentHeight",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.preferredContentHeight)
        }
        
    }
    
    
    
     var observable: WalletViewModelObserverContainer<ContainableObserver> {
        get {
            return cuckoo_manager.getter("observable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.observable)
        }
        
    }
    

    

    
    
    
     func didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>)  {
        
    return cuckoo_manager.call("didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>)",
            parameters: (viewModels, collapsingRange),
            escapingParameters: (viewModels, collapsingRange),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didLoad(viewModels: viewModels, collapsingRange: collapsingRange))
        
    }
    
    
    
     func didCompleteReload()  {
        
    return cuckoo_manager.call("didCompleteReload()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didCompleteReload())
        
    }
    
    
    
     func set(expanded: Bool, animated: Bool)  {
        
    return cuckoo_manager.call("set(expanded: Bool, animated: Bool)",
            parameters: (expanded, animated),
            escapingParameters: (expanded, animated),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(expanded: expanded, animated: animated))
        
    }
    
    
    
     func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool)  {
        
    return cuckoo_manager.call("setContentInsets(_: UIEdgeInsets, animated: Bool)",
            parameters: (contentInsets, animated),
            escapingParameters: (contentInsets, animated),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setContentInsets(contentInsets, animated: animated))
        
    }
    

	 struct __StubbingProxy_AccountListViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAccountListViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAccountListViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    var contentView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAccountListViewProtocol, UIView> {
	        return .init(manager: cuckoo_manager, name: "contentView")
	    }
	    
	    
	    var contentInsets: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAccountListViewProtocol, UIEdgeInsets> {
	        return .init(manager: cuckoo_manager, name: "contentInsets")
	    }
	    
	    
	    var preferredContentHeight: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAccountListViewProtocol, CGFloat> {
	        return .init(manager: cuckoo_manager, name: "preferredContentHeight")
	    }
	    
	    
	    var observable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAccountListViewProtocol, WalletViewModelObserverContainer<ContainableObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable")
	    }
	    
	    
	    func didLoad<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(viewModels: M1, collapsingRange: M2) -> Cuckoo.ProtocolStubNoReturnFunction<([WalletViewModelProtocol], Range<Int>)> where M1.MatchedType == [WalletViewModelProtocol], M2.MatchedType == Range<Int> {
	        let matchers: [Cuckoo.ParameterMatcher<([WalletViewModelProtocol], Range<Int>)>] = [wrap(matchable: viewModels) { $0.0 }, wrap(matchable: collapsingRange) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListViewProtocol.self, method: "didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>)", parameterMatchers: matchers))
	    }
	    
	    func didCompleteReload() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListViewProtocol.self, method: "didCompleteReload()", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(expanded: M1, animated: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Bool, Bool)> where M1.MatchedType == Bool, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Bool, Bool)>] = [wrap(matchable: expanded) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListViewProtocol.self, method: "set(expanded: Bool, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func setContentInsets<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ contentInsets: M1, animated: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(UIEdgeInsets, Bool)> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, Bool)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListViewProtocol.self, method: "setContentInsets(_: UIEdgeInsets, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AccountListViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var contentView: Cuckoo.VerifyReadOnlyProperty<UIView> {
	        return .init(manager: cuckoo_manager, name: "contentView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var contentInsets: Cuckoo.VerifyReadOnlyProperty<UIEdgeInsets> {
	        return .init(manager: cuckoo_manager, name: "contentInsets", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var preferredContentHeight: Cuckoo.VerifyReadOnlyProperty<CGFloat> {
	        return .init(manager: cuckoo_manager, name: "preferredContentHeight", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var observable: Cuckoo.VerifyReadOnlyProperty<WalletViewModelObserverContainer<ContainableObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func didLoad<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(viewModels: M1, collapsingRange: M2) -> Cuckoo.__DoNotUse<([WalletViewModelProtocol], Range<Int>), Void> where M1.MatchedType == [WalletViewModelProtocol], M2.MatchedType == Range<Int> {
	        let matchers: [Cuckoo.ParameterMatcher<([WalletViewModelProtocol], Range<Int>)>] = [wrap(matchable: viewModels) { $0.0 }, wrap(matchable: collapsingRange) { $0.1 }]
	        return cuckoo_manager.verify("didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didCompleteReload() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didCompleteReload()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(expanded: M1, animated: M2) -> Cuckoo.__DoNotUse<(Bool, Bool), Void> where M1.MatchedType == Bool, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Bool, Bool)>] = [wrap(matchable: expanded) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return cuckoo_manager.verify("set(expanded: Bool, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setContentInsets<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ contentInsets: M1, animated: M2) -> Cuckoo.__DoNotUse<(UIEdgeInsets, Bool), Void> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, Bool)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return cuckoo_manager.verify("setContentInsets(_: UIEdgeInsets, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AccountListViewProtocolStub: AccountListViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    
    
     var contentView: UIView {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView).self)
        }
        
    }
    
    
     var contentInsets: UIEdgeInsets {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIEdgeInsets).self)
        }
        
    }
    
    
     var preferredContentHeight: CGFloat {
        get {
            return DefaultValueRegistry.defaultValue(for: (CGFloat).self)
        }
        
    }
    
    
     var observable: WalletViewModelObserverContainer<ContainableObserver> {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletViewModelObserverContainer<ContainableObserver>).self)
        }
        
    }
    

    

    
     func didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didCompleteReload()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(expanded: Bool, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAccountListPresenterProtocol: AccountListPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AccountListPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_AccountListPresenterProtocol
     typealias Verification = __VerificationProxy_AccountListPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AccountListPresenterProtocol?

     func enableDefaultImplementation(_ stub: AccountListPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func reload()  {
        
    return cuckoo_manager.call("reload()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reload())
        
    }
    
    
    
     func viewDidAppear()  {
        
    return cuckoo_manager.call("viewDidAppear()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.viewDidAppear())
        
    }
    

	 struct __StubbingProxy_AccountListPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func reload() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListPresenterProtocol.self, method: "reload()", parameterMatchers: matchers))
	    }
	    
	    func viewDidAppear() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAccountListPresenterProtocol.self, method: "viewDidAppear()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AccountListPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func reload() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reload()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func viewDidAppear() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("viewDidAppear()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AccountListPresenterProtocolStub: AccountListPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func reload()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func viewDidAppear()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAccountListCoordinatorProtocol: AccountListCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AccountListCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_AccountListCoordinatorProtocol
     typealias Verification = __VerificationProxy_AccountListCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AccountListCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: AccountListCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

	 struct __StubbingProxy_AccountListCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	}

	 struct __VerificationProxy_AccountListCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	}
}

 class AccountListCoordinatorProtocolStub: AccountListCoordinatorProtocol {
    

    

    
}


import Cuckoo
@testable import CommonWallet


 class MockAmountViewProtocol: AmountViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AmountViewProtocol
    
     typealias Stubbing = __StubbingProxy_AmountViewProtocol
     typealias Verification = __VerificationProxy_AmountViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AmountViewProtocol?

     func enableDefaultImplementation(_ stub: AmountViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    
    
    
     var loadableContentView: UIView! {
        get {
            return cuckoo_manager.getter("loadableContentView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.loadableContentView)
        }
        
    }
    
    
    
     var shouldDisableInteractionWhenLoading: Bool {
        get {
            return cuckoo_manager.getter("shouldDisableInteractionWhenLoading",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.shouldDisableInteractionWhenLoading)
        }
        
    }
    

    

    
    
    
     func set(title: String)  {
        
    return cuckoo_manager.call("set(title: String)",
            parameters: (title),
            escapingParameters: (title),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(title: title))
        
    }
    
    
    
     func set(assetViewModel: AssetSelectionViewModelProtocol)  {
        
    return cuckoo_manager.call("set(assetViewModel: AssetSelectionViewModelProtocol)",
            parameters: (assetViewModel),
            escapingParameters: (assetViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(assetViewModel: assetViewModel))
        
    }
    
    
    
     func set(amountViewModel: AmountInputViewModelProtocol)  {
        
    return cuckoo_manager.call("set(amountViewModel: AmountInputViewModelProtocol)",
            parameters: (amountViewModel),
            escapingParameters: (amountViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(amountViewModel: amountViewModel))
        
    }
    
    
    
     func set(descriptionViewModel: DescriptionInputViewModelProtocol)  {
        
    return cuckoo_manager.call("set(descriptionViewModel: DescriptionInputViewModelProtocol)",
            parameters: (descriptionViewModel),
            escapingParameters: (descriptionViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(descriptionViewModel: descriptionViewModel))
        
    }
    
    
    
     func set(accessoryViewModel: AccessoryViewModelProtocol)  {
        
    return cuckoo_manager.call("set(accessoryViewModel: AccessoryViewModelProtocol)",
            parameters: (accessoryViewModel),
            escapingParameters: (accessoryViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(accessoryViewModel: accessoryViewModel))
        
    }
    
    
    
     func set(feeViewModel: FeeViewModelProtocol)  {
        
    return cuckoo_manager.call("set(feeViewModel: FeeViewModelProtocol)",
            parameters: (feeViewModel),
            escapingParameters: (feeViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(feeViewModel: feeViewModel))
        
    }
    
    
    
     func didStartLoading()  {
        
    return cuckoo_manager.call("didStartLoading()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStartLoading())
        
    }
    
    
    
     func didStopLoading()  {
        
    return cuckoo_manager.call("didStopLoading()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStopLoading())
        
    }
    
    
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)  {
        
    return cuckoo_manager.call("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)",
            parameters: (title, message, actions, completion),
            escapingParameters: (title, message, actions, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showAlert(title: title, message: message, actions: actions, completion: completion))
        
    }
    

	 struct __StubbingProxy_AmountViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    var loadableContentView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountViewProtocol, UIView?> {
	        return .init(manager: cuckoo_manager, name: "loadableContentView")
	    }
	    
	    
	    var shouldDisableInteractionWhenLoading: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "shouldDisableInteractionWhenLoading")
	    }
	    
	    
	    func set<M1: Cuckoo.Matchable>(title: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: title) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "set(title: String)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(assetViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AssetSelectionViewModelProtocol)> where M1.MatchedType == AssetSelectionViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AssetSelectionViewModelProtocol)>] = [wrap(matchable: assetViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "set(assetViewModel: AssetSelectionViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(amountViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AmountInputViewModelProtocol)> where M1.MatchedType == AmountInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountInputViewModelProtocol)>] = [wrap(matchable: amountViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "set(amountViewModel: AmountInputViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(descriptionViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(DescriptionInputViewModelProtocol)> where M1.MatchedType == DescriptionInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(DescriptionInputViewModelProtocol)>] = [wrap(matchable: descriptionViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "set(descriptionViewModel: DescriptionInputViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(accessoryViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AccessoryViewModelProtocol)> where M1.MatchedType == AccessoryViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AccessoryViewModelProtocol)>] = [wrap(matchable: accessoryViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "set(accessoryViewModel: AccessoryViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(feeViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(FeeViewModelProtocol)> where M1.MatchedType == FeeViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(FeeViewModelProtocol)>] = [wrap(matchable: feeViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "set(feeViewModel: FeeViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func didStartLoading() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "didStartLoading()", parameterMatchers: matchers))
	    }
	    
	    func didStopLoading() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "didStopLoading()", parameterMatchers: matchers))
	    }
	    
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountViewProtocol.self, method: "showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AmountViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var loadableContentView: Cuckoo.VerifyReadOnlyProperty<UIView?> {
	        return .init(manager: cuckoo_manager, name: "loadableContentView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var shouldDisableInteractionWhenLoading: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "shouldDisableInteractionWhenLoading", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(title: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: title) { $0 }]
	        return cuckoo_manager.verify("set(title: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(assetViewModel: M1) -> Cuckoo.__DoNotUse<(AssetSelectionViewModelProtocol), Void> where M1.MatchedType == AssetSelectionViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AssetSelectionViewModelProtocol)>] = [wrap(matchable: assetViewModel) { $0 }]
	        return cuckoo_manager.verify("set(assetViewModel: AssetSelectionViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(amountViewModel: M1) -> Cuckoo.__DoNotUse<(AmountInputViewModelProtocol), Void> where M1.MatchedType == AmountInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountInputViewModelProtocol)>] = [wrap(matchable: amountViewModel) { $0 }]
	        return cuckoo_manager.verify("set(amountViewModel: AmountInputViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(descriptionViewModel: M1) -> Cuckoo.__DoNotUse<(DescriptionInputViewModelProtocol), Void> where M1.MatchedType == DescriptionInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(DescriptionInputViewModelProtocol)>] = [wrap(matchable: descriptionViewModel) { $0 }]
	        return cuckoo_manager.verify("set(descriptionViewModel: DescriptionInputViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(accessoryViewModel: M1) -> Cuckoo.__DoNotUse<(AccessoryViewModelProtocol), Void> where M1.MatchedType == AccessoryViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AccessoryViewModelProtocol)>] = [wrap(matchable: accessoryViewModel) { $0 }]
	        return cuckoo_manager.verify("set(accessoryViewModel: AccessoryViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(feeViewModel: M1) -> Cuckoo.__DoNotUse<(FeeViewModelProtocol), Void> where M1.MatchedType == FeeViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(FeeViewModelProtocol)>] = [wrap(matchable: feeViewModel) { $0 }]
	        return cuckoo_manager.verify("set(feeViewModel: FeeViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStartLoading() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStartLoading()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStopLoading() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStopLoading()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.__DoNotUse<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return cuckoo_manager.verify("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AmountViewProtocolStub: AmountViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    
    
     var loadableContentView: UIView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView?).self)
        }
        
    }
    
    
     var shouldDisableInteractionWhenLoading: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    

    

    
     func set(title: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(assetViewModel: AssetSelectionViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(amountViewModel: AmountInputViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(descriptionViewModel: DescriptionInputViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(accessoryViewModel: AccessoryViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(feeViewModel: FeeViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStartLoading()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStopLoading()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAmountPresenterProtocol: AmountPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AmountPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_AmountPresenterProtocol
     typealias Verification = __VerificationProxy_AmountPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AmountPresenterProtocol?

     func enableDefaultImplementation(_ stub: AmountPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func confirm()  {
        
    return cuckoo_manager.call("confirm()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.confirm())
        
    }
    
    
    
     func presentAssetSelection()  {
        
    return cuckoo_manager.call("presentAssetSelection()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentAssetSelection())
        
    }
    

	 struct __StubbingProxy_AmountPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func confirm() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountPresenterProtocol.self, method: "confirm()", parameterMatchers: matchers))
	    }
	    
	    func presentAssetSelection() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountPresenterProtocol.self, method: "presentAssetSelection()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AmountPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func confirm() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("confirm()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentAssetSelection() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("presentAssetSelection()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AmountPresenterProtocolStub: AmountPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func confirm()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentAssetSelection()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAmountCoordinatorProtocol: AmountCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AmountCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_AmountCoordinatorProtocol
     typealias Verification = __VerificationProxy_AmountCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AmountCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: AmountCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var resolver: ResolverProtocol {
        get {
            return cuckoo_manager.getter("resolver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.resolver)
        }
        
    }
    

    

    
    
    
     func confirm(with payload: TransferPayload)  {
        
    return cuckoo_manager.call("confirm(with: TransferPayload)",
            parameters: (payload),
            escapingParameters: (payload),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.confirm(with: payload))
        
    }
    
    
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)  {
        
    return cuckoo_manager.call("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)",
            parameters: (titles, initialIndex, delegate),
            escapingParameters: (titles, initialIndex, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentPicker(for: titles, initialIndex: initialIndex, delegate: delegate))
        
    }
    
    
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)  {
        
    return cuckoo_manager.call("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)",
            parameters: (minDate, maxDate, delegate, locale),
            escapingParameters: (minDate, maxDate, delegate, locale),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentDatePicker(for: minDate, maxDate: maxDate, delegate: delegate, locale: locale))
        
    }
    

	 struct __StubbingProxy_AmountCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var resolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountCoordinatorProtocol, ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver")
	    }
	    
	    
	    func confirm<M1: Cuckoo.Matchable>(with payload: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TransferPayload)> where M1.MatchedType == TransferPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferPayload)>] = [wrap(matchable: payload) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountCoordinatorProtocol.self, method: "confirm(with: TransferPayload)", parameterMatchers: matchers))
	    }
	    
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String], Int, ModalPickerViewDelegate?)> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountCoordinatorProtocol.self, method: "presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", parameterMatchers: matchers))
	    }
	    
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountCoordinatorProtocol.self, method: "presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AmountCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var resolver: Cuckoo.VerifyReadOnlyProperty<ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func confirm<M1: Cuckoo.Matchable>(with payload: M1) -> Cuckoo.__DoNotUse<(TransferPayload), Void> where M1.MatchedType == TransferPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferPayload)>] = [wrap(matchable: payload) { $0 }]
	        return cuckoo_manager.verify("confirm(with: TransferPayload)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.__DoNotUse<([String], Int, ModalPickerViewDelegate?), Void> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return cuckoo_manager.verify("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.__DoNotUse<(Date?, Date?, ModalDatePickerViewDelegate?, Locale), Void> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return cuckoo_manager.verify("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AmountCoordinatorProtocolStub: AmountCoordinatorProtocol {
    
    
     var resolver: ResolverProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ResolverProtocol).self)
        }
        
    }
    

    

    
     func confirm(with payload: TransferPayload)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockConfirmationPresenterProtocol: ConfirmationPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ConfirmationPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_ConfirmationPresenterProtocol
     typealias Verification = __VerificationProxy_ConfirmationPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ConfirmationPresenterProtocol?

     func enableDefaultImplementation(_ stub: ConfirmationPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func performAction()  {
        
    return cuckoo_manager.call("performAction()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.performAction())
        
    }
    

	 struct __StubbingProxy_ConfirmationPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockConfirmationPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func performAction() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockConfirmationPresenterProtocol.self, method: "performAction()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ConfirmationPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func performAction() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("performAction()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ConfirmationPresenterProtocolStub: ConfirmationPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func performAction()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockConfirmationCoordinatorProtocol: ConfirmationCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ConfirmationCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_ConfirmationCoordinatorProtocol
     typealias Verification = __VerificationProxy_ConfirmationCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ConfirmationCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: ConfirmationCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func showResult(payload: TransferPayload)  {
        
    return cuckoo_manager.call("showResult(payload: TransferPayload)",
            parameters: (payload),
            escapingParameters: (payload),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showResult(payload: payload))
        
    }
    

	 struct __StubbingProxy_ConfirmationCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func showResult<M1: Cuckoo.Matchable>(payload: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TransferPayload)> where M1.MatchedType == TransferPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferPayload)>] = [wrap(matchable: payload) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConfirmationCoordinatorProtocol.self, method: "showResult(payload: TransferPayload)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ConfirmationCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func showResult<M1: Cuckoo.Matchable>(payload: M1) -> Cuckoo.__DoNotUse<(TransferPayload), Void> where M1.MatchedType == TransferPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferPayload)>] = [wrap(matchable: payload) { $0 }]
	        return cuckoo_manager.verify("showResult(payload: TransferPayload)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ConfirmationCoordinatorProtocolStub: ConfirmationCoordinatorProtocol {
    

    

    
     func showResult(payload: TransferPayload)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockContactsViewProtocol: ContactsViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ContactsViewProtocol
    
     typealias Stubbing = __StubbingProxy_ContactsViewProtocol
     typealias Verification = __VerificationProxy_ContactsViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ContactsViewProtocol?

     func enableDefaultImplementation(_ stub: ContactsViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    

    

    
    
    
     func set(listViewModel: ContactListViewModelProtocol)  {
        
    return cuckoo_manager.call("set(listViewModel: ContactListViewModelProtocol)",
            parameters: (listViewModel),
            escapingParameters: (listViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(listViewModel: listViewModel))
        
    }
    
    
    
     func set(barViewModel: WalletBarActionViewModelProtocol)  {
        
    return cuckoo_manager.call("set(barViewModel: WalletBarActionViewModelProtocol)",
            parameters: (barViewModel),
            escapingParameters: (barViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(barViewModel: barViewModel))
        
    }
    
    
    
     func didStartSearch()  {
        
    return cuckoo_manager.call("didStartSearch()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStartSearch())
        
    }
    
    
    
     func didStopSearch()  {
        
    return cuckoo_manager.call("didStopSearch()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStopSearch())
        
    }
    
    
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)  {
        
    return cuckoo_manager.call("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)",
            parameters: (title, message, actions, completion),
            escapingParameters: (title, message, actions, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showAlert(title: title, message: message, actions: actions, completion: completion))
        
    }
    

	 struct __StubbingProxy_ContactsViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockContactsViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockContactsViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    func set<M1: Cuckoo.Matchable>(listViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(ContactListViewModelProtocol)> where M1.MatchedType == ContactListViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ContactListViewModelProtocol)>] = [wrap(matchable: listViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsViewProtocol.self, method: "set(listViewModel: ContactListViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(barViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletBarActionViewModelProtocol)> where M1.MatchedType == WalletBarActionViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletBarActionViewModelProtocol)>] = [wrap(matchable: barViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsViewProtocol.self, method: "set(barViewModel: WalletBarActionViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func didStartSearch() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsViewProtocol.self, method: "didStartSearch()", parameterMatchers: matchers))
	    }
	    
	    func didStopSearch() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsViewProtocol.self, method: "didStopSearch()", parameterMatchers: matchers))
	    }
	    
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsViewProtocol.self, method: "showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ContactsViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(listViewModel: M1) -> Cuckoo.__DoNotUse<(ContactListViewModelProtocol), Void> where M1.MatchedType == ContactListViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ContactListViewModelProtocol)>] = [wrap(matchable: listViewModel) { $0 }]
	        return cuckoo_manager.verify("set(listViewModel: ContactListViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(barViewModel: M1) -> Cuckoo.__DoNotUse<(WalletBarActionViewModelProtocol), Void> where M1.MatchedType == WalletBarActionViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletBarActionViewModelProtocol)>] = [wrap(matchable: barViewModel) { $0 }]
	        return cuckoo_manager.verify("set(barViewModel: WalletBarActionViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStartSearch() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStartSearch()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStopSearch() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStopSearch()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.__DoNotUse<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return cuckoo_manager.verify("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ContactsViewProtocolStub: ContactsViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    

    

    
     func set(listViewModel: ContactListViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(barViewModel: WalletBarActionViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStartSearch()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStopSearch()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockContactsPresenterProtocol: ContactsPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ContactsPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_ContactsPresenterProtocol
     typealias Verification = __VerificationProxy_ContactsPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ContactsPresenterProtocol?

     func enableDefaultImplementation(_ stub: ContactsPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func search(_ pattern: String)  {
        
    return cuckoo_manager.call("search(_: String)",
            parameters: (pattern),
            escapingParameters: (pattern),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.search(pattern))
        
    }
    

	 struct __StubbingProxy_ContactsPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func search<M1: Cuckoo.Matchable>(_ pattern: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: pattern) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsPresenterProtocol.self, method: "search(_: String)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ContactsPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func search<M1: Cuckoo.Matchable>(_ pattern: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: pattern) { $0 }]
	        return cuckoo_manager.verify("search(_: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ContactsPresenterProtocolStub: ContactsPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func search(_ pattern: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockContactsCoordinatorProtocol: ContactsCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ContactsCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_ContactsCoordinatorProtocol
     typealias Verification = __VerificationProxy_ContactsCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ContactsCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: ContactsCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func send(to payload: AmountPayload)  {
        
    return cuckoo_manager.call("send(to: AmountPayload)",
            parameters: (payload),
            escapingParameters: (payload),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.send(to: payload))
        
    }
    
    
    
     func scanInvoice()  {
        
    return cuckoo_manager.call("scanInvoice()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.scanInvoice())
        
    }
    

	 struct __StubbingProxy_ContactsCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func send<M1: Cuckoo.Matchable>(to payload: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AmountPayload)> where M1.MatchedType == AmountPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountPayload)>] = [wrap(matchable: payload) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsCoordinatorProtocol.self, method: "send(to: AmountPayload)", parameterMatchers: matchers))
	    }
	    
	    func scanInvoice() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockContactsCoordinatorProtocol.self, method: "scanInvoice()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ContactsCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func send<M1: Cuckoo.Matchable>(to payload: M1) -> Cuckoo.__DoNotUse<(AmountPayload), Void> where M1.MatchedType == AmountPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountPayload)>] = [wrap(matchable: payload) { $0 }]
	        return cuckoo_manager.verify("send(to: AmountPayload)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func scanInvoice() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("scanInvoice()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ContactsCoordinatorProtocolStub: ContactsCoordinatorProtocol {
    

    

    
     func send(to payload: AmountPayload)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func scanInvoice()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockDashboardViewProtocol: DashboardViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = DashboardViewProtocol
    
     typealias Stubbing = __StubbingProxy_DashboardViewProtocol
     typealias Verification = __VerificationProxy_DashboardViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DashboardViewProtocol?

     func enableDefaultImplementation(_ stub: DashboardViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    

    

    

	 struct __StubbingProxy_DashboardViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDashboardViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDashboardViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	}

	 struct __VerificationProxy_DashboardViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class DashboardViewProtocolStub: DashboardViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    

    

    
}



 class MockDashboardPresenterProtocol: DashboardPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = DashboardPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_DashboardPresenterProtocol
     typealias Verification = __VerificationProxy_DashboardPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DashboardPresenterProtocol?

     func enableDefaultImplementation(_ stub: DashboardPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func reload()  {
        
    return cuckoo_manager.call("reload()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reload())
        
    }
    

	 struct __StubbingProxy_DashboardPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func reload() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDashboardPresenterProtocol.self, method: "reload()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DashboardPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func reload() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reload()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DashboardPresenterProtocolStub: DashboardPresenterProtocol {
    

    

    
     func reload()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockDashboardCoordinatorProtocol: DashboardCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = DashboardCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_DashboardCoordinatorProtocol
     typealias Verification = __VerificationProxy_DashboardCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DashboardCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: DashboardCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

	 struct __StubbingProxy_DashboardCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	}

	 struct __VerificationProxy_DashboardCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	}
}

 class DashboardCoordinatorProtocolStub: DashboardCoordinatorProtocol {
    

    

    
}


import Cuckoo
@testable import CommonWallet


 class MockFilterable: Filterable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Filterable
    
     typealias Stubbing = __StubbingProxy_Filterable
     typealias Verification = __VerificationProxy_Filterable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Filterable?

     func enableDefaultImplementation(_ stub: Filterable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func set(filter: WalletHistoryRequest)  {
        
    return cuckoo_manager.call("set(filter: WalletHistoryRequest)",
            parameters: (filter),
            escapingParameters: (filter),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(filter: filter))
        
    }
    

	 struct __StubbingProxy_Filterable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func set<M1: Cuckoo.Matchable>(filter: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletHistoryRequest)> where M1.MatchedType == WalletHistoryRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHistoryRequest)>] = [wrap(matchable: filter) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterable.self, method: "set(filter: WalletHistoryRequest)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Filterable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(filter: M1) -> Cuckoo.__DoNotUse<(WalletHistoryRequest), Void> where M1.MatchedType == WalletHistoryRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHistoryRequest)>] = [wrap(matchable: filter) { $0 }]
	        return cuckoo_manager.verify("set(filter: WalletHistoryRequest)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FilterableStub: Filterable {
    

    

    
     func set(filter: WalletHistoryRequest)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockFilterViewProtocol: FilterViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = FilterViewProtocol
    
     typealias Stubbing = __StubbingProxy_FilterViewProtocol
     typealias Verification = __VerificationProxy_FilterViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FilterViewProtocol?

     func enableDefaultImplementation(_ stub: FilterViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    

    

    
    
    
     func set(filter: FilterViewModel)  {
        
    return cuckoo_manager.call("set(filter: FilterViewModel)",
            parameters: (filter),
            escapingParameters: (filter),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(filter: filter))
        
    }
    

	 struct __StubbingProxy_FilterViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFilterViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFilterViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    func set<M1: Cuckoo.Matchable>(filter: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(FilterViewModel)> where M1.MatchedType == FilterViewModel {
	        let matchers: [Cuckoo.ParameterMatcher<(FilterViewModel)>] = [wrap(matchable: filter) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterViewProtocol.self, method: "set(filter: FilterViewModel)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FilterViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(filter: M1) -> Cuckoo.__DoNotUse<(FilterViewModel), Void> where M1.MatchedType == FilterViewModel {
	        let matchers: [Cuckoo.ParameterMatcher<(FilterViewModel)>] = [wrap(matchable: filter) { $0 }]
	        return cuckoo_manager.verify("set(filter: FilterViewModel)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FilterViewProtocolStub: FilterViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    

    

    
     func set(filter: FilterViewModel)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockFilterPresenterProtocol: FilterPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = FilterPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_FilterPresenterProtocol
     typealias Verification = __VerificationProxy_FilterPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FilterPresenterProtocol?

     func enableDefaultImplementation(_ stub: FilterPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func reset()  {
        
    return cuckoo_manager.call("reset()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reset())
        
    }
    
    
    
     func apply()  {
        
    return cuckoo_manager.call("apply()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.apply())
        
    }
    

	 struct __StubbingProxy_FilterPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func reset() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterPresenterProtocol.self, method: "reset()", parameterMatchers: matchers))
	    }
	    
	    func apply() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterPresenterProtocol.self, method: "apply()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FilterPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func reset() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reset()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func apply() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("apply()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FilterPresenterProtocolStub: FilterPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func reset()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func apply()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockFilterCoordinatorProtocol: FilterCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = FilterCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_FilterCoordinatorProtocol
     typealias Verification = __VerificationProxy_FilterCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FilterCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: FilterCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var resolver: ResolverProtocol {
        get {
            return cuckoo_manager.getter("resolver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.resolver)
        }
        
    }
    

    

    
    
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)  {
        
    return cuckoo_manager.call("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)",
            parameters: (titles, initialIndex, delegate),
            escapingParameters: (titles, initialIndex, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentPicker(for: titles, initialIndex: initialIndex, delegate: delegate))
        
    }
    
    
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)  {
        
    return cuckoo_manager.call("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)",
            parameters: (minDate, maxDate, delegate, locale),
            escapingParameters: (minDate, maxDate, delegate, locale),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentDatePicker(for: minDate, maxDate: maxDate, delegate: delegate, locale: locale))
        
    }
    

	 struct __StubbingProxy_FilterCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var resolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFilterCoordinatorProtocol, ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver")
	    }
	    
	    
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String], Int, ModalPickerViewDelegate?)> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterCoordinatorProtocol.self, method: "presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", parameterMatchers: matchers))
	    }
	    
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFilterCoordinatorProtocol.self, method: "presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FilterCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var resolver: Cuckoo.VerifyReadOnlyProperty<ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.__DoNotUse<([String], Int, ModalPickerViewDelegate?), Void> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return cuckoo_manager.verify("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.__DoNotUse<(Date?, Date?, ModalDatePickerViewDelegate?, Locale), Void> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return cuckoo_manager.verify("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FilterCoordinatorProtocolStub: FilterCoordinatorProtocol {
    
    
     var resolver: ResolverProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ResolverProtocol).self)
        }
        
    }
    

    

    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import RobinHood


 class MockHistoryViewProtocol: HistoryViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = HistoryViewProtocol
    
     typealias Stubbing = __StubbingProxy_HistoryViewProtocol
     typealias Verification = __VerificationProxy_HistoryViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HistoryViewProtocol?

     func enableDefaultImplementation(_ stub: HistoryViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    
    
    
     var draggableView: UIView {
        get {
            return cuckoo_manager.getter("draggableView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.draggableView)
        }
        
    }
    
    
    
     var delegate: DraggableDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    
    
    
     var scrollPanRecognizer: UIPanGestureRecognizer? {
        get {
            return cuckoo_manager.getter("scrollPanRecognizer",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.scrollPanRecognizer)
        }
        
    }
    

    

    
    
    
     func reloadContent()  {
        
    return cuckoo_manager.call("reloadContent()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reloadContent())
        
    }
    
    
    
     func handle(changes: [HistoryViewModelChange])  {
        
    return cuckoo_manager.call("handle(changes: [HistoryViewModelChange])",
            parameters: (changes),
            escapingParameters: (changes),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.handle(changes: changes))
        
    }
    
    
    
     func set(dragableState: DraggableState, animated: Bool)  {
        
    return cuckoo_manager.call("set(dragableState: DraggableState, animated: Bool)",
            parameters: (dragableState, animated),
            escapingParameters: (dragableState, animated),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(dragableState: dragableState, animated: animated))
        
    }
    
    
    
     func set(contentInsets: UIEdgeInsets, for state: DraggableState)  {
        
    return cuckoo_manager.call("set(contentInsets: UIEdgeInsets, for: DraggableState)",
            parameters: (contentInsets, state),
            escapingParameters: (contentInsets, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.set(contentInsets: contentInsets, for: state))
        
    }
    
    
    
     func canDrag(from state: DraggableState) -> Bool {
        
    return cuckoo_manager.call("canDrag(from: DraggableState) -> Bool",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.canDrag(from: state))
        
    }
    
    
    
     func animate(progress: Double, from oldState: DraggableState, to newState: DraggableState, finalFrame: CGRect)  {
        
    return cuckoo_manager.call("animate(progress: Double, from: DraggableState, to: DraggableState, finalFrame: CGRect)",
            parameters: (progress, oldState, newState, finalFrame),
            escapingParameters: (progress, oldState, newState, finalFrame),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.animate(progress: progress, from: oldState, to: newState, finalFrame: finalFrame))
        
    }
    

	 struct __StubbingProxy_HistoryViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHistoryViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHistoryViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    var draggableView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHistoryViewProtocol, UIView> {
	        return .init(manager: cuckoo_manager, name: "draggableView")
	    }
	    
	    
	    var delegate: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockHistoryViewProtocol, DraggableDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    var scrollPanRecognizer: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHistoryViewProtocol, UIPanGestureRecognizer?> {
	        return .init(manager: cuckoo_manager, name: "scrollPanRecognizer")
	    }
	    
	    
	    func reloadContent() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryViewProtocol.self, method: "reloadContent()", parameterMatchers: matchers))
	    }
	    
	    func handle<M1: Cuckoo.Matchable>(changes: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([HistoryViewModelChange])> where M1.MatchedType == [HistoryViewModelChange] {
	        let matchers: [Cuckoo.ParameterMatcher<([HistoryViewModelChange])>] = [wrap(matchable: changes) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryViewProtocol.self, method: "handle(changes: [HistoryViewModelChange])", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(dragableState: M1, animated: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(DraggableState, Bool)> where M1.MatchedType == DraggableState, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState, Bool)>] = [wrap(matchable: dragableState) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryViewProtocol.self, method: "set(dragableState: DraggableState, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(contentInsets: M1, for state: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(UIEdgeInsets, DraggableState)> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, DraggableState)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryViewProtocol.self, method: "set(contentInsets: UIEdgeInsets, for: DraggableState)", parameterMatchers: matchers))
	    }
	    
	    func canDrag<M1: Cuckoo.Matchable>(from state: M1) -> Cuckoo.ProtocolStubFunction<(DraggableState), Bool> where M1.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryViewProtocol.self, method: "canDrag(from: DraggableState) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func animate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(progress: M1, from oldState: M2, to newState: M3, finalFrame: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Double, DraggableState, DraggableState, CGRect)> where M1.MatchedType == Double, M2.MatchedType == DraggableState, M3.MatchedType == DraggableState, M4.MatchedType == CGRect {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, DraggableState, DraggableState, CGRect)>] = [wrap(matchable: progress) { $0.0 }, wrap(matchable: oldState) { $0.1 }, wrap(matchable: newState) { $0.2 }, wrap(matchable: finalFrame) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryViewProtocol.self, method: "animate(progress: Double, from: DraggableState, to: DraggableState, finalFrame: CGRect)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HistoryViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var draggableView: Cuckoo.VerifyReadOnlyProperty<UIView> {
	        return .init(manager: cuckoo_manager, name: "draggableView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var delegate: Cuckoo.VerifyOptionalProperty<DraggableDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var scrollPanRecognizer: Cuckoo.VerifyReadOnlyProperty<UIPanGestureRecognizer?> {
	        return .init(manager: cuckoo_manager, name: "scrollPanRecognizer", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func reloadContent() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reloadContent()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handle<M1: Cuckoo.Matchable>(changes: M1) -> Cuckoo.__DoNotUse<([HistoryViewModelChange]), Void> where M1.MatchedType == [HistoryViewModelChange] {
	        let matchers: [Cuckoo.ParameterMatcher<([HistoryViewModelChange])>] = [wrap(matchable: changes) { $0 }]
	        return cuckoo_manager.verify("handle(changes: [HistoryViewModelChange])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(dragableState: M1, animated: M2) -> Cuckoo.__DoNotUse<(DraggableState, Bool), Void> where M1.MatchedType == DraggableState, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState, Bool)>] = [wrap(matchable: dragableState) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return cuckoo_manager.verify("set(dragableState: DraggableState, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(contentInsets: M1, for state: M2) -> Cuckoo.__DoNotUse<(UIEdgeInsets, DraggableState), Void> where M1.MatchedType == UIEdgeInsets, M2.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(UIEdgeInsets, DraggableState)>] = [wrap(matchable: contentInsets) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("set(contentInsets: UIEdgeInsets, for: DraggableState)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func canDrag<M1: Cuckoo.Matchable>(from state: M1) -> Cuckoo.__DoNotUse<(DraggableState), Bool> where M1.MatchedType == DraggableState {
	        let matchers: [Cuckoo.ParameterMatcher<(DraggableState)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("canDrag(from: DraggableState) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func animate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(progress: M1, from oldState: M2, to newState: M3, finalFrame: M4) -> Cuckoo.__DoNotUse<(Double, DraggableState, DraggableState, CGRect), Void> where M1.MatchedType == Double, M2.MatchedType == DraggableState, M3.MatchedType == DraggableState, M4.MatchedType == CGRect {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, DraggableState, DraggableState, CGRect)>] = [wrap(matchable: progress) { $0.0 }, wrap(matchable: oldState) { $0.1 }, wrap(matchable: newState) { $0.2 }, wrap(matchable: finalFrame) { $0.3 }]
	        return cuckoo_manager.verify("animate(progress: Double, from: DraggableState, to: DraggableState, finalFrame: CGRect)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HistoryViewProtocolStub: HistoryViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    
    
     var draggableView: UIView {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView).self)
        }
        
    }
    
    
     var delegate: DraggableDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (DraggableDelegate?).self)
        }
        
        set { }
        
    }
    
    
     var scrollPanRecognizer: UIPanGestureRecognizer? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIPanGestureRecognizer?).self)
        }
        
    }
    

    

    
     func reloadContent()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func handle(changes: [HistoryViewModelChange])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(dragableState: DraggableState, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func set(contentInsets: UIEdgeInsets, for state: DraggableState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func canDrag(from state: DraggableState) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func animate(progress: Double, from oldState: DraggableState, to newState: DraggableState, finalFrame: CGRect)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockHistoryPresenterProtocol: HistoryPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = HistoryPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_HistoryPresenterProtocol
     typealias Verification = __VerificationProxy_HistoryPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HistoryPresenterProtocol?

     func enableDefaultImplementation(_ stub: HistoryPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func reload()  {
        
    return cuckoo_manager.call("reload()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reload())
        
    }
    
    
    
     func loadNext() -> Bool {
        
    return cuckoo_manager.call("loadNext() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadNext())
        
    }
    
    
    
     func reloadCache()  {
        
    return cuckoo_manager.call("reloadCache()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reloadCache())
        
    }
    
    
    
     func showFilter()  {
        
    return cuckoo_manager.call("showFilter()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showFilter())
        
    }
    
    
    
     func numberOfSections() -> Int {
        
    return cuckoo_manager.call("numberOfSections() -> Int",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.numberOfSections())
        
    }
    
    
    
     func sectionModel(at index: Int) -> TransactionSectionViewModelProtocol {
        
    return cuckoo_manager.call("sectionModel(at: Int) -> TransactionSectionViewModelProtocol",
            parameters: (index),
            escapingParameters: (index),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.sectionModel(at: index))
        
    }
    
    
    
     func showTransaction(at index: Int, in section: Int)  {
        
    return cuckoo_manager.call("showTransaction(at: Int, in: Int)",
            parameters: (index, section),
            escapingParameters: (index, section),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showTransaction(at: index, in: section))
        
    }
    

	 struct __StubbingProxy_HistoryPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func reload() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "reload()", parameterMatchers: matchers))
	    }
	    
	    func loadNext() -> Cuckoo.ProtocolStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "loadNext() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func reloadCache() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "reloadCache()", parameterMatchers: matchers))
	    }
	    
	    func showFilter() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "showFilter()", parameterMatchers: matchers))
	    }
	    
	    func numberOfSections() -> Cuckoo.ProtocolStubFunction<(), Int> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "numberOfSections() -> Int", parameterMatchers: matchers))
	    }
	    
	    func sectionModel<M1: Cuckoo.Matchable>(at index: M1) -> Cuckoo.ProtocolStubFunction<(Int), TransactionSectionViewModelProtocol> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: index) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "sectionModel(at: Int) -> TransactionSectionViewModelProtocol", parameterMatchers: matchers))
	    }
	    
	    func showTransaction<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(at index: M1, in section: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, Int)> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: index) { $0.0 }, wrap(matchable: section) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryPresenterProtocol.self, method: "showTransaction(at: Int, in: Int)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HistoryPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func reload() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reload()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func loadNext() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("loadNext() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func reloadCache() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("reloadCache()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showFilter() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("showFilter()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func numberOfSections() -> Cuckoo.__DoNotUse<(), Int> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("numberOfSections() -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func sectionModel<M1: Cuckoo.Matchable>(at index: M1) -> Cuckoo.__DoNotUse<(Int), TransactionSectionViewModelProtocol> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: index) { $0 }]
	        return cuckoo_manager.verify("sectionModel(at: Int) -> TransactionSectionViewModelProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showTransaction<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(at index: M1, in section: M2) -> Cuckoo.__DoNotUse<(Int, Int), Void> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: index) { $0.0 }, wrap(matchable: section) { $0.1 }]
	        return cuckoo_manager.verify("showTransaction(at: Int, in: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HistoryPresenterProtocolStub: HistoryPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func reload()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func loadNext() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func reloadCache()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func showFilter()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func numberOfSections() -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
     func sectionModel(at index: Int) -> TransactionSectionViewModelProtocol  {
        return DefaultValueRegistry.defaultValue(for: (TransactionSectionViewModelProtocol).self)
    }
    
     func showTransaction(at index: Int, in section: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockHistoryCoordinatorProtocol: HistoryCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = HistoryCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_HistoryCoordinatorProtocol
     typealias Verification = __VerificationProxy_HistoryCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HistoryCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: HistoryCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func presentDetails(for transaction: AssetTransactionData)  {
        
    return cuckoo_manager.call("presentDetails(for: AssetTransactionData)",
            parameters: (transaction),
            escapingParameters: (transaction),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentDetails(for: transaction))
        
    }
    
    
    
     func presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset])  {
        
    return cuckoo_manager.call("presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset])",
            parameters: (filter, assets),
            escapingParameters: (filter, assets),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentFilter(filter: filter, assets: assets))
        
    }
    

	 struct __StubbingProxy_HistoryCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func presentDetails<M1: Cuckoo.Matchable>(for transaction: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AssetTransactionData)> where M1.MatchedType == AssetTransactionData {
	        let matchers: [Cuckoo.ParameterMatcher<(AssetTransactionData)>] = [wrap(matchable: transaction) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryCoordinatorProtocol.self, method: "presentDetails(for: AssetTransactionData)", parameterMatchers: matchers))
	    }
	    
	    func presentFilter<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(filter: M1, assets: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletHistoryRequest?, [WalletAsset])> where M1.OptionalMatchedType == WalletHistoryRequest, M2.MatchedType == [WalletAsset] {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHistoryRequest?, [WalletAsset])>] = [wrap(matchable: filter) { $0.0 }, wrap(matchable: assets) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryCoordinatorProtocol.self, method: "presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset])", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HistoryCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func presentDetails<M1: Cuckoo.Matchable>(for transaction: M1) -> Cuckoo.__DoNotUse<(AssetTransactionData), Void> where M1.MatchedType == AssetTransactionData {
	        let matchers: [Cuckoo.ParameterMatcher<(AssetTransactionData)>] = [wrap(matchable: transaction) { $0 }]
	        return cuckoo_manager.verify("presentDetails(for: AssetTransactionData)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentFilter<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(filter: M1, assets: M2) -> Cuckoo.__DoNotUse<(WalletHistoryRequest?, [WalletAsset]), Void> where M1.OptionalMatchedType == WalletHistoryRequest, M2.MatchedType == [WalletAsset] {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHistoryRequest?, [WalletAsset])>] = [wrap(matchable: filter) { $0.0 }, wrap(matchable: assets) { $0.1 }]
	        return cuckoo_manager.verify("presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HistoryCoordinatorProtocolStub: HistoryCoordinatorProtocol {
    

    

    
     func presentDetails(for transaction: AssetTransactionData)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockHistoryCoordinatorDelegate: HistoryCoordinatorDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = HistoryCoordinatorDelegate
    
     typealias Stubbing = __StubbingProxy_HistoryCoordinatorDelegate
     typealias Verification = __VerificationProxy_HistoryCoordinatorDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HistoryCoordinatorDelegate?

     func enableDefaultImplementation(_ stub: HistoryCoordinatorDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func coordinator(_ coordinator: HistoryCoordinatorProtocol, didReceive filter: WalletHistoryRequest)  {
        
    return cuckoo_manager.call("coordinator(_: HistoryCoordinatorProtocol, didReceive: WalletHistoryRequest)",
            parameters: (coordinator, filter),
            escapingParameters: (coordinator, filter),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.coordinator(coordinator, didReceive: filter))
        
    }
    

	 struct __StubbingProxy_HistoryCoordinatorDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func coordinator<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ coordinator: M1, didReceive filter: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(HistoryCoordinatorProtocol, WalletHistoryRequest)> where M1.MatchedType == HistoryCoordinatorProtocol, M2.MatchedType == WalletHistoryRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(HistoryCoordinatorProtocol, WalletHistoryRequest)>] = [wrap(matchable: coordinator) { $0.0 }, wrap(matchable: filter) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHistoryCoordinatorDelegate.self, method: "coordinator(_: HistoryCoordinatorProtocol, didReceive: WalletHistoryRequest)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HistoryCoordinatorDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func coordinator<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ coordinator: M1, didReceive filter: M2) -> Cuckoo.__DoNotUse<(HistoryCoordinatorProtocol, WalletHistoryRequest), Void> where M1.MatchedType == HistoryCoordinatorProtocol, M2.MatchedType == WalletHistoryRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(HistoryCoordinatorProtocol, WalletHistoryRequest)>] = [wrap(matchable: coordinator) { $0.0 }, wrap(matchable: filter) { $0.1 }]
	        return cuckoo_manager.verify("coordinator(_: HistoryCoordinatorProtocol, didReceive: WalletHistoryRequest)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HistoryCoordinatorDelegateStub: HistoryCoordinatorDelegate {
    

    

    
     func coordinator(_ coordinator: HistoryCoordinatorProtocol, didReceive filter: WalletHistoryRequest)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import AVFoundation


 class MockInvoiceScanViewProtocol: InvoiceScanViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = InvoiceScanViewProtocol
    
     typealias Stubbing = __StubbingProxy_InvoiceScanViewProtocol
     typealias Verification = __VerificationProxy_InvoiceScanViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: InvoiceScanViewProtocol?

     func enableDefaultImplementation(_ stub: InvoiceScanViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    

    

    
    
    
     func didReceive(session: AVCaptureSession)  {
        
    return cuckoo_manager.call("didReceive(session: AVCaptureSession)",
            parameters: (session),
            escapingParameters: (session),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(session: session))
        
    }
    
    
    
     func present(message: String, animated: Bool)  {
        
    return cuckoo_manager.call("present(message: String, animated: Bool)",
            parameters: (message, animated),
            escapingParameters: (message, animated),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.present(message: message, animated: animated))
        
    }
    

	 struct __StubbingProxy_InvoiceScanViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockInvoiceScanViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockInvoiceScanViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    func didReceive<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AVCaptureSession)> where M1.MatchedType == AVCaptureSession {
	        let matchers: [Cuckoo.ParameterMatcher<(AVCaptureSession)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanViewProtocol.self, method: "didReceive(session: AVCaptureSession)", parameterMatchers: matchers))
	    }
	    
	    func present<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(message: M1, animated: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, Bool)> where M1.MatchedType == String, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Bool)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanViewProtocol.self, method: "present(message: String, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_InvoiceScanViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<(AVCaptureSession), Void> where M1.MatchedType == AVCaptureSession {
	        let matchers: [Cuckoo.ParameterMatcher<(AVCaptureSession)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("didReceive(session: AVCaptureSession)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func present<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(message: M1, animated: M2) -> Cuckoo.__DoNotUse<(String, Bool), Void> where M1.MatchedType == String, M2.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Bool)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: animated) { $0.1 }]
	        return cuckoo_manager.verify("present(message: String, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class InvoiceScanViewProtocolStub: InvoiceScanViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    

    

    
     func didReceive(session: AVCaptureSession)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func present(message: String, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockInvoiceScanPresenterProtocol: InvoiceScanPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = InvoiceScanPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_InvoiceScanPresenterProtocol
     typealias Verification = __VerificationProxy_InvoiceScanPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: InvoiceScanPresenterProtocol?

     func enableDefaultImplementation(_ stub: InvoiceScanPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func prepareAppearance()  {
        
    return cuckoo_manager.call("prepareAppearance()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareAppearance())
        
    }
    
    
    
     func handleAppearance()  {
        
    return cuckoo_manager.call("handleAppearance()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.handleAppearance())
        
    }
    
    
    
     func prepareDismiss()  {
        
    return cuckoo_manager.call("prepareDismiss()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareDismiss())
        
    }
    
    
    
     func handleDismiss()  {
        
    return cuckoo_manager.call("handleDismiss()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.handleDismiss())
        
    }
    
    
    
     func activateImport()  {
        
    return cuckoo_manager.call("activateImport()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.activateImport())
        
    }
    

	 struct __StubbingProxy_InvoiceScanPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func prepareAppearance() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanPresenterProtocol.self, method: "prepareAppearance()", parameterMatchers: matchers))
	    }
	    
	    func handleAppearance() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanPresenterProtocol.self, method: "handleAppearance()", parameterMatchers: matchers))
	    }
	    
	    func prepareDismiss() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanPresenterProtocol.self, method: "prepareDismiss()", parameterMatchers: matchers))
	    }
	    
	    func handleDismiss() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanPresenterProtocol.self, method: "handleDismiss()", parameterMatchers: matchers))
	    }
	    
	    func activateImport() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanPresenterProtocol.self, method: "activateImport()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_InvoiceScanPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func prepareAppearance() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("prepareAppearance()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleAppearance() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("handleAppearance()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareDismiss() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("prepareDismiss()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleDismiss() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("handleDismiss()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func activateImport() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("activateImport()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class InvoiceScanPresenterProtocolStub: InvoiceScanPresenterProtocol {
    

    

    
     func prepareAppearance()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func handleAppearance()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func prepareDismiss()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func handleDismiss()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func activateImport()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockInvoiceScanCoordinatorProtocol: InvoiceScanCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = InvoiceScanCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_InvoiceScanCoordinatorProtocol
     typealias Verification = __VerificationProxy_InvoiceScanCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: InvoiceScanCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: InvoiceScanCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func process(payload: AmountPayload)  {
        
    return cuckoo_manager.call("process(payload: AmountPayload)",
            parameters: (payload),
            escapingParameters: (payload),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.process(payload: payload))
        
    }
    
    
    
     func presentImageGallery(from view: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)  {
        
    return cuckoo_manager.call("presentImageGallery(from: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)",
            parameters: (view, delegate),
            escapingParameters: (view, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentImageGallery(from: view, delegate: delegate))
        
    }
    

	 struct __StubbingProxy_InvoiceScanCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func process<M1: Cuckoo.Matchable>(payload: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AmountPayload)> where M1.MatchedType == AmountPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountPayload)>] = [wrap(matchable: payload) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanCoordinatorProtocol.self, method: "process(payload: AmountPayload)", parameterMatchers: matchers))
	    }
	    
	    func presentImageGallery<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(from view: M1, delegate: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(ControllerBackedProtocol?, ImageGalleryDelegate)> where M1.OptionalMatchedType == ControllerBackedProtocol, M2.MatchedType == ImageGalleryDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<(ControllerBackedProtocol?, ImageGalleryDelegate)>] = [wrap(matchable: view) { $0.0 }, wrap(matchable: delegate) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockInvoiceScanCoordinatorProtocol.self, method: "presentImageGallery(from: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_InvoiceScanCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func process<M1: Cuckoo.Matchable>(payload: M1) -> Cuckoo.__DoNotUse<(AmountPayload), Void> where M1.MatchedType == AmountPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountPayload)>] = [wrap(matchable: payload) { $0 }]
	        return cuckoo_manager.verify("process(payload: AmountPayload)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentImageGallery<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(from view: M1, delegate: M2) -> Cuckoo.__DoNotUse<(ControllerBackedProtocol?, ImageGalleryDelegate), Void> where M1.OptionalMatchedType == ControllerBackedProtocol, M2.MatchedType == ImageGalleryDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<(ControllerBackedProtocol?, ImageGalleryDelegate)>] = [wrap(matchable: view) { $0.0 }, wrap(matchable: delegate) { $0.1 }]
	        return cuckoo_manager.verify("presentImageGallery(from: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class InvoiceScanCoordinatorProtocolStub: InvoiceScanCoordinatorProtocol {
    

    

    
     func process(payload: AmountPayload)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentImageGallery(from view: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockReceiveAmountViewProtocol: ReceiveAmountViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ReceiveAmountViewProtocol
    
     typealias Stubbing = __StubbingProxy_ReceiveAmountViewProtocol
     typealias Verification = __VerificationProxy_ReceiveAmountViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ReceiveAmountViewProtocol?

     func enableDefaultImplementation(_ stub: ReceiveAmountViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    

    

    
    
    
     func didReceive(image: UIImage)  {
        
    return cuckoo_manager.call("didReceive(image: UIImage)",
            parameters: (image),
            escapingParameters: (image),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(image: image))
        
    }
    
    
    
     func didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)  {
        
    return cuckoo_manager.call("didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)",
            parameters: (assetSelectionViewModel),
            escapingParameters: (assetSelectionViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(assetSelectionViewModel: assetSelectionViewModel))
        
    }
    
    
    
     func didReceive(amountInputViewModel: AmountInputViewModelProtocol)  {
        
    return cuckoo_manager.call("didReceive(amountInputViewModel: AmountInputViewModelProtocol)",
            parameters: (amountInputViewModel),
            escapingParameters: (amountInputViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(amountInputViewModel: amountInputViewModel))
        
    }
    
    
    
     func didReceive(descriptionViewModel: DescriptionInputViewModelProtocol)  {
        
    return cuckoo_manager.call("didReceive(descriptionViewModel: DescriptionInputViewModelProtocol)",
            parameters: (descriptionViewModel),
            escapingParameters: (descriptionViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(descriptionViewModel: descriptionViewModel))
        
    }
    
    
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)  {
        
    return cuckoo_manager.call("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)",
            parameters: (title, message, actions, completion),
            escapingParameters: (title, message, actions, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showAlert(title: title, message: message, actions: actions, completion: completion))
        
    }
    

	 struct __StubbingProxy_ReceiveAmountViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockReceiveAmountViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockReceiveAmountViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    func didReceive<M1: Cuckoo.Matchable>(image: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(UIImage)> where M1.MatchedType == UIImage {
	        let matchers: [Cuckoo.ParameterMatcher<(UIImage)>] = [wrap(matchable: image) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountViewProtocol.self, method: "didReceive(image: UIImage)", parameterMatchers: matchers))
	    }
	    
	    func didReceive<M1: Cuckoo.Matchable>(assetSelectionViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AssetSelectionViewModelProtocol)> where M1.MatchedType == AssetSelectionViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AssetSelectionViewModelProtocol)>] = [wrap(matchable: assetSelectionViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountViewProtocol.self, method: "didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func didReceive<M1: Cuckoo.Matchable>(amountInputViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AmountInputViewModelProtocol)> where M1.MatchedType == AmountInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountInputViewModelProtocol)>] = [wrap(matchable: amountInputViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountViewProtocol.self, method: "didReceive(amountInputViewModel: AmountInputViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func didReceive<M1: Cuckoo.Matchable>(descriptionViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(DescriptionInputViewModelProtocol)> where M1.MatchedType == DescriptionInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(DescriptionInputViewModelProtocol)>] = [wrap(matchable: descriptionViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountViewProtocol.self, method: "didReceive(descriptionViewModel: DescriptionInputViewModelProtocol)", parameterMatchers: matchers))
	    }
	    
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountViewProtocol.self, method: "showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ReceiveAmountViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.Matchable>(image: M1) -> Cuckoo.__DoNotUse<(UIImage), Void> where M1.MatchedType == UIImage {
	        let matchers: [Cuckoo.ParameterMatcher<(UIImage)>] = [wrap(matchable: image) { $0 }]
	        return cuckoo_manager.verify("didReceive(image: UIImage)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.Matchable>(assetSelectionViewModel: M1) -> Cuckoo.__DoNotUse<(AssetSelectionViewModelProtocol), Void> where M1.MatchedType == AssetSelectionViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AssetSelectionViewModelProtocol)>] = [wrap(matchable: assetSelectionViewModel) { $0 }]
	        return cuckoo_manager.verify("didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.Matchable>(amountInputViewModel: M1) -> Cuckoo.__DoNotUse<(AmountInputViewModelProtocol), Void> where M1.MatchedType == AmountInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountInputViewModelProtocol)>] = [wrap(matchable: amountInputViewModel) { $0 }]
	        return cuckoo_manager.verify("didReceive(amountInputViewModel: AmountInputViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.Matchable>(descriptionViewModel: M1) -> Cuckoo.__DoNotUse<(DescriptionInputViewModelProtocol), Void> where M1.MatchedType == DescriptionInputViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(DescriptionInputViewModelProtocol)>] = [wrap(matchable: descriptionViewModel) { $0 }]
	        return cuckoo_manager.verify("didReceive(descriptionViewModel: DescriptionInputViewModelProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.__DoNotUse<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return cuckoo_manager.verify("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ReceiveAmountViewProtocolStub: ReceiveAmountViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    

    

    
     func didReceive(image: UIImage)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didReceive(amountInputViewModel: AmountInputViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didReceive(descriptionViewModel: DescriptionInputViewModelProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockReceiveAmountPresenterProtocol: ReceiveAmountPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ReceiveAmountPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_ReceiveAmountPresenterProtocol
     typealias Verification = __VerificationProxy_ReceiveAmountPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ReceiveAmountPresenterProtocol?

     func enableDefaultImplementation(_ stub: ReceiveAmountPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup(qrSize: CGSize)  {
        
    return cuckoo_manager.call("setup(qrSize: CGSize)",
            parameters: (qrSize),
            escapingParameters: (qrSize),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup(qrSize: qrSize))
        
    }
    
    
    
     func presentAssetSelection()  {
        
    return cuckoo_manager.call("presentAssetSelection()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentAssetSelection())
        
    }
    
    
    
     func share()  {
        
    return cuckoo_manager.call("share()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.share())
        
    }
    
    
    
     func close()  {
        
    return cuckoo_manager.call("close()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.close())
        
    }
    

	 struct __StubbingProxy_ReceiveAmountPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup<M1: Cuckoo.Matchable>(qrSize: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CGSize)> where M1.MatchedType == CGSize {
	        let matchers: [Cuckoo.ParameterMatcher<(CGSize)>] = [wrap(matchable: qrSize) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountPresenterProtocol.self, method: "setup(qrSize: CGSize)", parameterMatchers: matchers))
	    }
	    
	    func presentAssetSelection() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountPresenterProtocol.self, method: "presentAssetSelection()", parameterMatchers: matchers))
	    }
	    
	    func share() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountPresenterProtocol.self, method: "share()", parameterMatchers: matchers))
	    }
	    
	    func close() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountPresenterProtocol.self, method: "close()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ReceiveAmountPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup<M1: Cuckoo.Matchable>(qrSize: M1) -> Cuckoo.__DoNotUse<(CGSize), Void> where M1.MatchedType == CGSize {
	        let matchers: [Cuckoo.ParameterMatcher<(CGSize)>] = [wrap(matchable: qrSize) { $0 }]
	        return cuckoo_manager.verify("setup(qrSize: CGSize)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentAssetSelection() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("presentAssetSelection()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func share() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("share()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func close() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("close()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ReceiveAmountPresenterProtocolStub: ReceiveAmountPresenterProtocol {
    

    

    
     func setup(qrSize: CGSize)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentAssetSelection()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func share()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func close()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockReceiveAmountCoordinatorProtocol: ReceiveAmountCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ReceiveAmountCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_ReceiveAmountCoordinatorProtocol
     typealias Verification = __VerificationProxy_ReceiveAmountCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ReceiveAmountCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: ReceiveAmountCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var resolver: ResolverProtocol {
        get {
            return cuckoo_manager.getter("resolver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.resolver)
        }
        
    }
    

    

    
    
    
     func close()  {
        
    return cuckoo_manager.call("close()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.close())
        
    }
    
    
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)  {
        
    return cuckoo_manager.call("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)",
            parameters: (titles, initialIndex, delegate),
            escapingParameters: (titles, initialIndex, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentPicker(for: titles, initialIndex: initialIndex, delegate: delegate))
        
    }
    
    
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)  {
        
    return cuckoo_manager.call("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)",
            parameters: (minDate, maxDate, delegate, locale),
            escapingParameters: (minDate, maxDate, delegate, locale),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentDatePicker(for: minDate, maxDate: maxDate, delegate: delegate, locale: locale))
        
    }
    
    
    
     func share(sources: [Any], from view: ControllerBackedProtocol?, with completionHandler: SharingCompletionHandler?)  {
        
    return cuckoo_manager.call("share(sources: [Any], from: ControllerBackedProtocol?, with: SharingCompletionHandler?)",
            parameters: (sources, view, completionHandler),
            escapingParameters: (sources, view, completionHandler),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.share(sources: sources, from: view, with: completionHandler))
        
    }
    

	 struct __StubbingProxy_ReceiveAmountCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var resolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockReceiveAmountCoordinatorProtocol, ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver")
	    }
	    
	    
	    func close() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountCoordinatorProtocol.self, method: "close()", parameterMatchers: matchers))
	    }
	    
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String], Int, ModalPickerViewDelegate?)> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountCoordinatorProtocol.self, method: "presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", parameterMatchers: matchers))
	    }
	    
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountCoordinatorProtocol.self, method: "presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", parameterMatchers: matchers))
	    }
	    
	    func share<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(sources: M1, from view: M2, with completionHandler: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([Any], ControllerBackedProtocol?, SharingCompletionHandler?)> where M1.MatchedType == [Any], M2.OptionalMatchedType == ControllerBackedProtocol, M3.OptionalMatchedType == SharingCompletionHandler {
	        let matchers: [Cuckoo.ParameterMatcher<([Any], ControllerBackedProtocol?, SharingCompletionHandler?)>] = [wrap(matchable: sources) { $0.0 }, wrap(matchable: view) { $0.1 }, wrap(matchable: completionHandler) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReceiveAmountCoordinatorProtocol.self, method: "share(sources: [Any], from: ControllerBackedProtocol?, with: SharingCompletionHandler?)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ReceiveAmountCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var resolver: Cuckoo.VerifyReadOnlyProperty<ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func close() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("close()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.__DoNotUse<([String], Int, ModalPickerViewDelegate?), Void> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return cuckoo_manager.verify("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.__DoNotUse<(Date?, Date?, ModalDatePickerViewDelegate?, Locale), Void> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return cuckoo_manager.verify("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func share<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(sources: M1, from view: M2, with completionHandler: M3) -> Cuckoo.__DoNotUse<([Any], ControllerBackedProtocol?, SharingCompletionHandler?), Void> where M1.MatchedType == [Any], M2.OptionalMatchedType == ControllerBackedProtocol, M3.OptionalMatchedType == SharingCompletionHandler {
	        let matchers: [Cuckoo.ParameterMatcher<([Any], ControllerBackedProtocol?, SharingCompletionHandler?)>] = [wrap(matchable: sources) { $0.0 }, wrap(matchable: view) { $0.1 }, wrap(matchable: completionHandler) { $0.2 }]
	        return cuckoo_manager.verify("share(sources: [Any], from: ControllerBackedProtocol?, with: SharingCompletionHandler?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ReceiveAmountCoordinatorProtocolStub: ReceiveAmountCoordinatorProtocol {
    
    
     var resolver: ResolverProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ResolverProtocol).self)
        }
        
    }
    

    

    
     func close()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func share(sources: [Any], from view: ControllerBackedProtocol?, with completionHandler: SharingCompletionHandler?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockTransactionDetailsPresenterProtocol: TransactionDetailsPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TransactionDetailsPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_TransactionDetailsPresenterProtocol
     typealias Verification = __VerificationProxy_TransactionDetailsPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TransactionDetailsPresenterProtocol?

     func enableDefaultImplementation(_ stub: TransactionDetailsPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func performAction()  {
        
    return cuckoo_manager.call("performAction()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.performAction())
        
    }
    

	 struct __StubbingProxy_TransactionDetailsPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTransactionDetailsPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func performAction() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTransactionDetailsPresenterProtocol.self, method: "performAction()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TransactionDetailsPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func performAction() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("performAction()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TransactionDetailsPresenterProtocolStub: TransactionDetailsPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func performAction()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockTransactionDetailsCoordinatorProtocol: TransactionDetailsCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TransactionDetailsCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_TransactionDetailsCoordinatorProtocol
     typealias Verification = __VerificationProxy_TransactionDetailsCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TransactionDetailsCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: TransactionDetailsCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func send(to payload: AmountPayload)  {
        
    return cuckoo_manager.call("send(to: AmountPayload)",
            parameters: (payload),
            escapingParameters: (payload),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.send(to: payload))
        
    }
    

	 struct __StubbingProxy_TransactionDetailsCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func send<M1: Cuckoo.Matchable>(to payload: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AmountPayload)> where M1.MatchedType == AmountPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountPayload)>] = [wrap(matchable: payload) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransactionDetailsCoordinatorProtocol.self, method: "send(to: AmountPayload)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TransactionDetailsCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func send<M1: Cuckoo.Matchable>(to payload: M1) -> Cuckoo.__DoNotUse<(AmountPayload), Void> where M1.MatchedType == AmountPayload {
	        let matchers: [Cuckoo.ParameterMatcher<(AmountPayload)>] = [wrap(matchable: payload) { $0 }]
	        return cuckoo_manager.verify("send(to: AmountPayload)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TransactionDetailsCoordinatorProtocolStub: TransactionDetailsCoordinatorProtocol {
    

    

    
     func send(to payload: AmountPayload)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockTransferResultPresenterProtocol: TransferResultPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TransferResultPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_TransferResultPresenterProtocol
     typealias Verification = __VerificationProxy_TransferResultPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TransferResultPresenterProtocol?

     func enableDefaultImplementation(_ stub: TransferResultPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func performAction()  {
        
    return cuckoo_manager.call("performAction()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.performAction())
        
    }
    

	 struct __StubbingProxy_TransferResultPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTransferResultPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func performAction() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTransferResultPresenterProtocol.self, method: "performAction()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TransferResultPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func performAction() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("performAction()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TransferResultPresenterProtocolStub: TransferResultPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func performAction()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockTransferResultCoordinatorProtocol: TransferResultCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TransferResultCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_TransferResultCoordinatorProtocol
     typealias Verification = __VerificationProxy_TransferResultCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TransferResultCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: TransferResultCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func dismiss()  {
        
    return cuckoo_manager.call("dismiss()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.dismiss())
        
    }
    

	 struct __StubbingProxy_TransferResultCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func dismiss() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTransferResultCoordinatorProtocol.self, method: "dismiss()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TransferResultCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func dismiss() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("dismiss()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TransferResultCoordinatorProtocolStub: TransferResultCoordinatorProtocol {
    

    

    
     func dismiss()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockWalletFormViewProtocol: WalletFormViewProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletFormViewProtocol
    
     typealias Stubbing = __StubbingProxy_WalletFormViewProtocol
     typealias Verification = __VerificationProxy_WalletFormViewProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletFormViewProtocol?

     func enableDefaultImplementation(_ stub: WalletFormViewProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var isSetup: Bool {
        get {
            return cuckoo_manager.getter("isSetup",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSetup)
        }
        
    }
    
    
    
     var controller: UIViewController {
        get {
            return cuckoo_manager.getter("controller",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.controller)
        }
        
    }
    
    
    
     var loadableContentView: UIView! {
        get {
            return cuckoo_manager.getter("loadableContentView",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.loadableContentView)
        }
        
    }
    
    
    
     var shouldDisableInteractionWhenLoading: Bool {
        get {
            return cuckoo_manager.getter("shouldDisableInteractionWhenLoading",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.shouldDisableInteractionWhenLoading)
        }
        
    }
    

    

    
    
    
     func didReceive(viewModels: [WalletFormViewModelProtocol])  {
        
    return cuckoo_manager.call("didReceive(viewModels: [WalletFormViewModelProtocol])",
            parameters: (viewModels),
            escapingParameters: (viewModels),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(viewModels: viewModels))
        
    }
    
    
    
     func didReceive(accessoryViewModel: AccessoryViewModelProtocol?)  {
        
    return cuckoo_manager.call("didReceive(accessoryViewModel: AccessoryViewModelProtocol?)",
            parameters: (accessoryViewModel),
            escapingParameters: (accessoryViewModel),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceive(accessoryViewModel: accessoryViewModel))
        
    }
    
    
    
     func didStartLoading()  {
        
    return cuckoo_manager.call("didStartLoading()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStartLoading())
        
    }
    
    
    
     func didStopLoading()  {
        
    return cuckoo_manager.call("didStopLoading()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didStopLoading())
        
    }
    
    
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)  {
        
    return cuckoo_manager.call("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)",
            parameters: (title, message, actions, completion),
            escapingParameters: (title, message, actions, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showAlert(title: title, message: message, actions: actions, completion: completion))
        
    }
    

	 struct __StubbingProxy_WalletFormViewProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var isSetup: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWalletFormViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup")
	    }
	    
	    
	    var controller: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWalletFormViewProtocol, UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller")
	    }
	    
	    
	    var loadableContentView: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWalletFormViewProtocol, UIView?> {
	        return .init(manager: cuckoo_manager, name: "loadableContentView")
	    }
	    
	    
	    var shouldDisableInteractionWhenLoading: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWalletFormViewProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "shouldDisableInteractionWhenLoading")
	    }
	    
	    
	    func didReceive<M1: Cuckoo.Matchable>(viewModels: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([WalletFormViewModelProtocol])> where M1.MatchedType == [WalletFormViewModelProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([WalletFormViewModelProtocol])>] = [wrap(matchable: viewModels) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormViewProtocol.self, method: "didReceive(viewModels: [WalletFormViewModelProtocol])", parameterMatchers: matchers))
	    }
	    
	    func didReceive<M1: Cuckoo.OptionalMatchable>(accessoryViewModel: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AccessoryViewModelProtocol?)> where M1.OptionalMatchedType == AccessoryViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AccessoryViewModelProtocol?)>] = [wrap(matchable: accessoryViewModel) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormViewProtocol.self, method: "didReceive(accessoryViewModel: AccessoryViewModelProtocol?)", parameterMatchers: matchers))
	    }
	    
	    func didStartLoading() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormViewProtocol.self, method: "didStartLoading()", parameterMatchers: matchers))
	    }
	    
	    func didStopLoading() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormViewProtocol.self, method: "didStopLoading()", parameterMatchers: matchers))
	    }
	    
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormViewProtocol.self, method: "showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletFormViewProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var isSetup: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSetup", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var controller: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
	        return .init(manager: cuckoo_manager, name: "controller", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var loadableContentView: Cuckoo.VerifyReadOnlyProperty<UIView?> {
	        return .init(manager: cuckoo_manager, name: "loadableContentView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var shouldDisableInteractionWhenLoading: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "shouldDisableInteractionWhenLoading", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.Matchable>(viewModels: M1) -> Cuckoo.__DoNotUse<([WalletFormViewModelProtocol]), Void> where M1.MatchedType == [WalletFormViewModelProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([WalletFormViewModelProtocol])>] = [wrap(matchable: viewModels) { $0 }]
	        return cuckoo_manager.verify("didReceive(viewModels: [WalletFormViewModelProtocol])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didReceive<M1: Cuckoo.OptionalMatchable>(accessoryViewModel: M1) -> Cuckoo.__DoNotUse<(AccessoryViewModelProtocol?), Void> where M1.OptionalMatchedType == AccessoryViewModelProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(AccessoryViewModelProtocol?)>] = [wrap(matchable: accessoryViewModel) { $0 }]
	        return cuckoo_manager.verify("didReceive(accessoryViewModel: AccessoryViewModelProtocol?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStartLoading() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStartLoading()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func didStopLoading() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("didStopLoading()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showAlert<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(title: M1, message: M2, actions: M3, completion: M4) -> Cuckoo.__DoNotUse<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == [(String, UIAlertAction.Style)], M4.MatchedType == (_ index: Int) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, [(String, UIAlertAction.Style)], (_ index: Int) -> Void)>] = [wrap(matchable: title) { $0.0 }, wrap(matchable: message) { $0.1 }, wrap(matchable: actions) { $0.2 }, wrap(matchable: completion) { $0.3 }]
	        return cuckoo_manager.verify("showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletFormViewProtocolStub: WalletFormViewProtocol {
    
    
     var isSetup: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var controller: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    
    
     var loadableContentView: UIView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView?).self)
        }
        
    }
    
    
     var shouldDisableInteractionWhenLoading: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    

    

    
     func didReceive(viewModels: [WalletFormViewModelProtocol])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didReceive(accessoryViewModel: AccessoryViewModelProtocol?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStartLoading()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func didStopLoading()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func showAlert(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockWalletFormPresenterProtocol: WalletFormPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletFormPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_WalletFormPresenterProtocol
     typealias Verification = __VerificationProxy_WalletFormPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletFormPresenterProtocol?

     func enableDefaultImplementation(_ stub: WalletFormPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func performAction()  {
        
    return cuckoo_manager.call("performAction()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.performAction())
        
    }
    

	 struct __StubbingProxy_WalletFormPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func performAction() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletFormPresenterProtocol.self, method: "performAction()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletFormPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func performAction() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("performAction()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletFormPresenterProtocolStub: WalletFormPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func performAction()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockWithdrawAmountCoordinatorProtocol: WithdrawAmountCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawAmountCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_WithdrawAmountCoordinatorProtocol
     typealias Verification = __VerificationProxy_WithdrawAmountCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawAmountCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: WithdrawAmountCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var resolver: ResolverProtocol {
        get {
            return cuckoo_manager.getter("resolver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.resolver)
        }
        
    }
    

    

    
    
    
     func confirm(with info: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)  {
        
    return cuckoo_manager.call("confirm(with: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)",
            parameters: (info, asset, option),
            escapingParameters: (info, asset, option),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.confirm(with: info, asset: asset, option: option))
        
    }
    
    
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)  {
        
    return cuckoo_manager.call("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)",
            parameters: (titles, initialIndex, delegate),
            escapingParameters: (titles, initialIndex, delegate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentPicker(for: titles, initialIndex: initialIndex, delegate: delegate))
        
    }
    
    
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)  {
        
    return cuckoo_manager.call("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)",
            parameters: (minDate, maxDate, delegate, locale),
            escapingParameters: (minDate, maxDate, delegate, locale),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.presentDatePicker(for: minDate, maxDate: maxDate, delegate: delegate, locale: locale))
        
    }
    

	 struct __StubbingProxy_WithdrawAmountCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var resolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWithdrawAmountCoordinatorProtocol, ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver")
	    }
	    
	    
	    func confirm<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(with info: M1, asset: M2, option: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(WithdrawInfo, WalletAsset, WalletWithdrawOption)> where M1.MatchedType == WithdrawInfo, M2.MatchedType == WalletAsset, M3.MatchedType == WalletWithdrawOption {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawInfo, WalletAsset, WalletWithdrawOption)>] = [wrap(matchable: info) { $0.0 }, wrap(matchable: asset) { $0.1 }, wrap(matchable: option) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawAmountCoordinatorProtocol.self, method: "confirm(with: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)", parameterMatchers: matchers))
	    }
	    
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String], Int, ModalPickerViewDelegate?)> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawAmountCoordinatorProtocol.self, method: "presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", parameterMatchers: matchers))
	    }
	    
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawAmountCoordinatorProtocol.self, method: "presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WithdrawAmountCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var resolver: Cuckoo.VerifyReadOnlyProperty<ResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "resolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func confirm<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(with info: M1, asset: M2, option: M3) -> Cuckoo.__DoNotUse<(WithdrawInfo, WalletAsset, WalletWithdrawOption), Void> where M1.MatchedType == WithdrawInfo, M2.MatchedType == WalletAsset, M3.MatchedType == WalletWithdrawOption {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawInfo, WalletAsset, WalletWithdrawOption)>] = [wrap(matchable: info) { $0.0 }, wrap(matchable: asset) { $0.1 }, wrap(matchable: option) { $0.2 }]
	        return cuckoo_manager.verify("confirm(with: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentPicker<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(for titles: M1, initialIndex: M2, delegate: M3) -> Cuckoo.__DoNotUse<([String], Int, ModalPickerViewDelegate?), Void> where M1.MatchedType == [String], M2.MatchedType == Int, M3.OptionalMatchedType == ModalPickerViewDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<([String], Int, ModalPickerViewDelegate?)>] = [wrap(matchable: titles) { $0.0 }, wrap(matchable: initialIndex) { $0.1 }, wrap(matchable: delegate) { $0.2 }]
	        return cuckoo_manager.verify("presentPicker(for: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func presentDatePicker<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(for minDate: M1, maxDate: M2, delegate: M3, locale: M4) -> Cuckoo.__DoNotUse<(Date?, Date?, ModalDatePickerViewDelegate?, Locale), Void> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == ModalDatePickerViewDelegate, M4.MatchedType == Locale {
	        let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, ModalDatePickerViewDelegate?, Locale)>] = [wrap(matchable: minDate) { $0.0 }, wrap(matchable: maxDate) { $0.1 }, wrap(matchable: delegate) { $0.2 }, wrap(matchable: locale) { $0.3 }]
	        return cuckoo_manager.verify("presentDatePicker(for: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WithdrawAmountCoordinatorProtocolStub: WithdrawAmountCoordinatorProtocol {
    
    
     var resolver: ResolverProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ResolverProtocol).self)
        }
        
    }
    

    

    
     func confirm(with info: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentPicker(for titles: [String], initialIndex: Int, delegate: ModalPickerViewDelegate?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func presentDatePicker(for minDate: Date?, maxDate: Date?, delegate: ModalDatePickerViewDelegate?, locale: Locale)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockWithdrawConfirmationPresenterProtocol: WithdrawConfirmationPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawConfirmationPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_WithdrawConfirmationPresenterProtocol
     typealias Verification = __VerificationProxy_WithdrawConfirmationPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawConfirmationPresenterProtocol?

     func enableDefaultImplementation(_ stub: WithdrawConfirmationPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func performAction()  {
        
    return cuckoo_manager.call("performAction()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.performAction())
        
    }
    

	 struct __StubbingProxy_WithdrawConfirmationPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawConfirmationPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func performAction() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawConfirmationPresenterProtocol.self, method: "performAction()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WithdrawConfirmationPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func performAction() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("performAction()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WithdrawConfirmationPresenterProtocolStub: WithdrawConfirmationPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func performAction()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockWithdrawConfirmationCoordinatorProtocol: WithdrawConfirmationCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawConfirmationCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_WithdrawConfirmationCoordinatorProtocol
     typealias Verification = __VerificationProxy_WithdrawConfirmationCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawConfirmationCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: WithdrawConfirmationCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func showResult(for withdrawInfo: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)  {
        
    return cuckoo_manager.call("showResult(for: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)",
            parameters: (withdrawInfo, asset, option),
            escapingParameters: (withdrawInfo, asset, option),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showResult(for: withdrawInfo, asset: asset, option: option))
        
    }
    

	 struct __StubbingProxy_WithdrawConfirmationCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func showResult<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(for withdrawInfo: M1, asset: M2, option: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(WithdrawInfo, WalletAsset, WalletWithdrawOption)> where M1.MatchedType == WithdrawInfo, M2.MatchedType == WalletAsset, M3.MatchedType == WalletWithdrawOption {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawInfo, WalletAsset, WalletWithdrawOption)>] = [wrap(matchable: withdrawInfo) { $0.0 }, wrap(matchable: asset) { $0.1 }, wrap(matchable: option) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawConfirmationCoordinatorProtocol.self, method: "showResult(for: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WithdrawConfirmationCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func showResult<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(for withdrawInfo: M1, asset: M2, option: M3) -> Cuckoo.__DoNotUse<(WithdrawInfo, WalletAsset, WalletWithdrawOption), Void> where M1.MatchedType == WithdrawInfo, M2.MatchedType == WalletAsset, M3.MatchedType == WalletWithdrawOption {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawInfo, WalletAsset, WalletWithdrawOption)>] = [wrap(matchable: withdrawInfo) { $0.0 }, wrap(matchable: asset) { $0.1 }, wrap(matchable: option) { $0.2 }]
	        return cuckoo_manager.verify("showResult(for: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WithdrawConfirmationCoordinatorProtocolStub: WithdrawConfirmationCoordinatorProtocol {
    

    

    
     func showResult(for withdrawInfo: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet


 class MockWithdrawResultPresenterProtocol: WithdrawResultPresenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawResultPresenterProtocol
    
     typealias Stubbing = __StubbingProxy_WithdrawResultPresenterProtocol
     typealias Verification = __VerificationProxy_WithdrawResultPresenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawResultPresenterProtocol?

     func enableDefaultImplementation(_ stub: WithdrawResultPresenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setup()  {
        
    return cuckoo_manager.call("setup()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    
    
     func performAction()  {
        
    return cuckoo_manager.call("performAction()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.performAction())
        
    }
    

	 struct __StubbingProxy_WithdrawResultPresenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawResultPresenterProtocol.self, method: "setup()", parameterMatchers: matchers))
	    }
	    
	    func performAction() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawResultPresenterProtocol.self, method: "performAction()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WithdrawResultPresenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setup() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setup()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func performAction() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("performAction()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WithdrawResultPresenterProtocolStub: WithdrawResultPresenterProtocol {
    

    

    
     func setup()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func performAction()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockWithdrawResultCoordinatorProtocol: WithdrawResultCoordinatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawResultCoordinatorProtocol
    
     typealias Stubbing = __StubbingProxy_WithdrawResultCoordinatorProtocol
     typealias Verification = __VerificationProxy_WithdrawResultCoordinatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawResultCoordinatorProtocol?

     func enableDefaultImplementation(_ stub: WithdrawResultCoordinatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func dismiss()  {
        
    return cuckoo_manager.call("dismiss()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.dismiss())
        
    }
    

	 struct __StubbingProxy_WithdrawResultCoordinatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func dismiss() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawResultCoordinatorProtocol.self, method: "dismiss()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WithdrawResultCoordinatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func dismiss() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("dismiss()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WithdrawResultCoordinatorProtocolStub: WithdrawResultCoordinatorProtocol {
    

    

    
     func dismiss()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

