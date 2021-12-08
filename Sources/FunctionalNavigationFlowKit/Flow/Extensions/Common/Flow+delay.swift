//
//  File.swift
//  
//
//  Created by Ernest Babayan on 11.12.2021.
//

import Foundation


public extension Flow {
    /// Delay execution of flow on the specific dispatch queue asynchronously.
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
    func delay(
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
