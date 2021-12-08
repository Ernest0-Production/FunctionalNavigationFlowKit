//
//  File.swift
//  
//
//  Created by Ernest Babayan on 19.11.2021.
//

/// An object that manages the execution of tasks serially.
public final class FlowTaskQueue {
    private lazy var taskTable = TaskTable()
    private let synchronizer: FlowSynchronizer

    /// Creates a new task queue to which you can submit tasks.
    ///
    /// - Parameter synchronizer: A way to organize thread safety of serial execution.
    public init(synchronizer: FlowSynchronizer) {
        self.synchronizer = synchronizer
    }

    /// Schedules task for execution asynchronously.
    /// 
    /// - Parameter task: The task which must be executed after the completion of the last task in the queue (at the time of the function call). If the queue is empty, the task will start executing immediately.
    public func execute(_ task: FlowTask) {
        synchronizer.sync({ [self] in
            guard taskTable.isEmpty else {
                taskTable.append(task)
                return
            }

            let firstTaskKey = taskTable.append(task)
            executeTaskQueue(from: firstTaskKey)
        })
    }

    /// Cancels execution of all pending tasks. After clear, the next/new task will be performed immediately.
    public func clear() {
        synchronizer.sync({ [self] in
            taskTable.remoteAll()
        })
    }

    private func executeTaskQueue(from key: TaskTable.Key) {
        taskTable.task(for: key)?.execute(onComplete: { [self] in
            synchronizer.sync({
                taskTable.remove(for: key)
                executeTaskQueue(from: key + 1)
            })
        })
    }
}

private struct TaskTable {
    typealias Key = Int
    typealias Task = FlowTask

    var dict: [Key: Task] = [:]
    var lastKey: Key = 0

    var isEmpty: Bool { dict.isEmpty }

    mutating func task(for key: Key) -> Task? { dict[key] }

    mutating func remove(for key: Key) { dict.removeValue(forKey: key) }

    mutating func remoteAll() { dict.removeAll() }

    @discardableResult
    mutating func append(_ task: Task) -> Key {
        let newKey = lastKey + 1
        dict[newKey] = task
        lastKey = newKey
        return newKey
    }
}
