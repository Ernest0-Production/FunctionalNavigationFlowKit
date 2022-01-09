//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension Flow {
    /// Wraps this flow into another.
    func transform(_ transformation: (Flow) -> Flow) -> Flow {
        transformation(self)
    }
}
