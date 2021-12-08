//
//  File.swift
//  
//
//  Created by Ernest Babayan on 07.12.2021.
//

import Foundation


public extension FlowTaskQueue {
    /// Shared flow queue that execute tasks on main dispatch queue.
    static let main = FlowTaskQueue(
        synchronizer: FlowSynchronizer.mainThread
    )
}
