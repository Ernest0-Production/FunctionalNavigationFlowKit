//
//  File.swift
//  
//
//  Created by Ernest Babayan on 08.12.2021.
//

public enum FlowEnvironment {
    /// Handler of internal framework exceptions.
    ///
    /// Override it if you need to track/log events or change the default behavior (i.e. assertionFailure) in certain build configurations.
    public static var exceptionsHandler: (
        _ message: @autoclosure () -> String,
        _ file: StaticString,
        _ line: UInt
    ) -> Void = assertionFailure

    public static var defaultLogTextOutputStream: TextOutputStream = DefaultLogTextOutputStream()

    public final class DefaultLogTextOutputStream: TextOutputStream {
        public func write(_ string: String) { Swift.print(string) }
    }
}
