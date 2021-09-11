//
//  File.swift
//  
//
//  Created by Ernest Babayan on 02.06.2021.
//

public func RecursiveFlow<Arguments>(
    _ implementataionFunction: @escaping (Arguments, _ selfFunction: @escaping (Arguments) -> Flow) -> Flow
) -> (Arguments) -> Flow {
    var recursiveFunction: ((Arguments) -> Flow)!
    
    recursiveFunction = { (input: Arguments) -> Flow in
        implementataionFunction(input, recursiveFunction)
    }
    
    return recursiveFunction
}

public func RecursiveFlow<Arguments>(
    with arguments: Arguments,
    _ implementataionFunction: @escaping (Arguments, _ selfFunction: @escaping (Arguments) -> Flow) -> Flow
) ->  Flow {
    RecursiveFlow(implementataionFunction)(arguments)
}

public func RecursiveFlow(
    _ function: @escaping (_ selfFunction: @escaping () -> Flow) -> Flow
) ->  Flow {
    var void: Void { () }
    
    return RecursiveFlow({ (_: Void, rectursiveFuntion) in function({ rectursiveFuntion(void) }) })(void)
}
