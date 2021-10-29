//
//  File.swift
//  
//
//  Created by Ernest Babayan on 26.11.2021.
//

@available(macOS 12.0.0, iOS 15.0.0, *)
public extension FlowTask {
    func execute() async {
        await withCheckedContinuation({ continuation in
            execute(onComplete: continuation.resume)
        })
    }
}
