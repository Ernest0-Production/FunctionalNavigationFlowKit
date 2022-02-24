//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

public extension Optional where Wrapped == Flow {
    /// Return Flow.empty when this flow is nil.
    var orEmpty: Wrapped {
        replaceNil(on: Wrapped.empty)
    }

    /// Return passed flow when this flow is nil.
    func replaceNil(on defaultFlow: Wrapped) -> Wrapped {
        switch self {
        case let Optional.some(flow):
            return flow
        case Optional.none:
            return defaultFlow
        }
    }

    /// Return passed flow when this flow is nil.
    func replaceNil(on defaultFlow: Optional<Wrapped>) -> Wrapped? {
        switch self {
        case let Optional.some(flow):
            return flow
        case Optional.none:
            return defaultFlow
        }
    }
}
