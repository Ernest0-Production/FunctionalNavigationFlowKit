//
//  File.swift
//  
//
//  Created by Ernest Babayan on 30.10.2021.
//

public func whenExists<Object>(
    _ objectPromise: @autoclosure @escaping Deferred<Object?>,
    execute flowBuilder: @escaping (Object) -> Flow
) -> Flow {
    LazyFlow({
        guard let object = objectPromise() else {
            return EmptyFlow
        }

        return flowBuilder(object)
    })
}
