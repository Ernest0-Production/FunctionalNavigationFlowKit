//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

public extension Optional where Wrapped == FlowTask {
    var orEmpty: Wrapped {
        replaceNil(on: Wrapped.empty)
    }

    var orNever: Wrapped {
        replaceNil(on: Wrapped.never)
    }

    func replaceNil(on defaultTask: Wrapped) -> Wrapped {
        switch self {
        case let Optional.some(task):
            return task
        case Optional.none:
            return defaultTask
        }
    }

    func replaceNil(on defaultTask: Wrapped?) -> Wrapped? {
        switch self {
        case let Optional.some(task):
            return task
        case Optional.none:
            return defaultTask
        }
    }
}
