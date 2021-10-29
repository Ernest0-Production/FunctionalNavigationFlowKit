//
//  EmptyFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

public extension Flow {
    /// Null object. Flow that does nothing.
    static var empty: Flow { Flow({}) }
}
