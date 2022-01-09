//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension Flow {
    /// Middleware fow adding any side effects that should not affect on the flow execution.
    ///
    /// - Parameters:
    ///   - beforeStart: executes before starting flow execution.
    ///
    ///   - afterStart: executes after starting flow execution.
    ///
    /// - Returns: Flow that incapsulate side effects while executing this flow.
    func sideEffect(
        beforeStart: Optional<() -> Void> = .none,
        afterStart: Optional<() -> Void> = .none
    ) -> Flow {
        Flow({ [self] in
            beforeStart?()
            execute()
            afterStart?()
        })
    }
}
