//
//  File.swift
//  
//
//  Created by Ernest on 12.07.2021.
//

public func ConcatFlow(_ flows: [Flow]) -> Flow {
    return { for flow in flows { flow() } }
}
