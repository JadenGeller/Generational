//
//  LazyTakeSequence.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct LazyTakeSequence<Base: SequenceType>: SequenceType {
    public let base: Base
    public let takeCondition: Base.Generator.Element -> Bool
    
    public init(_ base: Base, takeCondition: Base.Generator.Element -> Bool) {
        self.base = base
        self.takeCondition = takeCondition
    }
    
    public func generate() -> LazyTakeGenerator<Base.Generator> {
        return LazyTakeGenerator(base.generate(), takeCondition: takeCondition)
    }
}

public struct LazyTakeGenerator<Base: GeneratorType>: GeneratorType {
    public var base: Base
    public var taking = true
    public let takeCondition: Base.Element -> Bool
    
    public init(_ base: Base, takeCondition: Base.Element -> Bool) {
        self.base = base
        self.takeCondition = takeCondition
    }
    
    public mutating func next() -> Base.Element? {
        guard taking else { return nil }
        guard let element = base.next() else { return nil }
        
        if takeCondition(element) { return element }
        else {
            taking = false
            return nil
        }
    }
}

extension SequenceType {
    func takeWhile(takeCondition: Generator.Element -> Bool) -> LazyTakeSequence<Self> {
        return LazyTakeSequence(self, takeCondition: takeCondition)
    }
}


extension SequenceType where Generator.Element: Equatable {
    func takeUntil(element: Generator.Element) -> LazyDropSequence<Self> {
        return LazyDropSequence(self, dropCondition: { $0 != element })
    }
}

