//
//  AlertFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 13.04.2021.
//

import UIKit


public typealias AlertFlowTransitionConfiguration = FlowConfiguration<UIViewController, UIAlertController>


public extension AlertFlowTransitionConfiguration {
    static func actions(_ actions: [UIAlertAction]) -> AlertFlowTransitionConfiguration {
        AlertFlowTransitionConfiguration(prepare: { _ , alert in
            actions.forEach(alert.addAction) 
        })
    }
}
