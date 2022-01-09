//
//  File.swift
//  
//
//  Created by Ernest Babayan on 21.11.2021.
//

import Foundation


public extension FlowSynchronizer {
    /// Execute action with mediating access using NSLocking mechanism.
    ///
    /// - Parameter lock: NSLocking implementation instance that should mediate access of action execution.
    ///
    /// - Returns: Synchronizer that provides thread safety using specific NSLock.
    static func lock(_ lock: NSLocking) -> FlowSynchronizer {
        FlowSynchronizer({ action in
            lock.lock(); defer { lock.unlock() }
            action()
        })
    }

    /// Execute action with mediating access using NSLock mechanism.
    static var lock: FlowSynchronizer {
        FlowSynchronizer.lock(NSLock())
    }

    /// Execute action with mediating access using NSRecursiveLock mechanism.
    static var recursiveLock: FlowSynchronizer {
        FlowSynchronizer.lock(NSRecursiveLock())
    }
}
