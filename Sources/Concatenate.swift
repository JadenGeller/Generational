//
//  Concatenate.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct ConcatenatingSequence<LeftBase: SequenceType, RightBase: SequenceType where LeftBase.Generator.Element == RightBase.Generator.Element> : SequenceType {
    private let left: LeftBase
    private let right: RightBase
    
    public init(_ left: LeftBase, _ right: RightBase) {
        self.left = left
        self.right = right
    }
    
    public func generate() -> ConcatenatingGenerator<LeftBase.Generator, RightBase.Generator> {
        return ConcatenatingGenerator(left.generate(), right.generate())
    }
}

public struct ConcatenatingGenerator<LeftBase: GeneratorType, RightBase: GeneratorType where LeftBase.Element == RightBase.Element> : GeneratorType {
    private var left: LeftBase
    private var right: RightBase
    
    public init(_ left: LeftBase, _ right: RightBase) {
        self.left = left
        self.right = right
    }
    
    public mutating func next() -> LeftBase.Element? {
        return left.next() ?? right.next()
    }
}

public func +<S0: SequenceType, S1: SequenceType where S0.Generator.Element == S1.Generator.Element>(lhs: S0, rhs: S1) -> ConcatenatingSequence<S0, S1> {
    return ConcatenatingSequence(lhs, rhs)
}