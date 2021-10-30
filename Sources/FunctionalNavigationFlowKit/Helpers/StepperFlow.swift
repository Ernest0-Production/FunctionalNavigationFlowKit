//
//  File.swift
//  
//
//  Created by Ernest Babayan on 30.10.2021.
//

public func StepperFlow<Steps: Sequence>(
    _ steps: Steps,
    stepFlow: @escaping (Steps.Element, @escaping Flow) -> Flow?
) -> Flow {
    LazyFlow({
        var iterator = steps.makeIterator()

        guard let firstStep = iterator.next() else { return EmptyFlow }

        return RecursiveFlow(with: firstStep, { (step: Steps.Element, nextStepFlow: @escaping (Steps.Element) -> Flow) in
            stepFlow(step, { iterator.next().map(nextStepFlow)?() }) ?? EmptyFlow
        })
    })
}
