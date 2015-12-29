//
//  RepeatedValue.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct RepeatedValueSequence<Element>: SequenceType {
    private let value: Element
    
    public init(_ value: Element) {
        self.value = value
    }
    
    public func generate() -> RepeatedValueGenerator<Element> {
        return RepeatedValueGenerator<Element>(value)
    }
}

public struct RepeatedValueGenerator<Element>: GeneratorType {
    private let value: Element
    
    public init(_ value: Element) {
        self.value = value
    }
    
    public func next() -> Element? {
        return value
    }
}

extension SequenceType {
    public func extend(byRepeatingValue value: Generator.Element) -> ConcatenatingSequence<Self, RepeatedValueSequence<Generator.Element>> {
        return ConcatenatingSequence(self, RepeatedValueSequence(value))
    }
}
