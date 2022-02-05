//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension Flow {
    /// Prints log messages before and after flow executions.
    ///
    /// - Parameters:
    ///   - prefix: A string with which to prefix all log messages.
    ///
    ///   - stream: A stream for text output that receives messages, and which directs output to the console by default. A custom stream can be used to log messages to other destinations.
    ///
    /// - Returns: Flow that log before and after this flow.
    func log(
        prefix: Optional<String> = nil,
        to stream: TextOutputStream = FlowEnvironment.defaultLogStream()
    ) -> Flow {
        lazy var finalStream = stream

        return sideEffect(
            beforeStart: { finalStream.write(message: "Will execute flow", withPrefix: prefix) },
            afterStart: { finalStream.write(message: "Did execute flow", withPrefix: prefix) }
        )
    }
}
