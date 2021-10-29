//
//  File.swift
//  
//
//  Created by Ernest Babayan on 20.11.2021.
//

private let tag = "[FunctionalNavigationFlowKit]"

func logPrefix(with userDefinedPrefix: String?) -> String {
    if let userDefinedPrfix = userDefinedPrefix {
        return "\(tag) \(userDefinedPrfix):"
    } else {
        return tag
    }
}
