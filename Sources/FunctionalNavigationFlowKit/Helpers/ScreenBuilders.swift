//
//  File.swift
//  
//
//  Created by Ernest Babayan on 30.10.2021.
//

public func build<Object>(_ builder: Deferred<Object>) -> Object {
    builder()
}

public func recursively<Object>(_ builder: (@escaping Deferred<Object?>) -> Object) -> Object {
    var promisedObject: AnyObject?
    
    let promise: Deferred<Object?> = { [weak promisedObject] in
        assert(promisedObject != nil, "early access to uninitialized object")
        return promisedObject as? Object
    }

    let object = builder(promise)
    promisedObject = object as AnyObject

    return object
}
