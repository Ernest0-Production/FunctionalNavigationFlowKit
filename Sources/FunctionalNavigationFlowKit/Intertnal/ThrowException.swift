//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.02.2022.
//

func throwException(_ message: String, file: StaticString = #file, line: UInt = #line) {
    FlowEnvironment.exceptionsHandler.throw(FlowEnvironment.ExceptionHandler.Exception(
        message: message,
        file: file,
        line: line
    ))
}
