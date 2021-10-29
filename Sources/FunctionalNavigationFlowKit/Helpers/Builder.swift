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
public func build<Object>(_ builder: Deferred<Object>) -> Object {
    builder()
}

/// Compositional initialization of an object with provder to self-result.
///
/// - Parameter builder: Scope for initializing object and making some additional things on it before return result **and with ability to get result-future before returning**.
///
/// - Returns: Resulting object.
public func recursively<Object>(_ builder: (@escaping Deferred<Object>) -> Object) -> Object {
    var promisedObject: AnyObject?

    let promise: Deferred<Object> = { [weak promisedObject] in
        assert(promisedObject != nil, "early access to uninitialized object")
        return promisedObject as! Object
    }

    let object = builder(promise)
    promisedObject = object as AnyObject

    return object
}
