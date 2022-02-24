//
//  Flow.swift
//
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

/// A command object that wraps some action.
public final class Flow {
    init(_ body: @escaping () -> Void) { self.body = body }

    private let body: () -> Void

    /// Run flow execution.
    public func execute() { body() }
}