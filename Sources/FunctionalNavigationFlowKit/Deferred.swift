//
//  Deferred.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

public typealias Deferred<T> = () -> T


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

public func DeferredBuild<T>(
    _ autoclosure_builder: @autoclosure @escaping Deferred<T>,
    with flowBuilder: @escaping (T) -> Flow
) -> Deferred<T> {
    DeferredBuild(autoclosure_builder, with: flowBuilder)
}
