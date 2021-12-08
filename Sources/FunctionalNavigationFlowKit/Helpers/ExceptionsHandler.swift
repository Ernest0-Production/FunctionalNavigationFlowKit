//
//  File.swift
//  
//
//  Created by Ernest Babayan on 08.12.2021.
//

/// Handler of internal framework exceptions.
///
/// Override it if you need to track/log events or change the default behavior (i.e. assertionFailure) in certain build configurations.
public var ExceptionsHandler: (
    _ message: @autoclosure () -> String,
    _ file: StaticString,
    _ line: UInt
) -> Void = assertionFailure

func throwException(_ message: String, file: StaticString = #file, line: UInt = #line) {
    ExceptionsHandler(message, file, line)
}
