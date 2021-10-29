//
//  File.swift
//  
//
//  Created by Ernest Babayan on 14.11.2021.
//

public extension FlowConfiguration {
    /// Null object. Configuration that does nothing.
    static var empty: FlowConfiguration { FlowConfiguration(preparation: nil, completion: nil) }
}
