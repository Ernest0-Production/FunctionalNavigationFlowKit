//
//  Flow.swift
//
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

/// A **universal unit** that represent any transition.
public final class Flow {
    init(_ body: @escaping () -> Void) { self.body = body }

    private let body: () -> Void

    /// Run transition.
    public func execute() { body() }
}
