//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension FlowTask {
    /// Prints log messages before and after flow task execution.
    ///
    /// - Parameters:
    ///   - prefix: A string with which to prefix all log messages.
    ///
    ///   - stream: A stream for text output that receives messages, and which directs output to the console by default. A custom stream can be used to log messages to other destinations.
    ///
    /// - Returns: Flow task that log start and completion of this task.
    func log(
        prefix: String? = nil,
        to stream: TextOutputStream? = nil
    ) -> FlowTask {
        lazy var finalStream = stream.orDefault

        return sideEffect(
            beforeStart: { finalStream.write("\(logPrefix(with: prefix)) Will start executing flow task") },
            afterStart: { finalStream.write("\(logPrefix(with: prefix)) Did start executing flow task") },
            onComplete: { finalStream.write("\(logPrefix(with: prefix)) Complete executing flow task") }
        )
    }
}
