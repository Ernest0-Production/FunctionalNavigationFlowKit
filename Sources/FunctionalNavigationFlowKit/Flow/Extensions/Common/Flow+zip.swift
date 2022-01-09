//
//  Flow+zip.swift
//  
//
//  Created by Ernest on 12.07.2021.
//

public extension Flow {
    /// Concatenates several flows into one.
    ///
    /// - Example:
    ///
    ///       Flow.zip([
    ///          // Update master navigation stack controller
    ///          .push(
    ///              in: masterNavigationController,
    ///              animated: true,
    ///              SettingsListViewController(...)
    ///          )
    ///           // Update details navigation stack controller
    ///          .setStack(
    ///              in: detailsNavigationController,
    ///              animated: false,
    ///              [ProfileSettingsViewController(...)]
    ///          )
    ///       ])
    ///
    /// - Parameter flows: Ordered list of the flow that should be executed serially.
    ///
    /// - Returns: Flow that will serially execute passed list of flow.
    static func zip<FlowSequence: Sequence>(_ flows: FlowSequence) -> Flow where FlowSequence.Element == Flow {
        flows.reduce(Flow.empty, { $0.then($1) })
    }

    /// Concatenates the passed flow after this flow.
    ///
    /// - Example:
    ///
    ///       return Flow
    ///           .push(
    ///               in: masterNavigationController,
    ///               animated: true,
    ///               SettingsListViewController(...)
    ///           )
    ///           .then(.setStack(
    ///               in: detailsNavigationController,
    ///               animated: false,
    ///               [ProfileSettingsViewController(...)]
    ///           ))
    ///
    /// - Parameter flows: Ordered list of the flow that should be executed serially.
    ///
    /// - Returns: Flow that will serially execute this and passed flows.
    func then(_ nextFlow: Flow) -> Flow {
        Flow({
            self.execute()
            nextFlow.execute()
        })
    }
}
