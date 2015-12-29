//
//  FullZip.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct FullZip2Sequence<LeftBase: SequenceType, RightBase: SequenceType>: SequenceType {
    private let left: LeftBase
    private let right: RightBase
    
    public init(_ left: LeftBase, _ right: RightBase) {
        self.left = left
        self.right = right
    }
    
    public func generate() -> FullZip2Generator<LeftBase.Generator, RightBase.Generator> {
        return FullZip2Generator(left.generate(), right.generate())
    }
}

public struct FullZip2Generator<LeftBase: GeneratorType, RightBase: GeneratorType>: GeneratorType {
    private var left: LeftBase
    private var right: RightBase
    
    public init(_ left: LeftBase, _ right: RightBase) {
        self.left = left
        self.right = right
    }
    
    public mutating func next() -> (LeftBase.Element?, RightBase.Element?)? {
        let leftValue = left.next()
        let rightValue = right.next()
        guard leftValue != nil || rightValue != nil else { return nil }
        return (leftValue, rightValue)
    }
}

public func fullZip<LeftBase: SequenceType, RightBase: SequenceType>(left: LeftBase, _ right: RightBase) -> FullZip2Sequence<LeftBase, RightBase> {
    return FullZip2Sequence(left, right)
}

public func fullZip<LeftBase: SequenceType, RightBase: SequenceType>(left: LeftBase, _ right: RightBase, defaultValues: (LeftBase.Generator.Element, RightBase.Generator.Element)) -> LazyMapSequence<FullZip2Sequence<LeftBase, RightBase>, (LeftBase.Generator.Element, RightBase.Generator.Element)> {
    return LazyMapSequence(FullZip2Sequence(left, right)) { (l, r) in
        return (l ?? defaultValues.0, r ?? defaultValues.1)
    }
}

