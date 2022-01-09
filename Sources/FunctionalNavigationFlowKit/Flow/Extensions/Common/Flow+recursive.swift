//
//  File.swift
//  
//
//  Created by Ernest Babayan on 02.06.2021.
//

public extension Flow {
    /// Allows recursively reference to the flow building inside flow building.
    ///
    /// - Parameters:
    ///   - input: Initial input value for building flow.
    ///
    ///   - body: Flow building implemantation that takes required inputs and reference to closure that execute same.
    ///
    /// - Returns: Flow that execute passed flow implementation.
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

    /// Allows recursively reference to the flow building inside flow building.
    ///
    /// - Parameter body: Flow building implemantation that takes reference to closure that execute same.
    ///
    /// - Returns: Flow that execute passed flow implementation.
    static func recursive(
        _ body: @escaping (_ itself: @escaping () -> Flow) -> Flow
    ) ->  Flow {
        Flow.recursive(initialInput: ()) { void, flowFactory in
            body({ flowFactory(void) })
        }
    }
}
