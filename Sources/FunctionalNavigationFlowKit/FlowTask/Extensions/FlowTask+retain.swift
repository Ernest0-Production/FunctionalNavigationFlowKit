//
//  File.swift
//  
//
//  Created by Ernest Babayan on 26.11.2021.
//

public extension FlowTask {
    /// Retain any object until this task is deinited.
    ///
    /// - Parameter object: Reference object that should be retained.
    func retain(_ object: AnyObject) -> FlowTask {
        sideEffect(onComplete: { _ = object })
    }
}
