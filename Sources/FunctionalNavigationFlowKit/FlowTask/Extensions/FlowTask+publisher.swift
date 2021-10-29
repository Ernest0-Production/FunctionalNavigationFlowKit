//
//  File.swift
//  
//
//  Created by Ernest Babayan on 24.11.2021.
//

import Combine


public extension FlowTask {
    @available(macOS 10.15, iOS 13.0, *)
    /// Publisher representation of task.
    var publisher: FlowTaskPublisher {
        FlowTaskPublisher(task: self)
    }
}

@available(macOS 10.15, iOS 13.0, *)
public struct FlowTaskPublisher: Publisher {
    public typealias Output = Void

    public typealias Failure = Never

    fileprivate init(task: FlowTask) { self.task = task }

    private let task: FlowTask

    public func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Self.Output == S.Input {
        subscriber.receive(subscription: Subscriptions.empty)

        task.execute(onComplete: {
            _ = subscriber.receive(())
            subscriber.receive(completion: .finished)
        })
    }
}

@available(macOS 10.15, iOS 13.0, *)
public extension FlowTaskPublisher {
    func sink(receiveCompletion completionHandler: @escaping FlowTask.CompletionHandler) {
        subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: completionHandler
        ))
    }
}
