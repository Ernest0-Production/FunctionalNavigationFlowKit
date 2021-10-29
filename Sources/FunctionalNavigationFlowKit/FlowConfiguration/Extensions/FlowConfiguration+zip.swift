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
        FlowConfiguration(
            preparation: { departure, destination in
                for configuration in configurations {
                    configuration.preparationHandler?(departure, destination)
                }
            },
            completion:  { departure, destination in
                for configuration in configurations {
                    configuration.completionHandler?(departure, destination)
                }
            }
        )
    }
}
