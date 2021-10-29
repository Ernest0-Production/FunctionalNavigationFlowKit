//
//  FlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

/// An object that intercept start and end of flow execution.
public final class FlowConfiguration<Departure, Destination> {
    public typealias Handler = (_ departure: Departure, _ destination: Destination) -> Void

    init(preparation: Handler?, completion: Handler?) {
        self.preparationHandler = preparation
        self.completionHandler = completion
    }

    public let preparationHandler: Handler?
    public let completionHandler: Handler?
}
