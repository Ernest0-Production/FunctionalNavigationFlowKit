//
//  Flow+DispatchQueue.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import Foundation


public extension Flow {
    /// Schedule flow execution in the specific synchronized environment (such as DispatchQueue or NSLocking).
    ///
    /// - Parameter synchronizer: A way to organize safety execution of task.
    ///
    /// - Returns: Flow that execute this flow in the specific synchronized environment.
    func synchonize(with synchonizer: FlowSynchronizer) -> Flow {
        Flow({ [self] in
            synchonizer.sync(execute)
        })
    }
}
