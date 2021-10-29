//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

extension Optional where Wrapped == TextOutputStream {
    var orDefault: Wrapped {
        switch self {
        case let .some(stream):
            return stream
        case .none:
            return defaultStream
        }
    }
}

private let defaultStream: TextOutputStream = PrintTextOutputStream()

private final class PrintTextOutputStream: TextOutputStream {
    func write(_ string: String) { Swift.print(string) }
}
