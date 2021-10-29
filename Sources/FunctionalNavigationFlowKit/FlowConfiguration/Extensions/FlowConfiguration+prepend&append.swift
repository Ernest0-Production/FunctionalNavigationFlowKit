//
//  File.swift
//  
//
//  Created by Ernest Babayan on 14.11.2021.
//

public extension FlowConfiguration {
    /// Concatenates passed configuration before this configuration.
    ///
    /// - Parameter anotherConfiguration: Configuration to be performed before this configuration.
    ///
    /// - Returns: FlowConfiguration that will zip passed and this configurations.
    func prepending(_ anotherConfiguration: FlowConfiguration) -> FlowConfiguration {
        FlowConfiguration.zip([anotherConfiguration, self])
    }

    /// Concatenates passed configuration after this configuration.
    ///
    /// - Parameter anotherConfiguration: Configuration to be performed after this configuration.
    ///
    /// - Returns: FlowConfiguration that will zip this and passed configurations.
    func appending(_ anotherConfiguration: FlowConfiguration) -> FlowConfiguration {
        FlowConfiguration.zip([self, anotherConfiguration])
    }
}
