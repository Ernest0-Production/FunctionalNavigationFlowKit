//
//  Helpers.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import Foundation


func onMainThread(_ flow: @escaping Flow) -> Flow {
    return {
        guard !Thread.isMainThread else {
            return flow()
        }

        return DispatchQueue.main.sync(execute: flow)
    }
}
