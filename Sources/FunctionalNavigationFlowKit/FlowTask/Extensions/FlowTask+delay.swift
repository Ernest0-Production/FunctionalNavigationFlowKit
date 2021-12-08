//
//  File.swift
//  
//
//  Created by Ernest Babayan on 08.12.2021.
//

import Foundation


public extension FlowTask {
    /// Delay execution of task on the specific dispatch queue asynchronously.
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
    /// - Returns: Task that execute this task on the specific dispatch queue with a delay.
    func delayExecution(
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

    /// Delay task completion on the specific dispatch queue asynchronously.
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
    /// - Returns: Task that execute this task and complete it on the specific dispatch queue with a delay.
    func delayCompletion(
        on queue: DispatchQueue,
        after deadline: DispatchTime,
        qos: DispatchQoS = .unspecified,
        flags: DispatchWorkItemFlags = []
    ) -> FlowTask {
        FlowTask.create({ [self] completion in
            execute(onComplete: {
                queue.asyncAfter(
                    deadline: deadline,
                    qos: qos,
                    flags: flags,
                    execute: completion
                )
            })

            return Flow.empty
        })
    }
}
