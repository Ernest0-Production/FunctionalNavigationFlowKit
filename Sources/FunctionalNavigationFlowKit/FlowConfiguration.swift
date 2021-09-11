//
//  FlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public final class FlowConfiguration<Departure, Destination> {
    public typealias Handler = (_ departure: Departure, _ destination: Destination) -> Void

    public init(
        prepare: Handler? = nil,
        completion: Handler? = nil
    ) {
        self.prepareHandler = prepare
        self.completionHandler = completion
    }

    public let prepareHandler: Handler?
    public let completionHandler: Handler?
}


public extension FlowConfiguration {
    static var empty: FlowConfiguration { FlowConfiguration() }

    static func prepare(_ handler: @escaping Handler) -> FlowConfiguration {
        FlowConfiguration(prepare: handler)
    }

    static func completion(_ handler: @escaping Handler) -> FlowConfiguration {
        FlowConfiguration(completion: handler)
    }

    static func combine(_ configurations: [FlowConfiguration]) -> FlowConfiguration {
        FlowConfiguration(
            prepare: { departure, destination in
                for configuration in configurations {
                    configuration.prepareHandler?(departure, destination)
                }
            },
            completion:  { departure, destination in
                for configuration in configurations {
                    configuration.completionHandler?(departure, destination)
                }
            }
        )
    }

    static func combine(_ configurations: FlowConfiguration...) -> FlowConfiguration {
        combine(configurations)
    }
}
