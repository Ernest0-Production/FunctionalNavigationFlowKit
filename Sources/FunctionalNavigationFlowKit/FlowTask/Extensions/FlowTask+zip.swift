//
//  File.swift
//  
//
//  Created by Ernest Babayan on 20.11.2021.
//

import Foundation


public extension FlowTask {
    /// Compose flow tasks into one task that executes them concurrently and call completion handler when completes all tasks.
    ///
    /// - Example:
    ///
    ///       FlowTask.zip([
    ///          // Update shared map view state
    ///           .create { competionHandler in
    ///               Flow.displayMapState(
    ///                   in: mapViewController,
    ///                   .route(path: coordinates),
    ///                   completion: completionHandler
    ///               )
    ///           },
    ///           // Present corresponding drawer card view
    ///           .create { completion in
    ///              Flow.present(
    ///                  in: rootViewController,
    ///                  animated: true
    ///                  RouteDrawerViewController(...),
    ///                  completion: completionHandler
    ///              )
    ///           }
    ///       ])
    ///
    /// - Parameter tasks: Flow tasks that executes concurrently.
    ///
    /// - Returns: Flow that concurrent execute passed tasks.
    static func zip<TaskCollection: Collection>(_ tasks: TaskCollection) -> FlowTask where TaskCollection.Element == FlowTask {
        FlowTask.create({ completion in
            let lock = NSRecursiveLock()
            var counter = tasks.count

            for task in tasks {
                task.execute(onComplete: {
                    lock.lock(); defer { lock.unlock() }
                    counter -= 1

                    if counter == 0 {
                        completion()
                    }
                })
            }

            return Flow.empty
        })
    }

    /// Compose flow tasks into one task that executes them concurrently and call completion handler when completes all tasks.
    ///
    /// - Example:
    ///
    ///       return FlowTask
    ///           .create { competionHandler in
    ///               Flow.displayMapState(
    ///                   in: mapViewController,
    ///                   .route(path: coordinates),
    ///                   completion: completionHandler
    ///               )
    ///           }
    ///           .zip(.create { completion in
    ///              Flow.present(
    ///                  in: rootViewController,
    ///                  animated: true
    ///                  RouteDrawerViewController(...),
    ///                  completion: completionHandler
    ///              )
    ///           })
    ///
    /// - Parameter tasks: Flow tasks that executes concurrently.
    ///
    /// - Returns: Flow that concurrent execute this and passed tasks.
    func zip(_ tasks: FlowTask...) -> FlowTask {
        FlowTask.zip([self] + tasks)
    }
}
