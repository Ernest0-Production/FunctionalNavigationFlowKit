//
//  File.swift
//  
//
//  Created by Ernest Babayan on 21.11.2021.
//

import Foundation


public extension FlowTask {
    /// Schedule task execution on the main thread (synchronously if possible, otherwise asynchronously).
    ///
    /// - Returns: Task that execute this flow on the main thread.
    func onMainThread() -> FlowTask {
        FlowTask.create({ [self] completion in
            if Thread.isMainThread {
                execute(onComplete: completion)
            } else {
                DispatchQueue.main.sync(execute: {
                    execute(onComplete: completion)
                })
            }

            return Flow.empty
        })
    }

    /// Schedule task execution on the specific dispatch queue synchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which task will be executed.
    ///
    ///   - flags: Flags that control the execution environment of the task.
    ///
    /// - Returns: Task that execute this flow on the specific dispatch queue synchronously.
    func sync(
        on queue: DispatchQueue,
        flags: DispatchWorkItemFlags = []
    ) -> FlowTask {
        FlowTask.create({ [self] completion in
            queue.sync(flags: flags, execute: {
                execute(onComplete: completion)
            })

            return Flow.empty
        })
    }

    /// Schedule task execution on the specific dispatch queue asynchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which task will be executed.
    ///
    ///   - group: The dispatch group to associate with the task. If you specify nil, the block is not associated with a group.
    ///
    ///   - qos: The QoS at which the task should be executed.
    ///
    ///   - flags: Flags that control the execution environment of the task.
    ///
    /// - Returns: Task that execute this task on the specific dispatch queue asynchronously.
    func async(
        on queue: DispatchQueue,
        group: DispatchGroup? = nil,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = []
    ) -> FlowTask {
        FlowTask.create({ [self] completion in
            queue.async(
                group: group,
                qos: qos,
                flags: flags,
                execute: { execute(onComplete: completion) }
            )

            return Flow.empty
        })
    }

    /// Schedule task execution on the specific dispatch queue asynchronously.
    ///
    /// - Parameters:
    ///   - queue: Dispatch queue on which task will be executed.
    ///
    ///   - deadline: The time at which to schedule the block for execution. Specifying the current time is less efficient than calling the async(on:group:qos:flags) method directly. Do not specify the value in distantFuture; doing so is undefined.
    ///
    ///   - qos: The QoS at which the task should be executed.
    ///
    ///   - flags: Flags that control the execution environment of the work item.
    ///
    /// - Returns: Task that execute this task on the specific dispatch queue asynchronously.
    func async(
        on queue: DispatchQueue,
        after deadline: DispatchTime,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = []
    ) -> FlowTask {
        FlowTask.create({ [self] completion in
            queue.asyncAfter(
                deadline: deadline,
                qos: qos,
                flags: flags,
                execute: { execute(onComplete: completion) }
            )

            return Flow.empty
        })
    }
}
