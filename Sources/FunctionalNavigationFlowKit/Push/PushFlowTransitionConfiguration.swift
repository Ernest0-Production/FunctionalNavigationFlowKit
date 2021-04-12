//
//  PushFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public extension PushFlowTransitionConfiguration {
    static var hidesBottomBarWhenPushed: PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration({ _, item in
            item.hidesBottomBarWhenPushed = true
        })
    }

    static func title(_ title: String?) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration({ _, item in
            item.navigationItem.title = title
        })
    }

    static func titleView(_ titleView: UIView?) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration({ _, item in
            item.navigationItem.titleView = titleView
        })
    }
}
