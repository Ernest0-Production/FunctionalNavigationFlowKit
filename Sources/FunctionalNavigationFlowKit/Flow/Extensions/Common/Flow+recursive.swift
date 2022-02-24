//
//  File.swift
//  
//
//  Created by Ernest Babayan on 02.06.2021.
//

public extension Flow {
    /// Build flow that has recursively reference to the self flow build closure.
    ///
    /// - Parameters:
    ///   - input: Initial input value for building flow.
    ///
    ///   - body: Flow building implemantation that takes required inputs and reference to the same flow build closure.
    ///
    /// - Returns: Flow that create and execute passed flow build.
    static func recursive<Input>(
        initialInput: Input,
        _ body: @escaping (Input, _ itself: @escaping (Input) -> Flow) -> Flow
    ) ->  Flow {
        var recursiveFunction: ((Input) -> Flow)!

        recursiveFunction = { (input: Input) -> Flow in
            body(input, recursiveFunction)
        }

        return recursiveFunction(initialInput)
    }

    /// Build flow that has recursively reference to the self flow build closure as input argument of flow build.
    ///
    /// - Parameter body: Flow building implemantation that takes reference to the same flow build closure.
    ///
    /// - Returns: Flow that create and execute passed flow build.
    static func recursive(
        _ body: @escaping (_ itself: @escaping () -> Flow) -> Flow
    ) ->  Flow {
        Flow.recursive(initialInput: ()) { void, flowFactory in
            body({ flowFactory(void) })
        }
    }
}
