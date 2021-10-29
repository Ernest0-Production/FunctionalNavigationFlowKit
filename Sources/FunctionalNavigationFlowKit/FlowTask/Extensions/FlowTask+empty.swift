//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

public extension FlowTask {
    /// Flow task that immediately completes.
    static var empty: FlowTask {
        FlowTask.just(Flow.empty)
    }
}
