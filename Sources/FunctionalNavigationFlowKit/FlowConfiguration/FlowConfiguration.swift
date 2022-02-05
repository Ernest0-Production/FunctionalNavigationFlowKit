//
//  FlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

/// An object that intercept start and end of flow execution.
public final class FlowConfiguration<Departure, Destination> {
    public typealias Handler = (_ departure: Departure, _ destination: Destination) -> Void

    public init(preparation: Optional<Handler> = nil, completion: Optional<Handler> = nil) {
        self.preparationHandler = preparation
        self.completionHandler = completion
    }

    public let preparationHandler: Optional<Handler>
    public let completionHandler: Optional<Handler>
}
