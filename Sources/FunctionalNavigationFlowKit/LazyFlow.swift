//
//  File.swift
//  
//
//  Created by Ernest Babayan on 29.06.2021.
//


public func LazyFlow(_ flowBuilder: @escaping Deferred<Flow>) -> Flow {
    return { flowBuilder()() }
}
