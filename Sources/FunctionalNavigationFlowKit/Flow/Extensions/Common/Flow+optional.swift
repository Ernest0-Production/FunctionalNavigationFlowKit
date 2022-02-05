//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

public extension Optional where Wrapped == Flow {
    var orEmpty: Wrapped {
        replaceNil(on: Wrapped.empty)
    }

    func replaceNil(on defaultFlow: Wrapped) -> Wrapped {
        switch self {
        case let Optional.some(flow):
            return flow
        case Optional.none:
            return defaultFlow
        }
    }

    func replaceNil(on defaultFlow: Optional<Wrapped>) -> Wrapped? {
        switch self {
        case let Optional.some(flow):
            return flow
        case Optional.none:
            return defaultFlow
        }
    }
}
