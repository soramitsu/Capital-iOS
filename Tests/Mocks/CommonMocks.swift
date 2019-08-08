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
    

    

    
    public func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
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
    
    
    
     var networkResolver: WalletNetworkResolverProtocol {
        get {
            return cuckoo_manager.getter("networkResolver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.networkResolver)
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
    
    
    
     var amountFormatter: NumberFormatter {
        get {
            return cuckoo_manager.getter("amountFormatter",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.amountFormatter)
        }
        
    }
    
    
    
     var historyDateFormatter: DateFormatter {
        get {
            return cuckoo_manager.getter("historyDateFormatter",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.historyDateFormatter)
        }
        
    }
    
    
    
     var statusDateFormatter: DateFormatter {
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
    
    
    
     var transactionTypeList: [WalletTransactionType]? {
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
    

    

    

	 struct __StubbingProxy_ResolverProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var account: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletAccountSettingsProtocol> {
	        return .init(manager: cuckoo_manager, name: "account")
	    }
	    
	    
	    var networkResolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletNetworkResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "networkResolver")
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
	    
	    
	    var navigation: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, NavigationProtocol?> {
	        return .init(manager: cuckoo_manager, name: "navigation")
	    }
	    
	    
	    var logger: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, WalletLoggerProtocol?> {
	        return .init(manager: cuckoo_manager, name: "logger")
	    }
	    
	    
	    var amountFormatter: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, NumberFormatter> {
	        return .init(manager: cuckoo_manager, name: "amountFormatter")
	    }
	    
	    
	    var historyDateFormatter: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, DateFormatter> {
	        return .init(manager: cuckoo_manager, name: "historyDateFormatter")
	    }
	    
	    
	    var statusDateFormatter: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, DateFormatter> {
	        return .init(manager: cuckoo_manager, name: "statusDateFormatter")
	    }
	    
	    
	    var transferAmountLimit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, Decimal> {
	        return .init(manager: cuckoo_manager, name: "transferAmountLimit")
	    }
	    
	    
	    var transactionTypeList: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockResolverProtocol, [WalletTransactionType]?> {
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
	    
	    
	    var networkResolver: Cuckoo.VerifyReadOnlyProperty<WalletNetworkResolverProtocol> {
	        return .init(manager: cuckoo_manager, name: "networkResolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
	    
	    
	    var navigation: Cuckoo.VerifyReadOnlyProperty<NavigationProtocol?> {
	        return .init(manager: cuckoo_manager, name: "navigation", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var logger: Cuckoo.VerifyReadOnlyProperty<WalletLoggerProtocol?> {
	        return .init(manager: cuckoo_manager, name: "logger", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var amountFormatter: Cuckoo.VerifyReadOnlyProperty<NumberFormatter> {
	        return .init(manager: cuckoo_manager, name: "amountFormatter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var historyDateFormatter: Cuckoo.VerifyReadOnlyProperty<DateFormatter> {
	        return .init(manager: cuckoo_manager, name: "historyDateFormatter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var statusDateFormatter: Cuckoo.VerifyReadOnlyProperty<DateFormatter> {
	        return .init(manager: cuckoo_manager, name: "statusDateFormatter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var transferAmountLimit: Cuckoo.VerifyReadOnlyProperty<Decimal> {
	        return .init(manager: cuckoo_manager, name: "transferAmountLimit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var transactionTypeList: Cuckoo.VerifyReadOnlyProperty<[WalletTransactionType]?> {
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
	    
	
	    
	}
}

 class ResolverProtocolStub: ResolverProtocol {
    
    
     var account: WalletAccountSettingsProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletAccountSettingsProtocol).self)
        }
        
    }
    
    
     var networkResolver: WalletNetworkResolverProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletNetworkResolverProtocol).self)
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
    
    
     var amountFormatter: NumberFormatter {
        get {
            return DefaultValueRegistry.defaultValue(for: (NumberFormatter).self)
        }
        
    }
    
    
     var historyDateFormatter: DateFormatter {
        get {
            return DefaultValueRegistry.defaultValue(for: (DateFormatter).self)
        }
        
    }
    
    
     var statusDateFormatter: DateFormatter {
        get {
            return DefaultValueRegistry.defaultValue(for: (DateFormatter).self)
        }
        
    }
    
    
     var transferAmountLimit: Decimal {
        get {
            return DefaultValueRegistry.defaultValue(for: (Decimal).self)
        }
        
    }
    
    
     var transactionTypeList: [WalletTransactionType]? {
        get {
            return DefaultValueRegistry.defaultValue(for: ([WalletTransactionType]?).self)
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


 class MockWithdrawFeeViewModelObserver: WithdrawFeeViewModelObserver, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawFeeViewModelObserver
    
     typealias Stubbing = __StubbingProxy_WithdrawFeeViewModelObserver
     typealias Verification = __VerificationProxy_WithdrawFeeViewModelObserver

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawFeeViewModelObserver?

     func enableDefaultImplementation(_ stub: WithdrawFeeViewModelObserver) {
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
    

	 struct __StubbingProxy_WithdrawFeeViewModelObserver: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func feeTitleDidChange() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawFeeViewModelObserver.self, method: "feeTitleDidChange()", parameterMatchers: matchers))
	    }
	    
	    func feeLoadingStateDidChange() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWithdrawFeeViewModelObserver.self, method: "feeLoadingStateDidChange()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WithdrawFeeViewModelObserver: Cuckoo.VerificationProxy {
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

 class WithdrawFeeViewModelObserverStub: WithdrawFeeViewModelObserver {
    

    

    
     func feeTitleDidChange()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func feeLoadingStateDidChange()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockWithdrawFeeViewModelProtocol: WithdrawFeeViewModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WithdrawFeeViewModelProtocol
    
     typealias Stubbing = __StubbingProxy_WithdrawFeeViewModelProtocol
     typealias Verification = __VerificationProxy_WithdrawFeeViewModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WithdrawFeeViewModelProtocol?

     func enableDefaultImplementation(_ stub: WithdrawFeeViewModelProtocol) {
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
    
    
    
     var observable: WalletViewModelObserverContainer<WithdrawFeeViewModelObserver> {
        get {
            return cuckoo_manager.getter("observable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.observable)
        }
        
    }
    

    

    

	 struct __StubbingProxy_WithdrawFeeViewModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var title: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWithdrawFeeViewModelProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "title")
	    }
	    
	    
	    var isLoading: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWithdrawFeeViewModelProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "isLoading")
	    }
	    
	    
	    var observable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockWithdrawFeeViewModelProtocol, WalletViewModelObserverContainer<WithdrawFeeViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable")
	    }
	    
	    
	}

	 struct __VerificationProxy_WithdrawFeeViewModelProtocol: Cuckoo.VerificationProxy {
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
	    
	    
	    var observable: Cuckoo.VerifyReadOnlyProperty<WalletViewModelObserverContainer<WithdrawFeeViewModelObserver>> {
	        return .init(manager: cuckoo_manager, name: "observable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class WithdrawFeeViewModelProtocolStub: WithdrawFeeViewModelProtocol {
    
    
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
    
    
     var observable: WalletViewModelObserverContainer<WithdrawFeeViewModelObserver> {
        get {
            return DefaultValueRegistry.defaultValue(for: (WalletViewModelObserverContainer<WithdrawFeeViewModelObserver>).self)
        }
        
    }
    

    

    
}

