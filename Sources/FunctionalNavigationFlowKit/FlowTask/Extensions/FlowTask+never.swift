//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

public extension FlowTask {
    /// Flow task that never completes.
    static var never: FlowTask {
        FlowTask.create({ _ in Flow.empty })
    }
}
