//
//  FlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit



public final class FlowConfiguration<Departure, Destination> {
    public typealias Handler = (_ departure: Departure, _ destination: Destination) -> Void

    public init(_ handler: @escaping Handler) {
        self.handler = handler
    }

    let handler: Handler
}


public extension FlowConfiguration {
    static var empty: FlowConfiguration {
        FlowConfiguration({ _, _ in })
    }

    static func combine(_ configurations: [FlowConfiguration]) -> FlowConfiguration {
        FlowConfiguration({ departure, destination in
            for configuration in configurations {
                configuration.handler(departure, destination)
            }
        })
    }

    static func combine(_ configurations: FlowConfiguration...) -> FlowConfiguration {
        FlowConfiguration({ departure, destination in
            for configuration in configurations {
                configuration.handler(departure, destination)
            }
        })
    }
}
