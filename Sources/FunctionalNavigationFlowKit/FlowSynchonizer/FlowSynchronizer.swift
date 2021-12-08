//
//  File.swift
//  
//
//  Created by Ernest Babayan on 19.11.2021.
//

/// An object that organize action execution in a thread-safe manner.
public final class FlowSynchronizer {
    public typealias Action = () -> Void

    /// - Parameter synchronization: Closure that should prepare and organize thread-safety environment and execute given action.
    public init(_ synchronization: @escaping (@escaping Action) -> Void) {
        self.synchronization = synchronization
    }

    private let synchronization: (@escaping Action) -> Void

    func sync(_ action: @escaping Action) {
        synchronization(action)
    }
}
