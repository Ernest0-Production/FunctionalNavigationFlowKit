//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.02.2022.
//

import Foundation


public extension Flow {
    /// Execute flow once. Re-execution will do nothing.
    ///
    /// - Parameter condition: Manager of state that control when flow can be executed.
    ///
    /// - Returns: Flow that execute this flow once.
    func once(by condition: OnceCondition = .toogleBoolean) -> Flow {
        Flow({ [self] in
            guard condition.canExecute() else { return }

            condition.willExecute()
            execute()
            condition.didExecute()
        })
    }

    struct OnceCondition {
        public init(willExecute: @escaping () -> Void, didExecute: @escaping () -> Void, canExecute: @escaping () -> Bool) {
            self.willExecute = willExecute
            self.didExecute = didExecute
            self.canExecute = canExecute
        }

        let willExecute: () -> Void
        let didExecute: () -> Void
        let canExecute: () -> Bool
    }
}

public extension Flow.OnceCondition {
    static var toogleBoolean: Self {
        var isExecuted = false

        return Self(
            willExecute: { isExecuted = true },
            didExecute: {},
            canExecute: { !isExecuted }
        )
    }

    static func userDefaults(
        key: String,
        in userDefauls: UserDefaults = .standard
    ) -> Self {
        return Self(
            willExecute: { userDefauls.set(true, forKey: key) },
            didExecute: {},
            canExecute: { !userDefauls.bool(forKey: key) }
        )
    }
}
