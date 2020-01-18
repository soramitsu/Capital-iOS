/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Cuckoo
@testable import CommonWallet

import Foundation
import IrohaCommunication


public class MockAssetDetailsCommadProtocol: AssetDetailsCommadProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = AssetDetailsCommadProtocol
    
    public typealias Stubbing = __StubbingProxy_AssetDetailsCommadProtocol
    public typealias Verification = __VerificationProxy_AssetDetailsCommadProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AssetDetailsCommadProtocol?

    public func enableDefaultImplementation(_ stub: AssetDetailsCommadProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var ignoredWhenSingleAsset: Bool {
        get {
            return cuckoo_manager.getter("ignoredWhenSingleAsset",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.ignoredWhenSingleAsset)
        }
        
        set {
            cuckoo_manager.setter("ignoredWhenSingleAsset",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.ignoredWhenSingleAsset = newValue)
        }
        
    }
    
    
    
    public var presentationStyle: WalletPresentationStyle {
        get {
            return cuckoo_manager.getter("presentationStyle",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.presentationStyle)
        }
        
        set {
            cuckoo_manager.setter("presentationStyle",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.presentationStyle = newValue)
        }
        
    }
    
    
    
    public var animated: Bool {
        get {
            return cuckoo_manager.getter("animated",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.animated)
        }
        
        set {
            cuckoo_manager.setter("animated",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.animated = newValue)
        }
        
    }
    

    

    
    
    
    public func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	public struct __StubbingProxy_AssetDetailsCommadProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var ignoredWhenSingleAsset: Cuckoo.ProtocolToBeStubbedProperty<MockAssetDetailsCommadProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "ignoredWhenSingleAsset")
	    }
	    
	    
	    var presentationStyle: Cuckoo.ProtocolToBeStubbedProperty<MockAssetDetailsCommadProtocol, WalletPresentationStyle> {
	        return .init(manager: cuckoo_manager, name: "presentationStyle")
	    }
	    
	    
	    var animated: Cuckoo.ProtocolToBeStubbedProperty<MockAssetDetailsCommadProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "animated")
	    }
	    
	    
	    func execute() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAssetDetailsCommadProtocol.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AssetDetailsCommadProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var ignoredWhenSingleAsset: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "ignoredWhenSingleAsset", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var presentationStyle: Cuckoo.VerifyProperty<WalletPresentationStyle> {
	        return .init(manager: cuckoo_manager, name: "presentationStyle", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var animated: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "animated", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AssetDetailsCommadProtocolStub: AssetDetailsCommadProtocol {
    
    
    public var ignoredWhenSingleAsset: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
    
    public var presentationStyle: WalletPresentationStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletPresentationStyle).self)
        }
        
        set { }
        
    }
    
    
    public var animated: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    

    

    
    public func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


public class MockWalletCommandProtocol: WalletCommandProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletCommandProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletCommandProtocol
    public typealias Verification = __VerificationProxy_WalletCommandProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletCommandProtocol?

    public func enableDefaultImplementation(_ stub: WalletCommandProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	public struct __StubbingProxy_WalletCommandProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandProtocol.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletCommandProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletCommandProtocolStub: WalletCommandProtocol {
    

    

    
    public func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


public class MockWalletHideCommandProtocol: WalletHideCommandProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletHideCommandProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletHideCommandProtocol
    public typealias Verification = __VerificationProxy_WalletHideCommandProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletHideCommandProtocol?

    public func enableDefaultImplementation(_ stub: WalletHideCommandProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var actionType: WalletHideActionType {
        get {
            return cuckoo_manager.getter("actionType",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.actionType)
        }
        
        set {
            cuckoo_manager.setter("actionType",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.actionType = newValue)
        }
        
    }
    
    
    
    public var animated: Bool {
        get {
            return cuckoo_manager.getter("animated",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.animated)
        }
        
        set {
            cuckoo_manager.setter("animated",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.animated = newValue)
        }
        
    }
    

    

    
    
    
    public func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	public struct __StubbingProxy_WalletHideCommandProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var actionType: Cuckoo.ProtocolToBeStubbedProperty<MockWalletHideCommandProtocol, WalletHideActionType> {
	        return .init(manager: cuckoo_manager, name: "actionType")
	    }
	    
	    
	    var animated: Cuckoo.ProtocolToBeStubbedProperty<MockWalletHideCommandProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "animated")
	    }
	    
	    
	    func execute() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletHideCommandProtocol.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletHideCommandProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var actionType: Cuckoo.VerifyProperty<WalletHideActionType> {
	        return .init(manager: cuckoo_manager, name: "actionType", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var animated: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "animated", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletHideCommandProtocolStub: WalletHideCommandProtocol {
    
    
    public var actionType: WalletHideActionType {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletHideActionType).self)
        }
        
        set { }
        
    }
    
    
    public var animated: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    

    

    
    public func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


public class MockWalletPresentationCommandProtocol: WalletPresentationCommandProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletPresentationCommandProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletPresentationCommandProtocol
    public typealias Verification = __VerificationProxy_WalletPresentationCommandProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletPresentationCommandProtocol?

    public func enableDefaultImplementation(_ stub: WalletPresentationCommandProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var presentationStyle: WalletPresentationStyle {
        get {
            return cuckoo_manager.getter("presentationStyle",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.presentationStyle)
        }
        
        set {
            cuckoo_manager.setter("presentationStyle",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.presentationStyle = newValue)
        }
        
    }
    
    
    
    public var animated: Bool {
        get {
            return cuckoo_manager.getter("animated",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.animated)
        }
        
        set {
            cuckoo_manager.setter("animated",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.animated = newValue)
        }
        
    }
    

    

    
    
    
    public func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	public struct __StubbingProxy_WalletPresentationCommandProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var presentationStyle: Cuckoo.ProtocolToBeStubbedProperty<MockWalletPresentationCommandProtocol, WalletPresentationStyle> {
	        return .init(manager: cuckoo_manager, name: "presentationStyle")
	    }
	    
	    
	    var animated: Cuckoo.ProtocolToBeStubbedProperty<MockWalletPresentationCommandProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "animated")
	    }
	    
	    
	    func execute() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletPresentationCommandProtocol.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletPresentationCommandProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var presentationStyle: Cuckoo.VerifyProperty<WalletPresentationStyle> {
	        return .init(manager: cuckoo_manager, name: "presentationStyle", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var animated: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "animated", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletPresentationCommandProtocolStub: WalletPresentationCommandProtocol {
    
    
    public var presentationStyle: WalletPresentationStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletPresentationStyle).self)
        }
        
        set { }
        
    }
    
    
    public var animated: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    

    

    
    public func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockWalletEventProtocol: WalletEventProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletEventProtocol
    
     typealias Stubbing = __StubbingProxy_WalletEventProtocol
     typealias Verification = __VerificationProxy_WalletEventProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletEventProtocol?

     func enableDefaultImplementation(_ stub: WalletEventProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func accept(visitor: WalletEventVisitorProtocol)  {
        
    return cuckoo_manager.call("accept(visitor: WalletEventVisitorProtocol)",
            parameters: (visitor),
            escapingParameters: (visitor),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.accept(visitor: visitor))
        
    }
    

	 struct __StubbingProxy_WalletEventProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func accept<M1: Cuckoo.Matchable>(visitor: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletEventVisitorProtocol)> where M1.MatchedType == WalletEventVisitorProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventVisitorProtocol)>] = [wrap(matchable: visitor) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventProtocol.self, method: "accept(visitor: WalletEventVisitorProtocol)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletEventProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func accept<M1: Cuckoo.Matchable>(visitor: M1) -> Cuckoo.__DoNotUse<(WalletEventVisitorProtocol), Void> where M1.MatchedType == WalletEventVisitorProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventVisitorProtocol)>] = [wrap(matchable: visitor) { $0 }]
	        return cuckoo_manager.verify("accept(visitor: WalletEventVisitorProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletEventProtocolStub: WalletEventProtocol {
    

    

    
     func accept(visitor: WalletEventVisitorProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockWalletEventCenterProtocol: WalletEventCenterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletEventCenterProtocol
    
     typealias Stubbing = __StubbingProxy_WalletEventCenterProtocol
     typealias Verification = __VerificationProxy_WalletEventCenterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletEventCenterProtocol?

     func enableDefaultImplementation(_ stub: WalletEventCenterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func notify(with event: WalletEventProtocol)  {
        
    return cuckoo_manager.call("notify(with: WalletEventProtocol)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.notify(with: event))
        
    }
    
    
    
     func add(observer: WalletEventVisitorProtocol, dispatchIn queue: DispatchQueue?)  {
        
    return cuckoo_manager.call("add(observer: WalletEventVisitorProtocol, dispatchIn: DispatchQueue?)",
            parameters: (observer, queue),
            escapingParameters: (observer, queue),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.add(observer: observer, dispatchIn: queue))
        
    }
    
    
    
     func remove(observer: WalletEventVisitorProtocol)  {
        
    return cuckoo_manager.call("remove(observer: WalletEventVisitorProtocol)",
            parameters: (observer),
            escapingParameters: (observer),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.remove(observer: observer))
        
    }
    

	 struct __StubbingProxy_WalletEventCenterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func notify<M1: Cuckoo.Matchable>(with event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletEventProtocol)> where M1.MatchedType == WalletEventProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventProtocol)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventCenterProtocol.self, method: "notify(with: WalletEventProtocol)", parameterMatchers: matchers))
	    }
	    
	    func add<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(observer: M1, dispatchIn queue: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletEventVisitorProtocol, DispatchQueue?)> where M1.MatchedType == WalletEventVisitorProtocol, M2.OptionalMatchedType == DispatchQueue {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventVisitorProtocol, DispatchQueue?)>] = [wrap(matchable: observer) { $0.0 }, wrap(matchable: queue) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventCenterProtocol.self, method: "add(observer: WalletEventVisitorProtocol, dispatchIn: DispatchQueue?)", parameterMatchers: matchers))
	    }
	    
	    func remove<M1: Cuckoo.Matchable>(observer: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletEventVisitorProtocol)> where M1.MatchedType == WalletEventVisitorProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventVisitorProtocol)>] = [wrap(matchable: observer) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventCenterProtocol.self, method: "remove(observer: WalletEventVisitorProtocol)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletEventCenterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func notify<M1: Cuckoo.Matchable>(with event: M1) -> Cuckoo.__DoNotUse<(WalletEventProtocol), Void> where M1.MatchedType == WalletEventProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventProtocol)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("notify(with: WalletEventProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func add<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(observer: M1, dispatchIn queue: M2) -> Cuckoo.__DoNotUse<(WalletEventVisitorProtocol, DispatchQueue?), Void> where M1.MatchedType == WalletEventVisitorProtocol, M2.OptionalMatchedType == DispatchQueue {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventVisitorProtocol, DispatchQueue?)>] = [wrap(matchable: observer) { $0.0 }, wrap(matchable: queue) { $0.1 }]
	        return cuckoo_manager.verify("add(observer: WalletEventVisitorProtocol, dispatchIn: DispatchQueue?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func remove<M1: Cuckoo.Matchable>(observer: M1) -> Cuckoo.__DoNotUse<(WalletEventVisitorProtocol), Void> where M1.MatchedType == WalletEventVisitorProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletEventVisitorProtocol)>] = [wrap(matchable: observer) { $0 }]
	        return cuckoo_manager.verify("remove(observer: WalletEventVisitorProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletEventCenterProtocolStub: WalletEventCenterProtocol {
    

    

    
     func notify(with event: WalletEventProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func add(observer: WalletEventVisitorProtocol, dispatchIn queue: DispatchQueue?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func remove(observer: WalletEventVisitorProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockWalletEventVisitorProtocol: WalletEventVisitorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletEventVisitorProtocol
    
     typealias Stubbing = __StubbingProxy_WalletEventVisitorProtocol
     typealias Verification = __VerificationProxy_WalletEventVisitorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletEventVisitorProtocol?

     func enableDefaultImplementation(_ stub: WalletEventVisitorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func processTransferComplete(event: TransferCompleteEvent)  {
        
    return cuckoo_manager.call("processTransferComplete(event: TransferCompleteEvent)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.processTransferComplete(event: event))
        
    }
    
    
    
     func processWithdrawComplete(event: WithdrawCompleteEvent)  {
        
    return cuckoo_manager.call("processWithdrawComplete(event: WithdrawCompleteEvent)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.processWithdrawComplete(event: event))
        
    }
    
    
    
     func processAccountUpdate(event: AccountUpdateEvent)  {
        
    return cuckoo_manager.call("processAccountUpdate(event: AccountUpdateEvent)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.processAccountUpdate(event: event))
        
    }
    

	 struct __StubbingProxy_WalletEventVisitorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func processTransferComplete<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TransferCompleteEvent)> where M1.MatchedType == TransferCompleteEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferCompleteEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventVisitorProtocol.self, method: "processTransferComplete(event: TransferCompleteEvent)", parameterMatchers: matchers))
	    }
	    
	    func processWithdrawComplete<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(WithdrawCompleteEvent)> where M1.MatchedType == WithdrawCompleteEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawCompleteEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventVisitorProtocol.self, method: "processWithdrawComplete(event: WithdrawCompleteEvent)", parameterMatchers: matchers))
	    }
	    
	    func processAccountUpdate<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(AccountUpdateEvent)> where M1.MatchedType == AccountUpdateEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(AccountUpdateEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletEventVisitorProtocol.self, method: "processAccountUpdate(event: AccountUpdateEvent)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletEventVisitorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func processTransferComplete<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(TransferCompleteEvent), Void> where M1.MatchedType == TransferCompleteEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferCompleteEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("processTransferComplete(event: TransferCompleteEvent)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func processWithdrawComplete<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(WithdrawCompleteEvent), Void> where M1.MatchedType == WithdrawCompleteEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawCompleteEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("processWithdrawComplete(event: WithdrawCompleteEvent)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func processAccountUpdate<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(AccountUpdateEvent), Void> where M1.MatchedType == AccountUpdateEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(AccountUpdateEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("processAccountUpdate(event: AccountUpdateEvent)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletEventVisitorProtocolStub: WalletEventVisitorProtocol {
    

    

    
     func processTransferComplete(event: TransferCompleteEvent)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func processWithdrawComplete(event: WithdrawCompleteEvent)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func processAccountUpdate(event: AccountUpdateEvent)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


public class MockFeeDisplayStrategyProtocol: FeeDisplayStrategyProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = FeeDisplayStrategyProtocol
    
    public typealias Stubbing = __StubbingProxy_FeeDisplayStrategyProtocol
    public typealias Verification = __VerificationProxy_FeeDisplayStrategyProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeeDisplayStrategyProtocol?

    public func enableDefaultImplementation(_ stub: FeeDisplayStrategyProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func decimalValue(from feeString: String?) -> Decimal? {
        
    return cuckoo_manager.call("decimalValue(from: String?) -> Decimal?",
            parameters: (feeString),
            escapingParameters: (feeString),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.decimalValue(from: feeString))
        
    }
    

	public struct __StubbingProxy_FeeDisplayStrategyProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func decimalValue<M1: Cuckoo.OptionalMatchable>(from feeString: M1) -> Cuckoo.ProtocolStubFunction<(String?), Decimal?> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: feeString) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFeeDisplayStrategyProtocol.self, method: "decimalValue(from: String?) -> Decimal?", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_FeeDisplayStrategyProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func decimalValue<M1: Cuckoo.OptionalMatchable>(from feeString: M1) -> Cuckoo.__DoNotUse<(String?), Decimal?> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: feeString) { $0 }]
	        return cuckoo_manager.verify("decimalValue(from: String?) -> Decimal?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class FeeDisplayStrategyProtocolStub: FeeDisplayStrategyProtocol {
    

    

    
    public func decimalValue(from feeString: String?) -> Decimal?  {
        return DefaultValueRegistry.defaultValue(for: (Decimal?).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


public class MockWalletLoggerProtocol: WalletLoggerProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletLoggerProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletLoggerProtocol
    public typealias Verification = __VerificationProxy_WalletLoggerProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletLoggerProtocol?

    public func enableDefaultImplementation(_ stub: WalletLoggerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func verbose(message: String, file: String, function: String, line: Int)  {
        
    return cuckoo_manager.call("verbose(message: String, file: String, function: String, line: Int)",
            parameters: (message, file, function, line),
            escapingParameters: (message, file, function, line),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.verbose(message: message, file: file, function: function, line: line))
        
    }
    
    
    
    public func debug(message: String, file: String, function: String, line: Int)  {
        
    return cuckoo_manager.call("debug(message: String, file: String, function: String, line: Int)",
            parameters: (message, file, function, line),
            escapingParameters: (message, file, function, line),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.debug(message: message, file: file, function: function, line: line))
        
    }
    
    
    
    public func info(message: String, file: String, function: String, line: Int)  {
        
    return cuckoo_manager.call("info(message: String, file: String, function: String, line: Int)",
            parameters: (message, file, function, line),
            escapingParameters: (message, file, function, line),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.info(message: message, file: file, function: function, line: line))
        
    }
    
    
    
    public func warning(message: String, file: String, function: String, line: Int)  {
        
    return cuckoo_manager.call("warning(message: String, file: String, function: String, line: Int)",
            parameters: (message, file, function, line),
            escapingParameters: (message, file, function, line),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.warning(message: message, file: file, function: function, line: line))
        
    }
    
    
    
    public func error(message: String, file: String, function: String, line: Int)  {
        
    return cuckoo_manager.call("error(message: String, file: String, function: String, line: Int)",
            parameters: (message, file, function, line),
            escapingParameters: (message, file, function, line),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.error(message: message, file: file, function: function, line: line))
        
    }
    

	public struct __StubbingProxy_WalletLoggerProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func verbose<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String, Int)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletLoggerProtocol.self, method: "verbose(message: String, file: String, function: String, line: Int)", parameterMatchers: matchers))
	    }
	    
	    func debug<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String, Int)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletLoggerProtocol.self, method: "debug(message: String, file: String, function: String, line: Int)", parameterMatchers: matchers))
	    }
	    
	    func info<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String, Int)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletLoggerProtocol.self, method: "info(message: String, file: String, function: String, line: Int)", parameterMatchers: matchers))
	    }
	    
	    func warning<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String, Int)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletLoggerProtocol.self, method: "warning(message: String, file: String, function: String, line: Int)", parameterMatchers: matchers))
	    }
	    
	    func error<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String, Int)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletLoggerProtocol.self, method: "error(message: String, file: String, function: String, line: Int)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletLoggerProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func verbose<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.__DoNotUse<(String, String, String, Int), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return cuckoo_manager.verify("verbose(message: String, file: String, function: String, line: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func debug<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.__DoNotUse<(String, String, String, Int), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return cuckoo_manager.verify("debug(message: String, file: String, function: String, line: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func info<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.__DoNotUse<(String, String, String, Int), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return cuckoo_manager.verify("info(message: String, file: String, function: String, line: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func warning<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.__DoNotUse<(String, String, String, Int), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return cuckoo_manager.verify("warning(message: String, file: String, function: String, line: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func error<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(message: M1, file: M2, function: M3, line: M4) -> Cuckoo.__DoNotUse<(String, String, String, Int), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String, Int)>] = [wrap(matchable: message) { $0.0 }, wrap(matchable: file) { $0.1 }, wrap(matchable: function) { $0.2 }, wrap(matchable: line) { $0.3 }]
	        return cuckoo_manager.verify("error(message: String, file: String, function: String, line: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletLoggerProtocolStub: WalletLoggerProtocol {
    

    

    
    public func verbose(message: String, file: String, function: String, line: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func debug(message: String, file: String, function: String, line: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func info(message: String, file: String, function: String, line: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func warning(message: String, file: String, function: String, line: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func error(message: String, file: String, function: String, line: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import IrohaCommunication
import SoraFoundation


 class MockResolverProtocol: ResolverProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ResolverProtocol
    
     typealias Stubbing = __StubbingProxy_ResolverProtocol
     typealias Verification = __VerificationProxy_ResolverProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ResolverProtocol?

     func enableDefaultImplementation(_ stub: ResolverProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var account: WalletAccountSettingsProtocol {
        get {
            return cuckoo_manager.getter("account",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.account)
        }
        
    }
    
    
    
     var networkOperationFactory: WalletNetworkOperationFactoryProtocol {
        get {
            return cuckoo_manager.getter("networkOperationFactory",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.networkOperationFactory)
        }
        
    }
    
    
    
     var eventCenter: WalletEventCenterProtocol {
        get {
            return cuckoo_manager.getter("eventCenter",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.eventCenter)
        }
        
    }
    
    
    
     var style: WalletStyleProtocol {
        get {
            return cuckoo_manager.getter("style",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.style)
        }
        
    }
    
    
    
     var accountListConfiguration: AccountListConfigurationProtocol {
        get {
            return cuckoo_manager.getter("accountListConfiguration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.accountListConfiguration)
        }
        
    }
    
    
    
     var historyConfiguration: HistoryConfigurationProtocol {
        get {
            return cuckoo_manager.getter("historyConfiguration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.historyConfiguration)
        }
        
    }
    
    
    
     var contactsConfiguration: ContactsConfigurationProtocol {
        get {
            return cuckoo_manager.getter("contactsConfiguration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.contactsConfiguration)
        }
        
    }
    
    
    
     var invoiceScanConfiguration: InvoiceScanConfigurationProtocol {
        get {
            return cuckoo_manager.getter("invoiceScanConfiguration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.invoiceScanConfiguration)
        }
        
    }
    
    
    
     var receiveConfiguration: ReceiveAmountConfigurationProtocol {
        get {
            return cuckoo_manager.getter("receiveConfiguration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.receiveConfiguration)
        }
        
    }
    
    
    
     var transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol {
        get {
            return cuckoo_manager.getter("transactionDetailsConfiguration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.transactionDetailsConfiguration)
        }
        
    }
    
    
    
     var navigation: NavigationProtocol? {
        get {
            return cuckoo_manager.getter("navigation",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.navigation)
        }
        
    }
    
    
    
     var logger: WalletLoggerProtocol? {
        get {
            return cuckoo_manager.getter("logger",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.logger)
        }
        
    }
    
    
    
     var localizationManager: LocalizationManagerProtocol? {
        get {
            return cuckoo_manager.getter("localizationManager",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.localizationManager)
        }
        
    }
    
    
    
     var amountFormatter: LocalizableResource<NumberFormatter> {
        get {
            return cuckoo_manager.getter("amountFormatter",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.amountFormatter)
        }
        
    }
    
    
    
     var statusDateFormatter: LocalizableResource<DateFormatter> {
        get {
            return cuckoo_manager.getter("statusDateFormatter",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.statusDateFormatter)
        }
        
    }
    
    
    
     var transferAmountLimit: Decimal {
        get {
            return cuckoo_manager.getter("transferAmountLimit",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.transferAmountLimit)
        }
        
    }
    
    
    
     var transactionTypeList: [WalletTransactionType] {
        get {
            return cuckoo_manager.getter("transactionTypeList",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.transactionTypeList)
        }
        
    }
    
    
    
     var commandFactory: WalletCommandFactoryProtocol {
        get {
            return cuckoo_manager.getter("commandFactory",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.commandFactory)
        }
        
    }
    
    
    
     var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol? {
        get {
            return cuckoo_manager.getter("commandDecoratorFactory",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.commandDecoratorFactory)
        }
        
    }
    
    
    
     var inputValidatorFactory: WalletInputValidatorFactoryProtocol {
        get {
            return cuckoo_manager.getter("inputValidatorFactory",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.inputValidatorFactory)
        }
        
    }
    
    
    
     var feeCalculationFactory: FeeCalculationFactoryProtocol {
        get {
            return cuckoo_manager.getter("feeCalculationFactory",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.feeCalculationFactory)
        }
        
    }
    
    
    
     var feeDisplayStrategy: FeeDisplayStrategyProtocol {
        get {
            return cuckoo_manager.getter("feeDisplayStrategy",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.feeDisplayStrategy)
        }
        
    }
    
    
    
     var qrCoderFactory: WalletQRCoderFactoryProtocol {
        get {
            return cuckoo_manager.getter("qrCoderFactory",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.qrCoderFactory)
        }
        
    }
    

    

    

	 struct __StubbingProxy_ResolverProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var account: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletAccountSettingsProtocol> {
	        return .init(manager: cuckoo_manager, name: "account")
	    }
	    
	    
	    var networkOperationFactory: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletNetworkOperationFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "networkOperationFactory")
	    }
	    
	    
	    var eventCenter: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletEventCenterProtocol> {
	        return .init(manager: cuckoo_manager, name: "eventCenter")
	    }
	    
	    
	    var style: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletStyleProtocol> {
	        return .init(manager: cuckoo_manager, name: "style")
	    }
	    
	    
	    var accountListConfiguration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, AccountListConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "accountListConfiguration")
	    }
	    
	    
	    var historyConfiguration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, HistoryConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "historyConfiguration")
	    }
	    
	    
	    var contactsConfiguration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, ContactsConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "contactsConfiguration")
	    }
	    
	    
	    var invoiceScanConfiguration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, InvoiceScanConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "invoiceScanConfiguration")
	    }
	    
	    
	    var receiveConfiguration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, ReceiveAmountConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "receiveConfiguration")
	    }
	    
	    
	    var transactionDetailsConfiguration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, TransactionDetailsConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "transactionDetailsConfiguration")
	    }
	    
	    
	    var navigation: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, NavigationProtocol?> {
	        return .init(manager: cuckoo_manager, name: "navigation")
	    }
	    
	    
	    var logger: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletLoggerProtocol?> {
	        return .init(manager: cuckoo_manager, name: "logger")
	    }
	    
	    
	    var localizationManager: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, LocalizationManagerProtocol?> {
	        return .init(manager: cuckoo_manager, name: "localizationManager")
	    }
	    
	    
	    var amountFormatter: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, LocalizableResource<NumberFormatter>> {
	        return .init(manager: cuckoo_manager, name: "amountFormatter")
	    }
	    
	    
	    var statusDateFormatter: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, LocalizableResource<DateFormatter>> {
	        return .init(manager: cuckoo_manager, name: "statusDateFormatter")
	    }
	    
	    
	    var transferAmountLimit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, Decimal> {
	        return .init(manager: cuckoo_manager, name: "transferAmountLimit")
	    }
	    
	    
	    var transactionTypeList: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, [WalletTransactionType]> {
	        return .init(manager: cuckoo_manager, name: "transactionTypeList")
	    }
	    
	    
	    var commandFactory: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletCommandFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "commandFactory")
	    }
	    
	    
	    var commandDecoratorFactory: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletCommandDecoratorFactoryProtocol?> {
	        return .init(manager: cuckoo_manager, name: "commandDecoratorFactory")
	    }
	    
	    
	    var inputValidatorFactory: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletInputValidatorFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "inputValidatorFactory")
	    }
	    
	    
	    var feeCalculationFactory: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, FeeCalculationFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "feeCalculationFactory")
	    }
	    
	    
	    var feeDisplayStrategy: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, FeeDisplayStrategyProtocol> {
	        return .init(manager: cuckoo_manager, name: "feeDisplayStrategy")
	    }
	    
	    
	    var qrCoderFactory: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletQRCoderFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "qrCoderFactory")
	    }
	    
	    
	}

	 struct __VerificationProxy_ResolverProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var account: Cuckoo.VerifyReadOnlyProperty<WalletAccountSettingsProtocol> {
	        return .init(manager: cuckoo_manager, name: "account", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var networkOperationFactory: Cuckoo.VerifyReadOnlyProperty<WalletNetworkOperationFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "networkOperationFactory", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var eventCenter: Cuckoo.VerifyReadOnlyProperty<WalletEventCenterProtocol> {
	        return .init(manager: cuckoo_manager, name: "eventCenter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var style: Cuckoo.VerifyReadOnlyProperty<WalletStyleProtocol> {
	        return .init(manager: cuckoo_manager, name: "style", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var accountListConfiguration: Cuckoo.VerifyReadOnlyProperty<AccountListConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "accountListConfiguration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var historyConfiguration: Cuckoo.VerifyReadOnlyProperty<HistoryConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "historyConfiguration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var contactsConfiguration: Cuckoo.VerifyReadOnlyProperty<ContactsConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "contactsConfiguration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var invoiceScanConfiguration: Cuckoo.VerifyReadOnlyProperty<InvoiceScanConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "invoiceScanConfiguration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var receiveConfiguration: Cuckoo.VerifyReadOnlyProperty<ReceiveAmountConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "receiveConfiguration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var transactionDetailsConfiguration: Cuckoo.VerifyReadOnlyProperty<TransactionDetailsConfigurationProtocol> {
	        return .init(manager: cuckoo_manager, name: "transactionDetailsConfiguration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var navigation: Cuckoo.VerifyReadOnlyProperty<NavigationProtocol?> {
	        return .init(manager: cuckoo_manager, name: "navigation", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var logger: Cuckoo.VerifyReadOnlyProperty<WalletLoggerProtocol?> {
	        return .init(manager: cuckoo_manager, name: "logger", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var localizationManager: Cuckoo.VerifyReadOnlyProperty<LocalizationManagerProtocol?> {
	        return .init(manager: cuckoo_manager, name: "localizationManager", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var amountFormatter: Cuckoo.VerifyReadOnlyProperty<LocalizableResource<NumberFormatter>> {
	        return .init(manager: cuckoo_manager, name: "amountFormatter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var statusDateFormatter: Cuckoo.VerifyReadOnlyProperty<LocalizableResource<DateFormatter>> {
	        return .init(manager: cuckoo_manager, name: "statusDateFormatter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var transferAmountLimit: Cuckoo.VerifyReadOnlyProperty<Decimal> {
	        return .init(manager: cuckoo_manager, name: "transferAmountLimit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var transactionTypeList: Cuckoo.VerifyReadOnlyProperty<[WalletTransactionType]> {
	        return .init(manager: cuckoo_manager, name: "transactionTypeList", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var commandFactory: Cuckoo.VerifyReadOnlyProperty<WalletCommandFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "commandFactory", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var commandDecoratorFactory: Cuckoo.VerifyReadOnlyProperty<WalletCommandDecoratorFactoryProtocol?> {
	        return .init(manager: cuckoo_manager, name: "commandDecoratorFactory", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var inputValidatorFactory: Cuckoo.VerifyReadOnlyProperty<WalletInputValidatorFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "inputValidatorFactory", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var feeCalculationFactory: Cuckoo.VerifyReadOnlyProperty<FeeCalculationFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "feeCalculationFactory", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var feeDisplayStrategy: Cuckoo.VerifyReadOnlyProperty<FeeDisplayStrategyProtocol> {
	        return .init(manager: cuckoo_manager, name: "feeDisplayStrategy", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var qrCoderFactory: Cuckoo.VerifyReadOnlyProperty<WalletQRCoderFactoryProtocol> {
	        return .init(manager: cuckoo_manager, name: "qrCoderFactory", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class ResolverProtocolStub: ResolverProtocol {
    
    
     var account: WalletAccountSettingsProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletAccountSettingsProtocol).self)
        }
        
    }
    
    
     var networkOperationFactory: WalletNetworkOperationFactoryProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletNetworkOperationFactoryProtocol).self)
        }
        
    }
    
    
     var eventCenter: WalletEventCenterProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletEventCenterProtocol).self)
        }
        
    }
    
    
     var style: WalletStyleProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletStyleProtocol).self)
        }
        
    }
    
    
     var accountListConfiguration: AccountListConfigurationProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (AccountListConfigurationProtocol).self)
        }
        
    }
    
    
     var historyConfiguration: HistoryConfigurationProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (HistoryConfigurationProtocol).self)
        }
        
    }
    
    
     var contactsConfiguration: ContactsConfigurationProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ContactsConfigurationProtocol).self)
        }
        
    }
    
    
     var invoiceScanConfiguration: InvoiceScanConfigurationProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (InvoiceScanConfigurationProtocol).self)
        }
        
    }
    
    
     var receiveConfiguration: ReceiveAmountConfigurationProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ReceiveAmountConfigurationProtocol).self)
        }
        
    }
    
    
     var transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (TransactionDetailsConfigurationProtocol).self)
        }
        
    }
    
    
     var navigation: NavigationProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (NavigationProtocol?).self)
        }
        
    }
    
    
     var logger: WalletLoggerProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletLoggerProtocol?).self)
        }
        
    }
    
    
     var localizationManager: LocalizationManagerProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (LocalizationManagerProtocol?).self)
        }
        
    }
    
    
     var amountFormatter: LocalizableResource<NumberFormatter> {
        get {
            return DefaultValueRegistry.defaultValue(for: (LocalizableResource<NumberFormatter>).self)
        }
        
    }
    
    
     var statusDateFormatter: LocalizableResource<DateFormatter> {
        get {
            return DefaultValueRegistry.defaultValue(for: (LocalizableResource<DateFormatter>).self)
        }
        
    }
    
    
     var transferAmountLimit: Decimal {
        get {
            return DefaultValueRegistry.defaultValue(for: (Decimal).self)
        }
        
    }
    
    
     var transactionTypeList: [WalletTransactionType] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([WalletTransactionType]).self)
        }
        
    }
    
    
     var commandFactory: WalletCommandFactoryProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletCommandFactoryProtocol).self)
        }
        
    }
    
    
     var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletCommandDecoratorFactoryProtocol?).self)
        }
        
    }
    
    
     var inputValidatorFactory: WalletInputValidatorFactoryProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletInputValidatorFactoryProtocol).self)
        }
        
    }
    
    
     var feeCalculationFactory: FeeCalculationFactoryProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (FeeCalculationFactoryProtocol).self)
        }
        
    }
    
    
     var feeDisplayStrategy: FeeDisplayStrategyProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (FeeDisplayStrategyProtocol).self)
        }
        
    }
    
    
     var qrCoderFactory: WalletQRCoderFactoryProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletQRCoderFactoryProtocol).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import IrohaCommunication
import RobinHood


public class MockWalletNetworkOperationFactoryProtocol: WalletNetworkOperationFactoryProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletNetworkOperationFactoryProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletNetworkOperationFactoryProtocol
    public typealias Verification = __VerificationProxy_WalletNetworkOperationFactoryProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletNetworkOperationFactoryProtocol?

    public func enableDefaultImplementation(_ stub: WalletNetworkOperationFactoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func fetchBalanceOperation(_ assets: [IRAssetId]) -> BaseOperation<[BalanceData]?> {
        
    return cuckoo_manager.call("fetchBalanceOperation(_: [IRAssetId]) -> BaseOperation<[BalanceData]?>",
            parameters: (assets),
            escapingParameters: (assets),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.fetchBalanceOperation(assets))
        
    }
    
    
    
    public func fetchTransactionHistoryOperation(_ filter: WalletHistoryRequest, pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?> {
        
    return cuckoo_manager.call("fetchTransactionHistoryOperation(_: WalletHistoryRequest, pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?>",
            parameters: (filter, pagination),
            escapingParameters: (filter, pagination),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.fetchTransactionHistoryOperation(filter, pagination: pagination))
        
    }
    
    
    
    public func transferMetadataOperation(_ assetId: IRAssetId) -> BaseOperation<TransferMetaData?> {
        
    return cuckoo_manager.call("transferMetadataOperation(_: IRAssetId) -> BaseOperation<TransferMetaData?>",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.transferMetadataOperation(assetId))
        
    }
    
    
    
    public func transferOperation(_ info: TransferInfo) -> BaseOperation<Void> {
        
    return cuckoo_manager.call("transferOperation(_: TransferInfo) -> BaseOperation<Void>",
            parameters: (info),
            escapingParameters: (info),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.transferOperation(info))
        
    }
    
    
    
    public func searchOperation(_ searchString: String) -> BaseOperation<[SearchData]?> {
        
    return cuckoo_manager.call("searchOperation(_: String) -> BaseOperation<[SearchData]?>",
            parameters: (searchString),
            escapingParameters: (searchString),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.searchOperation(searchString))
        
    }
    
    
    
    public func contactsOperation() -> BaseOperation<[SearchData]?> {
        
    return cuckoo_manager.call("contactsOperation() -> BaseOperation<[SearchData]?>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.contactsOperation())
        
    }
    
    
    
    public func withdrawalMetadataOperation(_ info: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?> {
        
    return cuckoo_manager.call("withdrawalMetadataOperation(_: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?>",
            parameters: (info),
            escapingParameters: (info),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.withdrawalMetadataOperation(info))
        
    }
    
    
    
    public func withdrawOperation(_ info: WithdrawInfo) -> BaseOperation<Void> {
        
    return cuckoo_manager.call("withdrawOperation(_: WithdrawInfo) -> BaseOperation<Void>",
            parameters: (info),
            escapingParameters: (info),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.withdrawOperation(info))
        
    }
    

	public struct __StubbingProxy_WalletNetworkOperationFactoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func fetchBalanceOperation<M1: Cuckoo.Matchable>(_ assets: M1) -> Cuckoo.ProtocolStubFunction<([IRAssetId]), BaseOperation<[BalanceData]?>> where M1.MatchedType == [IRAssetId] {
	        let matchers: [Cuckoo.ParameterMatcher<([IRAssetId])>] = [wrap(matchable: assets) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "fetchBalanceOperation(_: [IRAssetId]) -> BaseOperation<[BalanceData]?>", parameterMatchers: matchers))
	    }
	    
	    func fetchTransactionHistoryOperation<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ filter: M1, pagination: M2) -> Cuckoo.ProtocolStubFunction<(WalletHistoryRequest, OffsetPagination), BaseOperation<AssetTransactionPageData?>> where M1.MatchedType == WalletHistoryRequest, M2.MatchedType == OffsetPagination {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHistoryRequest, OffsetPagination)>] = [wrap(matchable: filter) { $0.0 }, wrap(matchable: pagination) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "fetchTransactionHistoryOperation(_: WalletHistoryRequest, pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?>", parameterMatchers: matchers))
	    }
	    
	    func transferMetadataOperation<M1: Cuckoo.Matchable>(_ assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId), BaseOperation<TransferMetaData?>> where M1.MatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "transferMetadataOperation(_: IRAssetId) -> BaseOperation<TransferMetaData?>", parameterMatchers: matchers))
	    }
	    
	    func transferOperation<M1: Cuckoo.Matchable>(_ info: M1) -> Cuckoo.ProtocolStubFunction<(TransferInfo), BaseOperation<Void>> where M1.MatchedType == TransferInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferInfo)>] = [wrap(matchable: info) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "transferOperation(_: TransferInfo) -> BaseOperation<Void>", parameterMatchers: matchers))
	    }
	    
	    func searchOperation<M1: Cuckoo.Matchable>(_ searchString: M1) -> Cuckoo.ProtocolStubFunction<(String), BaseOperation<[SearchData]?>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: searchString) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "searchOperation(_: String) -> BaseOperation<[SearchData]?>", parameterMatchers: matchers))
	    }
	    
	    func contactsOperation() -> Cuckoo.ProtocolStubFunction<(), BaseOperation<[SearchData]?>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "contactsOperation() -> BaseOperation<[SearchData]?>", parameterMatchers: matchers))
	    }
	    
	    func withdrawalMetadataOperation<M1: Cuckoo.Matchable>(_ info: M1) -> Cuckoo.ProtocolStubFunction<(WithdrawMetadataInfo), BaseOperation<WithdrawMetaData?>> where M1.MatchedType == WithdrawMetadataInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawMetadataInfo)>] = [wrap(matchable: info) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "withdrawalMetadataOperation(_: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?>", parameterMatchers: matchers))
	    }
	    
	    func withdrawOperation<M1: Cuckoo.Matchable>(_ info: M1) -> Cuckoo.ProtocolStubFunction<(WithdrawInfo), BaseOperation<Void>> where M1.MatchedType == WithdrawInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawInfo)>] = [wrap(matchable: info) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkOperationFactoryProtocol.self, method: "withdrawOperation(_: WithdrawInfo) -> BaseOperation<Void>", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletNetworkOperationFactoryProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func fetchBalanceOperation<M1: Cuckoo.Matchable>(_ assets: M1) -> Cuckoo.__DoNotUse<([IRAssetId]), BaseOperation<[BalanceData]?>> where M1.MatchedType == [IRAssetId] {
	        let matchers: [Cuckoo.ParameterMatcher<([IRAssetId])>] = [wrap(matchable: assets) { $0 }]
	        return cuckoo_manager.verify("fetchBalanceOperation(_: [IRAssetId]) -> BaseOperation<[BalanceData]?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func fetchTransactionHistoryOperation<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ filter: M1, pagination: M2) -> Cuckoo.__DoNotUse<(WalletHistoryRequest, OffsetPagination), BaseOperation<AssetTransactionPageData?>> where M1.MatchedType == WalletHistoryRequest, M2.MatchedType == OffsetPagination {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHistoryRequest, OffsetPagination)>] = [wrap(matchable: filter) { $0.0 }, wrap(matchable: pagination) { $0.1 }]
	        return cuckoo_manager.verify("fetchTransactionHistoryOperation(_: WalletHistoryRequest, pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func transferMetadataOperation<M1: Cuckoo.Matchable>(_ assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId), BaseOperation<TransferMetaData?>> where M1.MatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("transferMetadataOperation(_: IRAssetId) -> BaseOperation<TransferMetaData?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func transferOperation<M1: Cuckoo.Matchable>(_ info: M1) -> Cuckoo.__DoNotUse<(TransferInfo), BaseOperation<Void>> where M1.MatchedType == TransferInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(TransferInfo)>] = [wrap(matchable: info) { $0 }]
	        return cuckoo_manager.verify("transferOperation(_: TransferInfo) -> BaseOperation<Void>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func searchOperation<M1: Cuckoo.Matchable>(_ searchString: M1) -> Cuckoo.__DoNotUse<(String), BaseOperation<[SearchData]?>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: searchString) { $0 }]
	        return cuckoo_manager.verify("searchOperation(_: String) -> BaseOperation<[SearchData]?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func contactsOperation() -> Cuckoo.__DoNotUse<(), BaseOperation<[SearchData]?>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("contactsOperation() -> BaseOperation<[SearchData]?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func withdrawalMetadataOperation<M1: Cuckoo.Matchable>(_ info: M1) -> Cuckoo.__DoNotUse<(WithdrawMetadataInfo), BaseOperation<WithdrawMetaData?>> where M1.MatchedType == WithdrawMetadataInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawMetadataInfo)>] = [wrap(matchable: info) { $0 }]
	        return cuckoo_manager.verify("withdrawalMetadataOperation(_: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func withdrawOperation<M1: Cuckoo.Matchable>(_ info: M1) -> Cuckoo.__DoNotUse<(WithdrawInfo), BaseOperation<Void>> where M1.MatchedType == WithdrawInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(WithdrawInfo)>] = [wrap(matchable: info) { $0 }]
	        return cuckoo_manager.verify("withdrawOperation(_: WithdrawInfo) -> BaseOperation<Void>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletNetworkOperationFactoryProtocolStub: WalletNetworkOperationFactoryProtocol {
    

    

    
    public func fetchBalanceOperation(_ assets: [IRAssetId]) -> BaseOperation<[BalanceData]?>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<[BalanceData]?>).self)
    }
    
    public func fetchTransactionHistoryOperation(_ filter: WalletHistoryRequest, pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<AssetTransactionPageData?>).self)
    }
    
    public func transferMetadataOperation(_ assetId: IRAssetId) -> BaseOperation<TransferMetaData?>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<TransferMetaData?>).self)
    }
    
    public func transferOperation(_ info: TransferInfo) -> BaseOperation<Void>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<Void>).self)
    }
    
    public func searchOperation(_ searchString: String) -> BaseOperation<[SearchData]?>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<[SearchData]?>).self)
    }
    
    public func contactsOperation() -> BaseOperation<[SearchData]?>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<[SearchData]?>).self)
    }
    
    public func withdrawalMetadataOperation(_ info: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<WithdrawMetaData?>).self)
    }
    
    public func withdrawOperation(_ info: WithdrawInfo) -> BaseOperation<Void>  {
        return DefaultValueRegistry.defaultValue(for: (BaseOperation<Void>).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import RobinHood


public class MockWalletNetworkResolverProtocol: WalletNetworkResolverProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletNetworkResolverProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletNetworkResolverProtocol
    public typealias Verification = __VerificationProxy_WalletNetworkResolverProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletNetworkResolverProtocol?

    public func enableDefaultImplementation(_ stub: WalletNetworkResolverProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func urlTemplate(for type: WalletRequestType) -> String {
        
    return cuckoo_manager.call("urlTemplate(for: WalletRequestType) -> String",
            parameters: (type),
            escapingParameters: (type),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.urlTemplate(for: type))
        
    }
    
    
    
    public func adapter(for type: WalletRequestType) -> NetworkRequestModifierProtocol? {
        
    return cuckoo_manager.call("adapter(for: WalletRequestType) -> NetworkRequestModifierProtocol?",
            parameters: (type),
            escapingParameters: (type),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.adapter(for: type))
        
    }
    

	public struct __StubbingProxy_WalletNetworkResolverProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func urlTemplate<M1: Cuckoo.Matchable>(for type: M1) -> Cuckoo.ProtocolStubFunction<(WalletRequestType), String> where M1.MatchedType == WalletRequestType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletRequestType)>] = [wrap(matchable: type) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkResolverProtocol.self, method: "urlTemplate(for: WalletRequestType) -> String", parameterMatchers: matchers))
	    }
	    
	    func adapter<M1: Cuckoo.Matchable>(for type: M1) -> Cuckoo.ProtocolStubFunction<(WalletRequestType), NetworkRequestModifierProtocol?> where M1.MatchedType == WalletRequestType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletRequestType)>] = [wrap(matchable: type) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletNetworkResolverProtocol.self, method: "adapter(for: WalletRequestType) -> NetworkRequestModifierProtocol?", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletNetworkResolverProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func urlTemplate<M1: Cuckoo.Matchable>(for type: M1) -> Cuckoo.__DoNotUse<(WalletRequestType), String> where M1.MatchedType == WalletRequestType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletRequestType)>] = [wrap(matchable: type) { $0 }]
	        return cuckoo_manager.verify("urlTemplate(for: WalletRequestType) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func adapter<M1: Cuckoo.Matchable>(for type: M1) -> Cuckoo.__DoNotUse<(WalletRequestType), NetworkRequestModifierProtocol?> where M1.MatchedType == WalletRequestType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletRequestType)>] = [wrap(matchable: type) { $0 }]
	        return cuckoo_manager.verify("adapter(for: WalletRequestType) -> NetworkRequestModifierProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletNetworkResolverProtocolStub: WalletNetworkResolverProtocol {
    

    

    
    public func urlTemplate(for type: WalletRequestType) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    public func adapter(for type: WalletRequestType) -> NetworkRequestModifierProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (NetworkRequestModifierProtocol?).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import AVFoundation
import Foundation


 class MockWalletQRMatcherProtocol: WalletQRMatcherProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletQRMatcherProtocol
    
     typealias Stubbing = __StubbingProxy_WalletQRMatcherProtocol
     typealias Verification = __VerificationProxy_WalletQRMatcherProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQRMatcherProtocol?

     func enableDefaultImplementation(_ stub: WalletQRMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func match(code: String) -> Bool {
        
    return cuckoo_manager.call("match(code: String) -> Bool",
            parameters: (code),
            escapingParameters: (code),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.match(code: code))
        
    }
    

	 struct __StubbingProxy_WalletQRMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func match<M1: Cuckoo.Matchable>(code: M1) -> Cuckoo.ProtocolStubFunction<(String), Bool> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: code) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRMatcherProtocol.self, method: "match(code: String) -> Bool", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletQRMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func match<M1: Cuckoo.Matchable>(code: M1) -> Cuckoo.__DoNotUse<(String), Bool> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: code) { $0 }]
	        return cuckoo_manager.verify("match(code: String) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletQRMatcherProtocolStub: WalletQRMatcherProtocol {
    

    

    
     func match(code: String) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
}



 class MockWalletQRCaptureServiceProtocol: WalletQRCaptureServiceProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletQRCaptureServiceProtocol
    
     typealias Stubbing = __StubbingProxy_WalletQRCaptureServiceProtocol
     typealias Verification = __VerificationProxy_WalletQRCaptureServiceProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQRCaptureServiceProtocol?

     func enableDefaultImplementation(_ stub: WalletQRCaptureServiceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var delegate: WalletQRCaptureServiceDelegate? {
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
    
    
    
     var delegateQueue: DispatchQueue {
        get {
            return cuckoo_manager.getter("delegateQueue",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegateQueue)
        }
        
        set {
            cuckoo_manager.setter("delegateQueue",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delegateQueue = newValue)
        }
        
    }
    

    

    
    
    
     func start()  {
        
    return cuckoo_manager.call("start()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
     func stop()  {
        
    return cuckoo_manager.call("stop()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }
    

	 struct __StubbingProxy_WalletQRCaptureServiceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var delegate: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockWalletQRCaptureServiceProtocol, WalletQRCaptureServiceDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    var delegateQueue: Cuckoo.ProtocolToBeStubbedProperty<MockWalletQRCaptureServiceProtocol, DispatchQueue> {
	        return .init(manager: cuckoo_manager, name: "delegateQueue")
	    }
	    
	    
	    func start() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceProtocol.self, method: "start()", parameterMatchers: matchers))
	    }
	    
	    func stop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceProtocol.self, method: "stop()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletQRCaptureServiceProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var delegate: Cuckoo.VerifyOptionalProperty<WalletQRCaptureServiceDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var delegateQueue: Cuckoo.VerifyProperty<DispatchQueue> {
	        return .init(manager: cuckoo_manager, name: "delegateQueue", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func start() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("start()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func stop() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("stop()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletQRCaptureServiceProtocolStub: WalletQRCaptureServiceProtocol {
    
    
     var delegate: WalletQRCaptureServiceDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletQRCaptureServiceDelegate?).self)
        }
        
        set { }
        
    }
    
    
     var delegateQueue: DispatchQueue {
        get {
            return DefaultValueRegistry.defaultValue(for: (DispatchQueue).self)
        }
        
        set { }
        
    }
    

    

    
     func start()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func stop()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockWalletQRCaptureServiceFactoryProtocol: WalletQRCaptureServiceFactoryProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletQRCaptureServiceFactoryProtocol
    
     typealias Stubbing = __StubbingProxy_WalletQRCaptureServiceFactoryProtocol
     typealias Verification = __VerificationProxy_WalletQRCaptureServiceFactoryProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQRCaptureServiceFactoryProtocol?

     func enableDefaultImplementation(_ stub: WalletQRCaptureServiceFactoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func createService(with matcher: WalletQRMatcherProtocol, delegate: WalletQRCaptureServiceDelegate?, delegateQueue: DispatchQueue?) -> WalletQRCaptureServiceProtocol {
        
    return cuckoo_manager.call("createService(with: WalletQRMatcherProtocol, delegate: WalletQRCaptureServiceDelegate?, delegateQueue: DispatchQueue?) -> WalletQRCaptureServiceProtocol",
            parameters: (matcher, delegate, delegateQueue),
            escapingParameters: (matcher, delegate, delegateQueue),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.createService(with: matcher, delegate: delegate, delegateQueue: delegateQueue))
        
    }
    

	 struct __StubbingProxy_WalletQRCaptureServiceFactoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func createService<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(with matcher: M1, delegate: M2, delegateQueue: M3) -> Cuckoo.ProtocolStubFunction<(WalletQRMatcherProtocol, WalletQRCaptureServiceDelegate?, DispatchQueue?), WalletQRCaptureServiceProtocol> where M1.MatchedType == WalletQRMatcherProtocol, M2.OptionalMatchedType == WalletQRCaptureServiceDelegate, M3.OptionalMatchedType == DispatchQueue {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRMatcherProtocol, WalletQRCaptureServiceDelegate?, DispatchQueue?)>] = [wrap(matchable: matcher) { $0.0 }, wrap(matchable: delegate) { $0.1 }, wrap(matchable: delegateQueue) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceFactoryProtocol.self, method: "createService(with: WalletQRMatcherProtocol, delegate: WalletQRCaptureServiceDelegate?, delegateQueue: DispatchQueue?) -> WalletQRCaptureServiceProtocol", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletQRCaptureServiceFactoryProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func createService<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(with matcher: M1, delegate: M2, delegateQueue: M3) -> Cuckoo.__DoNotUse<(WalletQRMatcherProtocol, WalletQRCaptureServiceDelegate?, DispatchQueue?), WalletQRCaptureServiceProtocol> where M1.MatchedType == WalletQRMatcherProtocol, M2.OptionalMatchedType == WalletQRCaptureServiceDelegate, M3.OptionalMatchedType == DispatchQueue {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRMatcherProtocol, WalletQRCaptureServiceDelegate?, DispatchQueue?)>] = [wrap(matchable: matcher) { $0.0 }, wrap(matchable: delegate) { $0.1 }, wrap(matchable: delegateQueue) { $0.2 }]
	        return cuckoo_manager.verify("createService(with: WalletQRMatcherProtocol, delegate: WalletQRCaptureServiceDelegate?, delegateQueue: DispatchQueue?) -> WalletQRCaptureServiceProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletQRCaptureServiceFactoryProtocolStub: WalletQRCaptureServiceFactoryProtocol {
    

    

    
     func createService(with matcher: WalletQRMatcherProtocol, delegate: WalletQRCaptureServiceDelegate?, delegateQueue: DispatchQueue?) -> WalletQRCaptureServiceProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletQRCaptureServiceProtocol).self)
    }
    
}



 class MockWalletQRCaptureServiceDelegate: WalletQRCaptureServiceDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = WalletQRCaptureServiceDelegate
    
     typealias Stubbing = __StubbingProxy_WalletQRCaptureServiceDelegate
     typealias Verification = __VerificationProxy_WalletQRCaptureServiceDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQRCaptureServiceDelegate?

     func enableDefaultImplementation(_ stub: WalletQRCaptureServiceDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didSetup captureSession: AVCaptureSession)  {
        
    return cuckoo_manager.call("qrCapture(service: WalletQRCaptureServiceProtocol, didSetup: AVCaptureSession)",
            parameters: (service, captureSession),
            escapingParameters: (service, captureSession),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.qrCapture(service: service, didSetup: captureSession))
        
    }
    
    
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didMatch code: String)  {
        
    return cuckoo_manager.call("qrCapture(service: WalletQRCaptureServiceProtocol, didMatch: String)",
            parameters: (service, code),
            escapingParameters: (service, code),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.qrCapture(service: service, didMatch: code))
        
    }
    
    
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didFailMatching code: String)  {
        
    return cuckoo_manager.call("qrCapture(service: WalletQRCaptureServiceProtocol, didFailMatching: String)",
            parameters: (service, code),
            escapingParameters: (service, code),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.qrCapture(service: service, didFailMatching: code))
        
    }
    
    
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didReceive error: Error)  {
        
    return cuckoo_manager.call("qrCapture(service: WalletQRCaptureServiceProtocol, didReceive: Error)",
            parameters: (service, error),
            escapingParameters: (service, error),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.qrCapture(service: service, didReceive: error))
        
    }
    

	 struct __StubbingProxy_WalletQRCaptureServiceDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didSetup captureSession: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletQRCaptureServiceProtocol, AVCaptureSession)> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == AVCaptureSession {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, AVCaptureSession)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: captureSession) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceDelegate.self, method: "qrCapture(service: WalletQRCaptureServiceProtocol, didSetup: AVCaptureSession)", parameterMatchers: matchers))
	    }
	    
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didMatch code: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletQRCaptureServiceProtocol, String)> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, String)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: code) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceDelegate.self, method: "qrCapture(service: WalletQRCaptureServiceProtocol, didMatch: String)", parameterMatchers: matchers))
	    }
	    
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didFailMatching code: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletQRCaptureServiceProtocol, String)> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, String)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: code) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceDelegate.self, method: "qrCapture(service: WalletQRCaptureServiceProtocol, didFailMatching: String)", parameterMatchers: matchers))
	    }
	    
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didReceive error: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(WalletQRCaptureServiceProtocol, Error)> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, Error)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: error) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCaptureServiceDelegate.self, method: "qrCapture(service: WalletQRCaptureServiceProtocol, didReceive: Error)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WalletQRCaptureServiceDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didSetup captureSession: M2) -> Cuckoo.__DoNotUse<(WalletQRCaptureServiceProtocol, AVCaptureSession), Void> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == AVCaptureSession {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, AVCaptureSession)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: captureSession) { $0.1 }]
	        return cuckoo_manager.verify("qrCapture(service: WalletQRCaptureServiceProtocol, didSetup: AVCaptureSession)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didMatch code: M2) -> Cuckoo.__DoNotUse<(WalletQRCaptureServiceProtocol, String), Void> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, String)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: code) { $0.1 }]
	        return cuckoo_manager.verify("qrCapture(service: WalletQRCaptureServiceProtocol, didMatch: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didFailMatching code: M2) -> Cuckoo.__DoNotUse<(WalletQRCaptureServiceProtocol, String), Void> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, String)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: code) { $0.1 }]
	        return cuckoo_manager.verify("qrCapture(service: WalletQRCaptureServiceProtocol, didFailMatching: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func qrCapture<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(service: M1, didReceive error: M2) -> Cuckoo.__DoNotUse<(WalletQRCaptureServiceProtocol, Error), Void> where M1.MatchedType == WalletQRCaptureServiceProtocol, M2.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletQRCaptureServiceProtocol, Error)>] = [wrap(matchable: service) { $0.0 }, wrap(matchable: error) { $0.1 }]
	        return cuckoo_manager.verify("qrCapture(service: WalletQRCaptureServiceProtocol, didReceive: Error)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WalletQRCaptureServiceDelegateStub: WalletQRCaptureServiceDelegate {
    

    

    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didSetup captureSession: AVCaptureSession)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didMatch code: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didFailMatching code: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func qrCapture(service: WalletQRCaptureServiceProtocol, didReceive error: Error)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


public class MockWalletQREncoderProtocol: WalletQREncoderProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletQREncoderProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletQREncoderProtocol
    public typealias Verification = __VerificationProxy_WalletQREncoderProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQREncoderProtocol?

    public func enableDefaultImplementation(_ stub: WalletQREncoderProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func encode(receiverInfo: ReceiveInfo) throws -> Data {
        
    return try cuckoo_manager.callThrows("encode(receiverInfo: ReceiveInfo) throws -> Data",
            parameters: (receiverInfo),
            escapingParameters: (receiverInfo),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.encode(receiverInfo: receiverInfo))
        
    }
    

	public struct __StubbingProxy_WalletQREncoderProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func encode<M1: Cuckoo.Matchable>(receiverInfo: M1) -> Cuckoo.ProtocolStubThrowingFunction<(ReceiveInfo), Data> where M1.MatchedType == ReceiveInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(ReceiveInfo)>] = [wrap(matchable: receiverInfo) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQREncoderProtocol.self, method: "encode(receiverInfo: ReceiveInfo) throws -> Data", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletQREncoderProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func encode<M1: Cuckoo.Matchable>(receiverInfo: M1) -> Cuckoo.__DoNotUse<(ReceiveInfo), Data> where M1.MatchedType == ReceiveInfo {
	        let matchers: [Cuckoo.ParameterMatcher<(ReceiveInfo)>] = [wrap(matchable: receiverInfo) { $0 }]
	        return cuckoo_manager.verify("encode(receiverInfo: ReceiveInfo) throws -> Data", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletQREncoderProtocolStub: WalletQREncoderProtocol {
    

    

    
    public func encode(receiverInfo: ReceiveInfo) throws -> Data  {
        return DefaultValueRegistry.defaultValue(for: (Data).self)
    }
    
}



public class MockWalletQRDecoderProtocol: WalletQRDecoderProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletQRDecoderProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletQRDecoderProtocol
    public typealias Verification = __VerificationProxy_WalletQRDecoderProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQRDecoderProtocol?

    public func enableDefaultImplementation(_ stub: WalletQRDecoderProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func decode(data: Data) throws -> ReceiveInfo {
        
    return try cuckoo_manager.callThrows("decode(data: Data) throws -> ReceiveInfo",
            parameters: (data),
            escapingParameters: (data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.decode(data: data))
        
    }
    

	public struct __StubbingProxy_WalletQRDecoderProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func decode<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ProtocolStubThrowingFunction<(Data), ReceiveInfo> where M1.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Data)>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRDecoderProtocol.self, method: "decode(data: Data) throws -> ReceiveInfo", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletQRDecoderProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func decode<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<(Data), ReceiveInfo> where M1.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Data)>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("decode(data: Data) throws -> ReceiveInfo", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletQRDecoderProtocolStub: WalletQRDecoderProtocol {
    

    

    
    public func decode(data: Data) throws -> ReceiveInfo  {
        return DefaultValueRegistry.defaultValue(for: (ReceiveInfo).self)
    }
    
}



public class MockWalletQRCoderFactoryProtocol: WalletQRCoderFactoryProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletQRCoderFactoryProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletQRCoderFactoryProtocol
    public typealias Verification = __VerificationProxy_WalletQRCoderFactoryProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletQRCoderFactoryProtocol?

    public func enableDefaultImplementation(_ stub: WalletQRCoderFactoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func createEncoder() -> WalletQREncoderProtocol {
        
    return cuckoo_manager.call("createEncoder() -> WalletQREncoderProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.createEncoder())
        
    }
    
    
    
    public func createDecoder() -> WalletQRDecoderProtocol {
        
    return cuckoo_manager.call("createDecoder() -> WalletQRDecoderProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.createDecoder())
        
    }
    

	public struct __StubbingProxy_WalletQRCoderFactoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func createEncoder() -> Cuckoo.ProtocolStubFunction<(), WalletQREncoderProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCoderFactoryProtocol.self, method: "createEncoder() -> WalletQREncoderProtocol", parameterMatchers: matchers))
	    }
	    
	    func createDecoder() -> Cuckoo.ProtocolStubFunction<(), WalletQRDecoderProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletQRCoderFactoryProtocol.self, method: "createDecoder() -> WalletQRDecoderProtocol", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletQRCoderFactoryProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func createEncoder() -> Cuckoo.__DoNotUse<(), WalletQREncoderProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("createEncoder() -> WalletQREncoderProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func createDecoder() -> Cuckoo.__DoNotUse<(), WalletQRDecoderProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("createDecoder() -> WalletQRDecoderProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletQRCoderFactoryProtocolStub: WalletQRCoderFactoryProtocol {
    

    

    
    public func createEncoder() -> WalletQREncoderProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletQREncoderProtocol).self)
    }
    
    public func createDecoder() -> WalletQRDecoderProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletQRDecoderProtocol).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import IrohaCommunication


public class MockWalletCommandFactoryProtocol: WalletCommandFactoryProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = WalletCommandFactoryProtocol
    
    public typealias Stubbing = __StubbingProxy_WalletCommandFactoryProtocol
    public typealias Verification = __VerificationProxy_WalletCommandFactoryProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WalletCommandFactoryProtocol?

    public func enableDefaultImplementation(_ stub: WalletCommandFactoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func prepareSendCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareSendCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareSendCommand(for: assetId))
        
    }
    
    
    
    public func prepareReceiveCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareReceiveCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareReceiveCommand(for: assetId))
        
    }
    
    
    
    public func prepareAssetDetailsCommand(for assetId: IRAssetId) -> AssetDetailsCommadProtocol {
        
    return cuckoo_manager.call("prepareAssetDetailsCommand(for: IRAssetId) -> AssetDetailsCommadProtocol",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareAssetDetailsCommand(for: assetId))
        
    }
    
    
    
    public func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareScanReceiverCommand() -> WalletPresentationCommandProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareScanReceiverCommand())
        
    }
    
    
    
    public func prepareWithdrawCommand(for assetId: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareWithdrawCommand(for: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol",
            parameters: (assetId, optionId),
            escapingParameters: (assetId, optionId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareWithdrawCommand(for: assetId, optionId: optionId))
        
    }
    
    
    
    public func preparePresentationCommand(for controller: UIViewController) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("preparePresentationCommand(for: UIViewController) -> WalletPresentationCommandProtocol",
            parameters: (controller),
            escapingParameters: (controller),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.preparePresentationCommand(for: controller))
        
    }
    
    
    
    public func prepareHideCommand(with actionType: WalletHideActionType) -> WalletHideCommandProtocol {
        
    return cuckoo_manager.call("prepareHideCommand(with: WalletHideActionType) -> WalletHideCommandProtocol",
            parameters: (actionType),
            escapingParameters: (actionType),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareHideCommand(with: actionType))
        
    }
    
    
    
    public func prepareAccountUpdateCommand() -> WalletCommandProtocol {
        
    return cuckoo_manager.call("prepareAccountUpdateCommand() -> WalletCommandProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareAccountUpdateCommand())
        
    }
    
    
    
    public func prepareLanguageSwitchCommand(with newLanguage: WalletLanguage) -> WalletCommandProtocol {
        
    return cuckoo_manager.call("prepareLanguageSwitchCommand(with: WalletLanguage) -> WalletCommandProtocol",
            parameters: (newLanguage),
            escapingParameters: (newLanguage),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareLanguageSwitchCommand(with: newLanguage))
        
    }
    

	public struct __StubbingProxy_WalletCommandFactoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func prepareSendCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareSendCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareReceiveCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareReceiveCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareAssetDetailsCommand<M1: Cuckoo.Matchable>(for assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId), AssetDetailsCommadProtocol> where M1.MatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareAssetDetailsCommand(for: IRAssetId) -> AssetDetailsCommadProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareScanReceiverCommand() -> Cuckoo.ProtocolStubFunction<(), WalletPresentationCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareScanReceiverCommand() -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareWithdrawCommand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(for assetId: M1, optionId: M2) -> Cuckoo.ProtocolStubFunction<(IRAssetId, String), WalletPresentationCommandProtocol> where M1.MatchedType == IRAssetId, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId, String)>] = [wrap(matchable: assetId) { $0.0 }, wrap(matchable: optionId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareWithdrawCommand(for: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func preparePresentationCommand<M1: Cuckoo.Matchable>(for controller: M1) -> Cuckoo.ProtocolStubFunction<(UIViewController), WalletPresentationCommandProtocol> where M1.MatchedType == UIViewController {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: controller) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "preparePresentationCommand(for: UIViewController) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareHideCommand<M1: Cuckoo.Matchable>(with actionType: M1) -> Cuckoo.ProtocolStubFunction<(WalletHideActionType), WalletHideCommandProtocol> where M1.MatchedType == WalletHideActionType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHideActionType)>] = [wrap(matchable: actionType) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareHideCommand(with: WalletHideActionType) -> WalletHideCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareAccountUpdateCommand() -> Cuckoo.ProtocolStubFunction<(), WalletCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareAccountUpdateCommand() -> WalletCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareLanguageSwitchCommand<M1: Cuckoo.Matchable>(with newLanguage: M1) -> Cuckoo.ProtocolStubFunction<(WalletLanguage), WalletCommandProtocol> where M1.MatchedType == WalletLanguage {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletLanguage)>] = [wrap(matchable: newLanguage) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWalletCommandFactoryProtocol.self, method: "prepareLanguageSwitchCommand(with: WalletLanguage) -> WalletCommandProtocol", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WalletCommandFactoryProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func prepareSendCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("prepareSendCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareReceiveCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("prepareReceiveCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareAssetDetailsCommand<M1: Cuckoo.Matchable>(for assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId), AssetDetailsCommadProtocol> where M1.MatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("prepareAssetDetailsCommand(for: IRAssetId) -> AssetDetailsCommadProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareScanReceiverCommand() -> Cuckoo.__DoNotUse<(), WalletPresentationCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("prepareScanReceiverCommand() -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareWithdrawCommand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(for assetId: M1, optionId: M2) -> Cuckoo.__DoNotUse<(IRAssetId, String), WalletPresentationCommandProtocol> where M1.MatchedType == IRAssetId, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId, String)>] = [wrap(matchable: assetId) { $0.0 }, wrap(matchable: optionId) { $0.1 }]
	        return cuckoo_manager.verify("prepareWithdrawCommand(for: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func preparePresentationCommand<M1: Cuckoo.Matchable>(for controller: M1) -> Cuckoo.__DoNotUse<(UIViewController), WalletPresentationCommandProtocol> where M1.MatchedType == UIViewController {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: controller) { $0 }]
	        return cuckoo_manager.verify("preparePresentationCommand(for: UIViewController) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareHideCommand<M1: Cuckoo.Matchable>(with actionType: M1) -> Cuckoo.__DoNotUse<(WalletHideActionType), WalletHideCommandProtocol> where M1.MatchedType == WalletHideActionType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHideActionType)>] = [wrap(matchable: actionType) { $0 }]
	        return cuckoo_manager.verify("prepareHideCommand(with: WalletHideActionType) -> WalletHideCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareAccountUpdateCommand() -> Cuckoo.__DoNotUse<(), WalletCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("prepareAccountUpdateCommand() -> WalletCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareLanguageSwitchCommand<M1: Cuckoo.Matchable>(with newLanguage: M1) -> Cuckoo.__DoNotUse<(WalletLanguage), WalletCommandProtocol> where M1.MatchedType == WalletLanguage {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletLanguage)>] = [wrap(matchable: newLanguage) { $0 }]
	        return cuckoo_manager.verify("prepareLanguageSwitchCommand(with: WalletLanguage) -> WalletCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WalletCommandFactoryProtocolStub: WalletCommandFactoryProtocol {
    

    

    
    public func prepareSendCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareReceiveCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareAssetDetailsCommand(for assetId: IRAssetId) -> AssetDetailsCommadProtocol  {
        return DefaultValueRegistry.defaultValue(for: (AssetDetailsCommadProtocol).self)
    }
    
    public func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareWithdrawCommand(for assetId: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func preparePresentationCommand(for controller: UIViewController) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareHideCommand(with actionType: WalletHideActionType) -> WalletHideCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletHideCommandProtocol).self)
    }
    
    public func prepareAccountUpdateCommand() -> WalletCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletCommandProtocol).self)
    }
    
    public func prepareLanguageSwitchCommand(with newLanguage: WalletLanguage) -> WalletCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletCommandProtocol).self)
    }
    
}



public class MockCommonWalletContextProtocol: CommonWalletContextProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = CommonWalletContextProtocol
    
    public typealias Stubbing = __StubbingProxy_CommonWalletContextProtocol
    public typealias Verification = __VerificationProxy_CommonWalletContextProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CommonWalletContextProtocol?

    public func enableDefaultImplementation(_ stub: CommonWalletContextProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func createRootController() throws -> UINavigationController {
        
    return try cuckoo_manager.callThrows("createRootController() throws -> UINavigationController",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.createRootController())
        
    }
    
    
    
    public func prepareSendCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareSendCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareSendCommand(for: assetId))
        
    }
    
    
    
    public func prepareReceiveCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareReceiveCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareReceiveCommand(for: assetId))
        
    }
    
    
    
    public func prepareAssetDetailsCommand(for assetId: IRAssetId) -> AssetDetailsCommadProtocol {
        
    return cuckoo_manager.call("prepareAssetDetailsCommand(for: IRAssetId) -> AssetDetailsCommadProtocol",
            parameters: (assetId),
            escapingParameters: (assetId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareAssetDetailsCommand(for: assetId))
        
    }
    
    
    
    public func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareScanReceiverCommand() -> WalletPresentationCommandProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareScanReceiverCommand())
        
    }
    
    
    
    public func prepareWithdrawCommand(for assetId: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("prepareWithdrawCommand(for: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol",
            parameters: (assetId, optionId),
            escapingParameters: (assetId, optionId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareWithdrawCommand(for: assetId, optionId: optionId))
        
    }
    
    
    
    public func preparePresentationCommand(for controller: UIViewController) -> WalletPresentationCommandProtocol {
        
    return cuckoo_manager.call("preparePresentationCommand(for: UIViewController) -> WalletPresentationCommandProtocol",
            parameters: (controller),
            escapingParameters: (controller),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.preparePresentationCommand(for: controller))
        
    }
    
    
    
    public func prepareHideCommand(with actionType: WalletHideActionType) -> WalletHideCommandProtocol {
        
    return cuckoo_manager.call("prepareHideCommand(with: WalletHideActionType) -> WalletHideCommandProtocol",
            parameters: (actionType),
            escapingParameters: (actionType),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareHideCommand(with: actionType))
        
    }
    
    
    
    public func prepareAccountUpdateCommand() -> WalletCommandProtocol {
        
    return cuckoo_manager.call("prepareAccountUpdateCommand() -> WalletCommandProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareAccountUpdateCommand())
        
    }
    
    
    
    public func prepareLanguageSwitchCommand(with newLanguage: WalletLanguage) -> WalletCommandProtocol {
        
    return cuckoo_manager.call("prepareLanguageSwitchCommand(with: WalletLanguage) -> WalletCommandProtocol",
            parameters: (newLanguage),
            escapingParameters: (newLanguage),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.prepareLanguageSwitchCommand(with: newLanguage))
        
    }
    

	public struct __StubbingProxy_CommonWalletContextProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func createRootController() -> Cuckoo.ProtocolStubThrowingFunction<(), UINavigationController> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "createRootController() throws -> UINavigationController", parameterMatchers: matchers))
	    }
	    
	    func prepareSendCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareSendCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareReceiveCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareReceiveCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareAssetDetailsCommand<M1: Cuckoo.Matchable>(for assetId: M1) -> Cuckoo.ProtocolStubFunction<(IRAssetId), AssetDetailsCommadProtocol> where M1.MatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId)>] = [wrap(matchable: assetId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareAssetDetailsCommand(for: IRAssetId) -> AssetDetailsCommadProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareScanReceiverCommand() -> Cuckoo.ProtocolStubFunction<(), WalletPresentationCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareScanReceiverCommand() -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareWithdrawCommand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(for assetId: M1, optionId: M2) -> Cuckoo.ProtocolStubFunction<(IRAssetId, String), WalletPresentationCommandProtocol> where M1.MatchedType == IRAssetId, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId, String)>] = [wrap(matchable: assetId) { $0.0 }, wrap(matchable: optionId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareWithdrawCommand(for: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func preparePresentationCommand<M1: Cuckoo.Matchable>(for controller: M1) -> Cuckoo.ProtocolStubFunction<(UIViewController), WalletPresentationCommandProtocol> where M1.MatchedType == UIViewController {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: controller) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "preparePresentationCommand(for: UIViewController) -> WalletPresentationCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareHideCommand<M1: Cuckoo.Matchable>(with actionType: M1) -> Cuckoo.ProtocolStubFunction<(WalletHideActionType), WalletHideCommandProtocol> where M1.MatchedType == WalletHideActionType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHideActionType)>] = [wrap(matchable: actionType) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareHideCommand(with: WalletHideActionType) -> WalletHideCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareAccountUpdateCommand() -> Cuckoo.ProtocolStubFunction<(), WalletCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareAccountUpdateCommand() -> WalletCommandProtocol", parameterMatchers: matchers))
	    }
	    
	    func prepareLanguageSwitchCommand<M1: Cuckoo.Matchable>(with newLanguage: M1) -> Cuckoo.ProtocolStubFunction<(WalletLanguage), WalletCommandProtocol> where M1.MatchedType == WalletLanguage {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletLanguage)>] = [wrap(matchable: newLanguage) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommonWalletContextProtocol.self, method: "prepareLanguageSwitchCommand(with: WalletLanguage) -> WalletCommandProtocol", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_CommonWalletContextProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func createRootController() -> Cuckoo.__DoNotUse<(), UINavigationController> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("createRootController() throws -> UINavigationController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareSendCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("prepareSendCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareReceiveCommand<M1: Cuckoo.OptionalMatchable>(for assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId?), WalletPresentationCommandProtocol> where M1.OptionalMatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId?)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("prepareReceiveCommand(for: IRAssetId?) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareAssetDetailsCommand<M1: Cuckoo.Matchable>(for assetId: M1) -> Cuckoo.__DoNotUse<(IRAssetId), AssetDetailsCommadProtocol> where M1.MatchedType == IRAssetId {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId)>] = [wrap(matchable: assetId) { $0 }]
	        return cuckoo_manager.verify("prepareAssetDetailsCommand(for: IRAssetId) -> AssetDetailsCommadProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareScanReceiverCommand() -> Cuckoo.__DoNotUse<(), WalletPresentationCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("prepareScanReceiverCommand() -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareWithdrawCommand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(for assetId: M1, optionId: M2) -> Cuckoo.__DoNotUse<(IRAssetId, String), WalletPresentationCommandProtocol> where M1.MatchedType == IRAssetId, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(IRAssetId, String)>] = [wrap(matchable: assetId) { $0.0 }, wrap(matchable: optionId) { $0.1 }]
	        return cuckoo_manager.verify("prepareWithdrawCommand(for: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func preparePresentationCommand<M1: Cuckoo.Matchable>(for controller: M1) -> Cuckoo.__DoNotUse<(UIViewController), WalletPresentationCommandProtocol> where M1.MatchedType == UIViewController {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: controller) { $0 }]
	        return cuckoo_manager.verify("preparePresentationCommand(for: UIViewController) -> WalletPresentationCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareHideCommand<M1: Cuckoo.Matchable>(with actionType: M1) -> Cuckoo.__DoNotUse<(WalletHideActionType), WalletHideCommandProtocol> where M1.MatchedType == WalletHideActionType {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletHideActionType)>] = [wrap(matchable: actionType) { $0 }]
	        return cuckoo_manager.verify("prepareHideCommand(with: WalletHideActionType) -> WalletHideCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareAccountUpdateCommand() -> Cuckoo.__DoNotUse<(), WalletCommandProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("prepareAccountUpdateCommand() -> WalletCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func prepareLanguageSwitchCommand<M1: Cuckoo.Matchable>(with newLanguage: M1) -> Cuckoo.__DoNotUse<(WalletLanguage), WalletCommandProtocol> where M1.MatchedType == WalletLanguage {
	        let matchers: [Cuckoo.ParameterMatcher<(WalletLanguage)>] = [wrap(matchable: newLanguage) { $0 }]
	        return cuckoo_manager.verify("prepareLanguageSwitchCommand(with: WalletLanguage) -> WalletCommandProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class CommonWalletContextProtocolStub: CommonWalletContextProtocol {
    

    

    
    public func createRootController() throws -> UINavigationController  {
        return DefaultValueRegistry.defaultValue(for: (UINavigationController).self)
    }
    
    public func prepareSendCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareReceiveCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareAssetDetailsCommand(for assetId: IRAssetId) -> AssetDetailsCommadProtocol  {
        return DefaultValueRegistry.defaultValue(for: (AssetDetailsCommadProtocol).self)
    }
    
    public func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareWithdrawCommand(for assetId: IRAssetId, optionId: String) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func preparePresentationCommand(for controller: UIViewController) -> WalletPresentationCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletPresentationCommandProtocol).self)
    }
    
    public func prepareHideCommand(with actionType: WalletHideActionType) -> WalletHideCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletHideCommandProtocol).self)
    }
    
    public func prepareAccountUpdateCommand() -> WalletCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletCommandProtocol).self)
    }
    
    public func prepareLanguageSwitchCommand(with newLanguage: WalletLanguage) -> WalletCommandProtocol  {
        return DefaultValueRegistry.defaultValue(for: (WalletCommandProtocol).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockAmountInputViewModelObserver: AmountInputViewModelObserver, Cuckoo.ProtocolMock {
    
     typealias MocksType = AmountInputViewModelObserver
    
     typealias Stubbing = __StubbingProxy_AmountInputViewModelObserver
     typealias Verification = __VerificationProxy_AmountInputViewModelObserver

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AmountInputViewModelObserver?

     func enableDefaultImplementation(_ stub: AmountInputViewModelObserver) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func amountInputDidChange()  {
        
    return cuckoo_manager.call("amountInputDidChange()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.amountInputDidChange())
        
    }
    

	 struct __StubbingProxy_AmountInputViewModelObserver: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func amountInputDidChange() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountInputViewModelObserver.self, method: "amountInputDidChange()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AmountInputViewModelObserver: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func amountInputDidChange() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("amountInputDidChange()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AmountInputViewModelObserverStub: AmountInputViewModelObserver {
    

    

    
     func amountInputDidChange()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAmountInputViewModelProtocol: AmountInputViewModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AmountInputViewModelProtocol
    
     typealias Stubbing = __StubbingProxy_AmountInputViewModelProtocol
     typealias Verification = __VerificationProxy_AmountInputViewModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AmountInputViewModelProtocol?

     func enableDefaultImplementation(_ stub: AmountInputViewModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var displayAmount: String {
        get {
            return cuckoo_manager.getter("displayAmount",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.displayAmount)
        }
        
    }
    
    
    
     var isValid: Bool {
        get {
            return cuckoo_manager.getter("isValid",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isValid)
        }
        
    }
    
    
    
     var observable: WalletViewModelObserverContainer<AmountInputViewModelObserver> {
        get {
            return cuckoo_manager.getter("observable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.observable)
        }
        
    }
    

    

    
    
    
     func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        
    return cuckoo_manager.call("didReceiveReplacement(_: String, for: NSRange) -> Bool",
            parameters: (string, range),
            escapingParameters: (string, range),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.didReceiveReplacement(string, for: range))
        
    }
    

	 struct __StubbingProxy_AmountInputViewModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var displayAmount: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountInputViewModelProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "displayAmount")
	    }
	    
	    
	    var isValid: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountInputViewModelProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isValid")
	    }
	    
	    
	    var observable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAmountInputViewModelProtocol, WalletViewModelObserverContainer<AmountInputViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable")
	    }
	    
	    
	    func didReceiveReplacement<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ string: M1, for range: M2) -> Cuckoo.ProtocolStubFunction<(String, NSRange), Bool> where M1.MatchedType == String, M2.MatchedType == NSRange {
	        let matchers: [Cuckoo.ParameterMatcher<(String, NSRange)>] = [wrap(matchable: string) { $0.0 }, wrap(matchable: range) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAmountInputViewModelProtocol.self, method: "didReceiveReplacement(_: String, for: NSRange) -> Bool", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AmountInputViewModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var displayAmount: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "displayAmount", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var isValid: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isValid", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var observable: Cuckoo.VerifyReadOnlyProperty<WalletViewModelObserverContainer<AmountInputViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func didReceiveReplacement<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ string: M1, for range: M2) -> Cuckoo.__DoNotUse<(String, NSRange), Bool> where M1.MatchedType == String, M2.MatchedType == NSRange {
	        let matchers: [Cuckoo.ParameterMatcher<(String, NSRange)>] = [wrap(matchable: string) { $0.0 }, wrap(matchable: range) { $0.1 }]
	        return cuckoo_manager.verify("didReceiveReplacement(_: String, for: NSRange) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AmountInputViewModelProtocolStub: AmountInputViewModelProtocol {
    
    
     var displayAmount: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var isValid: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var observable: WalletViewModelObserverContainer<AmountInputViewModelObserver> {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletViewModelObserverContainer<AmountInputViewModelObserver>).self)
        }
        
    }
    

    

    
     func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
}


import Cuckoo
@testable import CommonWallet

import Foundation
import IrohaCommunication


 class MockAssetSelectionViewModelObserver: AssetSelectionViewModelObserver, Cuckoo.ProtocolMock {
    
     typealias MocksType = AssetSelectionViewModelObserver
    
     typealias Stubbing = __StubbingProxy_AssetSelectionViewModelObserver
     typealias Verification = __VerificationProxy_AssetSelectionViewModelObserver

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AssetSelectionViewModelObserver?

     func enableDefaultImplementation(_ stub: AssetSelectionViewModelObserver) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func assetSelectionDidChangeTitle()  {
        
    return cuckoo_manager.call("assetSelectionDidChangeTitle()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.assetSelectionDidChangeTitle())
        
    }
    
    
    
     func assetSelectionDidChangeSymbol()  {
        
    return cuckoo_manager.call("assetSelectionDidChangeSymbol()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.assetSelectionDidChangeSymbol())
        
    }
    
    
    
     func assetSelectionDidChangeState()  {
        
    return cuckoo_manager.call("assetSelectionDidChangeState()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.assetSelectionDidChangeState())
        
    }
    

	 struct __StubbingProxy_AssetSelectionViewModelObserver: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func assetSelectionDidChangeTitle() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAssetSelectionViewModelObserver.self, method: "assetSelectionDidChangeTitle()", parameterMatchers: matchers))
	    }
	    
	    func assetSelectionDidChangeSymbol() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAssetSelectionViewModelObserver.self, method: "assetSelectionDidChangeSymbol()", parameterMatchers: matchers))
	    }
	    
	    func assetSelectionDidChangeState() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAssetSelectionViewModelObserver.self, method: "assetSelectionDidChangeState()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AssetSelectionViewModelObserver: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func assetSelectionDidChangeTitle() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("assetSelectionDidChangeTitle()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func assetSelectionDidChangeSymbol() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("assetSelectionDidChangeSymbol()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func assetSelectionDidChangeState() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("assetSelectionDidChangeState()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AssetSelectionViewModelObserverStub: AssetSelectionViewModelObserver {
    

    

    
     func assetSelectionDidChangeTitle()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func assetSelectionDidChangeSymbol()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func assetSelectionDidChangeState()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAssetSelectionViewModelProtocol: AssetSelectionViewModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AssetSelectionViewModelProtocol
    
     typealias Stubbing = __StubbingProxy_AssetSelectionViewModelProtocol
     typealias Verification = __VerificationProxy_AssetSelectionViewModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AssetSelectionViewModelProtocol?

     func enableDefaultImplementation(_ stub: AssetSelectionViewModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var title: String {
        get {
            return cuckoo_manager.getter("title",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.title)
        }
        
    }
    
    
    
     var symbol: String {
        get {
            return cuckoo_manager.getter("symbol",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.symbol)
        }
        
    }
    
    
    
     var isSelecting: Bool {
        get {
            return cuckoo_manager.getter("isSelecting",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isSelecting)
        }
        
    }
    
    
    
     var isValid: Bool {
        get {
            return cuckoo_manager.getter("isValid",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isValid)
        }
        
    }
    
    
    
     var canSelect: Bool {
        get {
            return cuckoo_manager.getter("canSelect",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.canSelect)
        }
        
    }
    
    
    
     var observable: WalletViewModelObserverContainer<AssetSelectionViewModelObserver> {
        get {
            return cuckoo_manager.getter("observable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.observable)
        }
        
    }
    

    

    

	 struct __StubbingProxy_AssetSelectionViewModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var title: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAssetSelectionViewModelProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "title")
	    }
	    
	    
	    var symbol: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAssetSelectionViewModelProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "symbol")
	    }
	    
	    
	    var isSelecting: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAssetSelectionViewModelProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isSelecting")
	    }
	    
	    
	    var isValid: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAssetSelectionViewModelProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isValid")
	    }
	    
	    
	    var canSelect: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAssetSelectionViewModelProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "canSelect")
	    }
	    
	    
	    var observable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAssetSelectionViewModelProtocol, WalletViewModelObserverContainer<AssetSelectionViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable")
	    }
	    
	    
	}

	 struct __VerificationProxy_AssetSelectionViewModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var title: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "title", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var symbol: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "symbol", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var isSelecting: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isSelecting", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var isValid: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isValid", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var canSelect: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "canSelect", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var observable: Cuckoo.VerifyReadOnlyProperty<WalletViewModelObserverContainer<AssetSelectionViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class AssetSelectionViewModelProtocolStub: AssetSelectionViewModelProtocol {
    
    
     var title: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var symbol: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var isSelecting: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var isValid: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var canSelect: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var observable: WalletViewModelObserverContainer<AssetSelectionViewModelObserver> {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletViewModelObserverContainer<AssetSelectionViewModelObserver>).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import CommonWallet

import Foundation


 class MockFeeViewModelObserver: FeeViewModelObserver, Cuckoo.ProtocolMock {
    
     typealias MocksType = FeeViewModelObserver
    
     typealias Stubbing = __StubbingProxy_FeeViewModelObserver
     typealias Verification = __VerificationProxy_FeeViewModelObserver

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeeViewModelObserver?

     func enableDefaultImplementation(_ stub: FeeViewModelObserver) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func feeTitleDidChange()  {
        
    return cuckoo_manager.call("feeTitleDidChange()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.feeTitleDidChange!())
        
    }
    
    
    
     func feeLoadingStateDidChange()  {
        
    return cuckoo_manager.call("feeLoadingStateDidChange()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.feeLoadingStateDidChange!())
        
    }
    

	 struct __StubbingProxy_FeeViewModelObserver: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func feeTitleDidChange() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFeeViewModelObserver.self, method: "feeTitleDidChange()", parameterMatchers: matchers))
	    }
	    
	    func feeLoadingStateDidChange() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFeeViewModelObserver.self, method: "feeLoadingStateDidChange()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FeeViewModelObserver: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func feeTitleDidChange() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("feeTitleDidChange()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func feeLoadingStateDidChange() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("feeLoadingStateDidChange()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FeeViewModelObserverStub: FeeViewModelObserver {
    

    

    
     func feeTitleDidChange()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func feeLoadingStateDidChange()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockFeeViewModelProtocol: FeeViewModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = FeeViewModelProtocol
    
     typealias Stubbing = __StubbingProxy_FeeViewModelProtocol
     typealias Verification = __VerificationProxy_FeeViewModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FeeViewModelProtocol?

     func enableDefaultImplementation(_ stub: FeeViewModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var title: String {
        get {
            return cuckoo_manager.getter("title",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.title)
        }
        
    }
    
    
    
     var isLoading: Bool {
        get {
            return cuckoo_manager.getter("isLoading",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.isLoading)
        }
        
    }
    
    
    
     var observable: WalletViewModelObserverContainer<FeeViewModelObserver> {
        get {
            return cuckoo_manager.getter("observable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.observable)
        }
        
    }
    

    

    

	 struct __StubbingProxy_FeeViewModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var title: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeeViewModelProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "title")
	    }
	    
	    
	    var isLoading: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeeViewModelProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isLoading")
	    }
	    
	    
	    var observable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFeeViewModelProtocol, WalletViewModelObserverContainer<FeeViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable")
	    }
	    
	    
	}

	 struct __VerificationProxy_FeeViewModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var title: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "title", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var isLoading: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "isLoading", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var observable: Cuckoo.VerifyReadOnlyProperty<WalletViewModelObserverContainer<FeeViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class FeeViewModelProtocolStub: FeeViewModelProtocol {
    
    
     var title: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var isLoading: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var observable: WalletViewModelObserverContainer<FeeViewModelObserver> {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletViewModelObserverContainer<FeeViewModelObserver>).self)
        }
        
    }
    

    

    
}

