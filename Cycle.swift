//
//  Cycle.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct CyclicSequence<Base: CollectionType>: SequenceType {
    private let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public func generate() -> CyclicGenerator<Base> {
        return CyclicGenerator(base)
    }
}

public struct CyclicGenerator<Base: CollectionType>: GeneratorType {
    private let base: Base
    private var index: Base.Index
    
    public init(_ base: Base) {
        self.base = base
        self.index = base.startIndex
    }
    
    public mutating func next() -> Base.Generator.Element? {
        let value = base[index]
        index = index.successor()
        if index == base.endIndex { index = base.startIndex }
        return value
    }
}

extension CollectionType {
    func cycle() -> CyclicSequence<Self> {
        return CyclicSequence(self)
    }
}