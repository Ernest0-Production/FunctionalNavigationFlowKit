//
//  FlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public final class FlowConfiguration<Departure, Destination> {
    public typealias Handler = (_ departure: Departure, _ destination: Destination) -> Void

    public init(preparation: Handler?, completion: Handler?) {
        self.preparationHandler = preparation
        self.completionHandler = completion
    }

    public let preparationHandler: Handler?
    public let completionHandler: Handler?
}


public extension FlowConfiguration {
    static var empty: FlowConfiguration { FlowConfiguration(preparation: nil, completion: nil) }

    static func preparation(_ handler: @escaping Handler) -> FlowConfiguration {
        FlowConfiguration(preparation: handler, completion: nil)
    }
    static func completion(_ handler: @escaping Handler) -> FlowConfiguration {
        FlowConfiguration(preparation: nil, completion: handler)
    }

    static func combine(_ configurations: [FlowConfiguration]) -> FlowConfiguration {
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

    static func combine(_ configurations: FlowConfiguration...) -> FlowConfiguration {
        combine(configurations)
    }
}
