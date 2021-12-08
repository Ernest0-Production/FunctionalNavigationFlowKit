//
//  File.swift
//  
//
//  Created by Ernest Babayan on 21.11.2021.
//

import Foundation


public extension FlowSynchronizer {

    /// Execute action on specific dispatch queue asynchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which action will be executed.
    ///
    ///   - group: The dispatch group to associate with the action. If you specify nil, the block is not associated with a group.
    ///
    ///   - qos: The QoS at which the flow should be executed.
    ///
    ///   - flags: Flags that control the execution environment of the flow.
    ///
    /// - Returns: Synchronizer that provides thread safety using dispatch queue environment.
    static func dispatchQueue(
        _ queue: DispatchQueue,
        group: DispatchGroup? = nil,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = []
    ) -> FlowSynchronizer {
        FlowSynchronizer({ action in
            queue.async(
                group: group,
                qos: qos,
                flags: flags,
                execute: action
            )
        })
    }

    /// Execute action on the main thread (synchronously if possible, otherwise asynchronously).
    static var mainThread: FlowSynchronizer {
        FlowSynchronizer({ action in
            if Thread.isMainThread {
                action()
            } else {
                DispatchQueue.main.sync(execute: action)
            }
        })
    }

    /// Execute action on specific flow task queue for serially execution.
    ///
    /// - Parameter queue: Flow task queue  on which action will be executed.
    ///
    /// - Returns: Synchronizer that provides serially execution on task queue.
    static func taskQueue(_ queue: FlowTaskQueue) -> FlowSynchronizer {
        FlowSynchronizer({ action in
            queue.execute(FlowTask.just(Flow.just(action)))
        })
    }

    /// Execute action on shared main flow queue.
    static var mainTaskQueue: FlowSynchronizer {
        FlowSynchronizer.taskQueue(FlowTaskQueue.main)
    }
}
