//
//  File.swift
//  
//
//  Created by Ernest Babayan on 19.11.2021.
//

import Foundation


public extension FlowTaskQueue {
    /// An object that organize action execution in a thread-safe manner.
    final class Synchronizer {
        public typealias Action = () -> Void

        /// - Parameter synscronization: Closure that should prepare and organize thread-safety environment and execute given action.
        public init(_ synscronization: @escaping (@escaping Action) -> Void) {
            self.synscronization = synscronization
        }

        private let synscronization: (@escaping Action) -> Void

        func sync(_ action: @escaping Action) {
            synscronization(action)
        }
    }
}


public extension FlowTaskQueue.Synchronizer {
    ///  Synchronizer that provides thread safety using NSRecursiveLock.
    static var `default`: FlowTaskQueue.Synchronizer {
        FlowTaskQueue.Synchronizer.lock(NSRecursiveLock())
    }
}
