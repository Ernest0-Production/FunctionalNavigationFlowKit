import XCTest
@testable import FunctionalNavigationFlowKit

final class FunctionalNavigationFlowKitTests: XCTestCase {
    func testExample() {
//        Flow.present(
//            in: UINavigationController(),
//            ASD.build({ (asdScreen: @escaping Deferred<ASD?>) in
//                .asdScreen(
//                    anotherFlow: .whenExists(asdScreen()) { (asdScreen: ASD) -> Flow in
//                        Flow.dismiss(asdScreen)
//                    }
//                ).withFlow({ asdScreen in
//                    .empty
//                })
//            })
//        ).execute()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

final class ASD: UIViewController {
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    static func asdScreen(anotherFlow: Flow) -> ASD {
        ASD(name: "")
    }
}
