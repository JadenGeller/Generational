//
//  LazyDropSequence.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct LazyDropSequence<Base: SequenceType>: SequenceType {
    public let base: Base
    public let dropCondition: Base.Generator.Element -> Bool
    
    public init(_ base: Base, dropCondition: Base.Generator.Element -> Bool) {
        self.base = base
        self.dropCondition = dropCondition
    }
    
    public func generate() -> LazyDropGenerator<Base.Generator> {
        return LazyDropGenerator(base.generate(), dropCondition: dropCondition)
    }
}

public struct LazyDropGenerator<Base: GeneratorType>: GeneratorType {
    public var base: Base
    public var dropping = true
    public let dropCondition: Base.Element -> Bool
    
    public init(_ base: Base, dropCondition: Base.Element -> Bool) {
        self.base = base
        self.dropCondition = dropCondition
    }
    
    public mutating func next() -> Base.Element? {
        var element = base.next()
        if dropping {
            while element.map(dropCondition) ?? false {
                element = base.next()
            }
            dropping = false
        }
        return element
    }
}

extension SequenceType {
    func dropWhile(dropCondition: Generator.Element -> Bool) -> LazyDropSequence<Self> {
        return LazyDropSequence(self, dropCondition: dropCondition)
    }
}

extension SequenceType where Generator.Element: Equatable {
    func dropUntil(element: Generator.Element) -> LazyDropSequence<Self> {
        return LazyDropSequence(self, dropCondition: { $0 != element })
    }
}

