//
//  File.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//


func DeferredBuild<T>(_ builder: @escaping Deferred<T>, with flowBuilder: @escaping (T) -> Flow) -> Deferred<T> {
    return {
        let object = builder()
        flowBuilder(object)()
        return object
    }
}
