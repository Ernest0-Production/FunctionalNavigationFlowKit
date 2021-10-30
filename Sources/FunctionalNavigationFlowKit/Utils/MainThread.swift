//
//  Helpers.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import Foundation


func onMainThread<Result>(_ execute: @escaping Deferred<Result>) -> Deferred<Result> {
    return {
        guard !Thread.isMainThread else {
            return execute()
        }

        return DispatchQueue.main.sync(execute: execute)
    }
}
