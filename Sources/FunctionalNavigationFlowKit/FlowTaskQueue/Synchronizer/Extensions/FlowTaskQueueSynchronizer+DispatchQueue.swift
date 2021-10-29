//
//  File.swift
//  
//
//  Created by Ernest Babayan on 21.11.2021.
//

import Foundation


public extension FlowTaskQueue.Synchronizer {

    /// Execute action in specific dispatch queue asynchronously.
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
    ) -> FlowTaskQueue.Synchronizer {
        FlowTaskQueue.Synchronizer({ action in
            queue.async(
                group: group,
                qos: qos,
                flags: flags,
                execute: action
            )
        })
    }
}
