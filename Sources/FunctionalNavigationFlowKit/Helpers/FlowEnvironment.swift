//
//  File.swift
//  
//
//  Created by Ernest Babayan on 08.12.2021.
//

/// Framework environment that define global behavior of some internal processes.
public enum FlowEnvironment {
    /// Handler of internal framework exceptions.
    ///
    /// Override it if you need to track/log events or change the default behavior (i.e. assertionFailure) in certain build configurations.
    public static var exceptionsHandler: ExceptionHandler = .assertionFailure

    public struct ExceptionHandler {
        public struct Exception {
            public let message: String
            public let file: StaticString
            public let line: UInt
        }

        let `throw`: (Exception) -> Void

        public init(onThrow: @escaping (Exception) -> Void) { self.throw = onThrow }

        /// ExceptionHandler that call assertionFailure when throwing exception.
        static let assertionFailure = Self(onThrow: { (exception: Exception) in
            Swift.assertionFailure(exception.message, file: exception.file, line: exception.line)
        })

        /// ExceptionHandler that do nothing when throwing exception.
        static let none = Self(onThrow: { _ in })

        /// ExceptionHandler that do nothing when throwing exception.
        static let consolePrint = Self(onThrow: { (exception: Exception) in
            Swift.print("[\(exception.file) line \(exception.line)] \(exception.message)")
        })
    }

    /// Default text output stream that log messages from internal framework actions, such as operator `Flow.log(prefix:to:)` or `FlowConfiguration.log(prefix:to:)`.
    public static var defaultLogStream: () -> TextOutputStream = DefaultLogStream.init

    public final class DefaultLogStream: TextOutputStream {
        public func write(_ string: String) { Swift.print(string) }
    }
}
