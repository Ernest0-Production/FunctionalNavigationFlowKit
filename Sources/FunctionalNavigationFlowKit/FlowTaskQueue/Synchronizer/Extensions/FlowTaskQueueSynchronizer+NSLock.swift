//
//  File.swift
//  
//
//  Created by Ernest Babayan on 21.11.2021.
//

import Foundation


public extension FlowTaskQueue.Synchronizer {
    /// Execute action with mediating access using NSLocking mechanism.
    ///
    /// - Parameter lock: NSLocking implementation instance that should mediate access of action execution.
    ///
    /// - Returns: Synchronizer that provides thread safety using specific NSLock.
    static func lock(_ lock: NSLocking) -> FlowTaskQueue.Synchronizer {
        FlowTaskQueue.Synchronizer({ action in
            lock.lock(); defer { lock.unlock() }
            action()
        })
    }
}
