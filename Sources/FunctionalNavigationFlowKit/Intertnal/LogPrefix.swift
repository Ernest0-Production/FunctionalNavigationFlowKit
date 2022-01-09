//
//  File.swift
//  
//
//  Created by Ernest Babayan on 20.11.2021.
//

private let tag = "[FunctionalNavigationFlowKit]"

extension TextOutputStream {
    mutating func write(message: String, withPrefix userDefinedPrefix: String? = nil) {
        if let userDefinedPrfix = userDefinedPrefix {
            write("\(tag) \(userDefinedPrfix) – \(message)")
        } else {
            write("\(tag) \(message)")
        }
    }
}
