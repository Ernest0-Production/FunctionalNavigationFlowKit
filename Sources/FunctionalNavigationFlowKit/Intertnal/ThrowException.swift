//
//  File.swift
//  
//
//  Created by Ernest Babayan on 13.01.2022.
//

func throwException(_ message: String, file: StaticString = #file, line: UInt = #line) {
    FlowEnvironment.exceptionsHandler(message, file, line)
}
