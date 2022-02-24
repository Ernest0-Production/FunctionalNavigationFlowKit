//
//  Builder.swift
//  
//
//  Created by Ernest Babayan on 02.11.2021.
//

/// Compositional initialization of an object.
///
/// - Parameter builder: Scope for initializing object and making some additional things on it before return result.
///
/// - Returns: Resulting object.
public func build<Object>(_ builder: () -> Object) -> Object {
    builder()
}

/// Compositional initialization of an object with provder to self-result.
///
/// - Parameter builder: Scope for initializing object and making some additional things on it before return result **and with ability to get result-future before returning**.
///
/// - Returns: Resulting object.
public func build<Object>(_ builder: (ObjectBuildResultPointer<Object>) -> Object) -> Object {
    let pointer = ObjectBuildResultPointer<Object>()

    let object = builder(pointer)
    pointer.value = object

    return object
}

public final class ObjectBuildResultPointer<Object> {
    private weak var _value: AnyObject?

    fileprivate(set) public var value: Object {
        get {
            assert(_value != nil, "early access to uninitialized object")
            return _value as! Object
        }
        set { _value = newValue as AnyObject }
    }
}
