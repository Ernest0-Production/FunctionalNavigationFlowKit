//
//  Build.swift
//  
//
//  Created by Ernest Babayan on 29.10.2021.
//

public func Build<Object>(
    _ objectBuilder: @autoclosure @escaping Deferred<Object>,
    withFlow flowBuilder: @escaping (Object) -> Flow
) -> Object {
    let object = objectBuilder()
    flowBuilder(object)()
    return object
}

public func RecursiveBuild<Object>(_ objectBuilder: (Deferred<Object?>) -> Object) -> Object {
    var promisedObject: AnyObject?
    let promise: Deferred<Object?> = { [weak promisedObject] in
        assert(promisedObject != nil, "early access to uninitialized object")
        return promisedObject as? Object
    }

    let object = objectBuilder(promise)
    promisedObject = object as AnyObject

    return object
}
