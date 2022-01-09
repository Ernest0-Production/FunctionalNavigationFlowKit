//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

import Combine


public extension Flow {
    @available(macOS 10.15, iOS 13.0, *)
    var publisher: FlowPublisher { 
        FlowPublisher(flow: self)
    }
}

@available(macOS 10.15, iOS 13.0, *)
public struct FlowPublisher: Publisher {
    public typealias Output = Void
    public typealias Failure = Never

    fileprivate let flow: Flow

    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
        subscriber.receive(subscription: Subscriptions.empty)
        flow.execute()
    }
}