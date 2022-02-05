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
        group: Optional<DispatchGroup> = nil,
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

    /// Execute action on specific dispatch queue asynchronously awaiting when all tasks in the current group have finished executing.
    ///
    /// - Parameters:
    ///   - group: The dispatch group to associate with the action.
    ///
    ///   - qos: The QoS at which the flow should be executed.
    ///
    ///   - flags: Flags that control the execution environment of the flow.
    ///
    ///   - queue: Dispatch queue on which action will be executed.
    ///
    /// - Returns: Synchronizer that provides thread safety using dispatch group environment.
    static func dispatchGroup(
        _ group: DispatchGroup,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = [],
        queue: DispatchQueue
    ) -> FlowSynchronizer {
        FlowSynchronizer({ action in
            group.notify(
                qos: qos,
                flags: flags,
                queue: queue,
                execute: action
            )
        })
    }
}
