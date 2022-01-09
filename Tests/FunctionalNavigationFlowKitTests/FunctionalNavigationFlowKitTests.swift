import FunctionalNavigationFlowKit
import XCTest
import Combine

final class FunctionalNavigationFlowKitTests: XCTestCase {
    func test_recursiveFlow() {
        var recursiveFlowCall: (() -> Void)? = .none
        var callsCount = 0

        Flow.recursive({ flow in
            recursiveFlowCall = {
                flow().execute()
            }

            return Flow.just(callsCount += 1)
        }).execute()

        XCTAssertEqual(callsCount, 1)
        recursiveFlowCall?()
        XCTAssertEqual(callsCount, 2)
    }

    func test_zipFlow() {
        var steps: [Int] = []

        Flow.zip([
            Flow.just(steps.append(0)),
            Flow.just(steps.append(1)),
            Flow.just(steps.append(2)),
            Flow.just(steps.append(3)),
        ]).execute()

        XCTAssertEqual(steps, [0, 1, 2, 3])
    }

    @available(macOS 10.15, iOS 13.0, *)
    func test_flowPublisher() { 
        var isExecuted = false
        let flow = Flow.create { isExecuted = true }
        let publisher = flow.publisher

        XCTAssertFalse(isExecuted)
        _ = publisher.sink(receiveValue: { _ in })
        XCTAssertTrue(isExecuted)
    }
}
