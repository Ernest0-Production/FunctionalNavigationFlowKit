//
//  File.swift
//  
//
//  Created by Ernest Babayan on 20.11.2021.
//

public extension FlowConfiguration {
    /// Prints log messages before and after flow executions.
    ///
    /// - Parameters:
    ///   - prefix: A string with which to prefix all log messages.
    ///
    ///   - stream: A stream for text output that receives messages, and which directs output to the console by default. A custom stream can be used to log messages to other destinations.
    ///
    /// - Returns: FlowConfiguration that log preparation and completion of flow.
    func log(
        prefix: String? = nil,
        to stream: TextOutputStream = FlowEnvironment.defaultLogStream()
    ) -> FlowConfiguration {
        var finalStream = stream

        return FlowConfiguration(
            preparation: {
                finalStream.write(message: "Preparation of flow \($0) ➡️ \($1)", withPrefix: prefix)
            },
            completion: {
                finalStream.write(message: "Completion of flow \($0) ➡️ \($1)", withPrefix: prefix)
            }
        )
    }
}
