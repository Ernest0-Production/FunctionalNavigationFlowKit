//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension Flow {
    /// Allow transform this flow into another.
    ///
    /// Useful when you need to add some change using dot syntax to compose chains of transformations and configurations.
    ///
    /// - Parameter transformation: Gets this flow and returns another flow.
    ///
    /// - Returns: Transformed flow.
    func transform(_ transformation: (Flow) -> Flow) -> Flow {
        transformation(self)
    }
}
