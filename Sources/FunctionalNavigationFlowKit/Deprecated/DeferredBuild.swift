//
//  File.swift
//  
//
//  Created by Ernest Babayan on 29.10.2021.
//

@available(*, deprecated, message: "Has been renamed", renamed: "WithFlow")
public func DeferredBuild<T>(
    _ builder: @escaping Deferred<T>,
    with flowBuilder: @escaping (T) -> Flow
) -> Deferred<T> {
    return {
        let object = builder()
        flowBuilder(object)()
        return object
    }
}

@available(*, deprecated, message: "Has been renamed", renamed: "WithFlow")
public func DeferredBuild<T>(
    _ autoclosure_builder: @autoclosure @escaping Deferred<T>,
    with flowBuilder: @escaping (T) -> Flow
) -> Deferred<T> {
    DeferredBuild(autoclosure_builder, with: flowBuilder)
}
