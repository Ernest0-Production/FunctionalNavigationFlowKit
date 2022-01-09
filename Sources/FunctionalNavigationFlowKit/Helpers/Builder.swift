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
public func buildWithPointer<Object>(_ builder: (@escaping () -> Object) -> Object) -> Object {
    var pointer = Optional<AnyObject>.none

    let pointerGetter: () -> Object = { [weak pointer] in
        assert(pointer != nil, "early access to uninitialized object")
        return pointer as! Object
    }

    let object = builder(pointerGetter)
    pointer =  object as Optional<AnyObject>

    return object
}
