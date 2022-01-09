//
//  File.swift
//  
//
//  Created by Ernest Babayan on 14.11.2021.
//

public extension FlowConfiguration {
    /// Packs several configurations into one.
    ///
    /// - Parameter configurations: Ordered list of the configurations that should be executed serially.
    ///
    /// - Returns: FlowConfiguration that will serially execute passed list of configuration.
    static func zip(_ configurations: [FlowConfiguration]) -> FlowConfiguration {
        configurations.reduce(FlowConfiguration.empty, { $0.appending($1) })
    }
}
