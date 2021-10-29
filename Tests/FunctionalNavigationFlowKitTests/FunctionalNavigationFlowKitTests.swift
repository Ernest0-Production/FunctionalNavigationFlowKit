import Combine
import FunctionalNavigationFlowKit
import XCTest

final class FunctionalNavigationFlowKitTests: XCTestCase {
    func test_concatFlow() {
        var steps: [Int] = []
        var completeFiveStep: () -> Void = {}

        FlowTask.concat([
            FlowTask.just(Flow.just(steps.append(0))),

            FlowTask.just(Flow.just(steps.append(1))),

            FlowTask.just(Flow.just(steps.append(2))),

            FlowTask.just(Flow.just(steps.append(3))),

            FlowTask.just(Flow.just(steps.append(4))),

            FlowTask.create({ completion in
                completeFiveStep = {
                    steps.append(5)
                    completion()
                }
                return Flow.empty
            }),

            FlowTask.create({ completion in
                steps.append(6)
                completion()
                return Flow.empty
            }),
        ]).execute(onComplete: {})

        XCTAssertEqual(steps, [0, 1, 2, 3, 4])
        completeFiveStep()
        XCTAssertEqual(steps, [0, 1, 2, 3, 4, 5, 6])
    }

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

    func test_zipTask() {
        var steps: [Int] = []
        var completeAsyncTask: () -> Void = {}

        FlowTask.zip([
            FlowTask.just(Flow.just(steps.append(0))),

            FlowTask.create({ completion in
                completeAsyncTask = {
                    steps.append(1)
                    completion()
                }
                return Flow.empty
            }),

            FlowTask.just(Flow.just(steps.append(2))),
        ]).execute(onComplete: {})

        XCTAssertEqual(steps, [0, 2])
        completeAsyncTask()
        XCTAssertEqual(steps, [0, 2, 1])
    }

    @available(macOS 10.15, iOS 13.0, *)
    func test_taskPublisher() {
        var completeTask: () -> Void = {}

        let task = FlowTask.create({ completion in
            completeTask = completion
            return Flow.empty
        })

        var isExecuted = false
        var isFinished = false

        task.publisher.subscribe(
            Subscribers.Sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        isFinished = true
                    case let .failure(error):
                        XCTFail(error.localizedDescription)
                    }

                },
                receiveValue: { isExecuted = true })
        )

        XCTAssertFalse(isExecuted)
        XCTAssertFalse(isFinished)

        completeTask()

        XCTAssertTrue(isExecuted)
        XCTAssertTrue(isFinished)
    }

    func test_taskRetainAnyObject() {
        weak var weakAnyObject: AnyObject?
        var task: FlowTask?

        do {
            let anyObject = NSObject()
            weakAnyObject = anyObject

            task = FlowTask.never.retain(anyObject)
        }

        XCTAssertNotNil(weakAnyObject)
        task = nil
        XCTAssertNil(weakAnyObject)

        _ = task // to hide warning about redundant variable
    }
}
