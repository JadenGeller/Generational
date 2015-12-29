//
//  Subsequence.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct IteratingSequence<Element>: SequenceType {
    private let initialValue: Element
    private let transform: Element -> Element
    
    public init(initialValue: Element, transform: Element -> Element) {
        self.initialValue = initialValue
        self.transform = transform
    }
    
    public func generate() -> IteratingGenerator<Element> {
        return IteratingGenerator(initialValue: initialValue, transform: transform)
    }
}

public struct IteratingGenerator<Element>: GeneratorType {
    private var value: Element
    private let transform: Element -> Element
    
    public init(initialValue: Element, transform: Element -> Element) {
        self.value = initialValue
        self.transform = transform
    }
    
    public mutating func next() -> Element? {
        let returnValue = value
        value = transform(value)
        return returnValue
    }
}

public func iterate<Element>(initialValue initialValue: Element, transform: Element -> Element) -> IteratingSequence<Element> {
    return IteratingSequence(initialValue: initialValue, transform: transform)
}
