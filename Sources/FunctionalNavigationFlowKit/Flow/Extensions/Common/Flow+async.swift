//
//  Flow+DispatchQueue.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import Foundation


public extension Flow {
    /// Schedule flow execution on the main thread (synchronously if possible, otherwise asynchronously).
    ///
    /// - Returns: Flow that execute this flow on the main thread.
    func onMainThread() -> Flow {
        Flow({ [self] in
            if Thread.isMainThread {
                execute()
            } else {
                DispatchQueue.main.sync(execute: execute)
            }
        })
    }

    /// Schedule flow execution on the specific dispatch queue synchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which flow will be executed.
    ///
    ///   - flags: Flags that control the execution environment of the flow.
    ///
    /// - Returns: Flow that execute this flow on the specific dispatch queue synchronously.
    func sync(
        on queue: DispatchQueue,
        flags: DispatchWorkItemFlags = []
    ) -> Flow {
        Flow({ [self] in
            queue.sync(flags: flags, execute: execute)
        })
    }

    /// Schedule flow execution on the specific dispatch queue asynchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which flow will be executed.
    ///
    ///   - group: The dispatch group to associate with the flow. If you specify nil, the block is not associated with a group.
    ///
    ///   - qos: The QoS at which the flow should be executed.
    ///
    ///   - flags: Flags that control the execution environment of the flow.
    ///
    /// - Returns: Flow that execute this flow on the specific dispatch queue asynchronously.
    func async(
        on queue: DispatchQueue,
        group: DispatchGroup? = nil,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = []
    ) -> Flow {
        Flow({ [self] in
            queue.async(
                group: group,
                qos: qos,
                flags: flags,
                execute: execute
            )
        })
    }

    /// Schedule flow execution on the specific dispatch queue asynchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which flow will be executed.
    ///
    ///   - deadline: The time at which to schedule the block for execution. Specifying the current time is less efficient than calling the async(on:group:qos:flags) method directly. Do not specify the value in distantFuture; doing so is undefined.
    ///
    ///   - qos: The QoS at which the flow should be executed.
    ///
    ///   - flags: Flags that control the execution environment of the work item.
    ///
    /// - Returns: Flow that execute this flow on the specific dispatch queue asynchronously.
    func async(
        on queue: DispatchQueue,
        after deadline: DispatchTime,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = []
    ) -> Flow {
        Flow({ [self] in
            queue.asyncAfter(
                deadline: deadline,
                qos: qos,
                flags: flags,
                execute: execute
            )
        })
    }
}
