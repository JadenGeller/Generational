//
//  Zip.swift
//  Generational
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct FullZip2Sequence<LeftBase: SequenceType, RightBase: SequenceType>: SequenceType {
    private let left: LeftBase
    private let right: RightBase
    private let defaultValues: (LeftBase.Generator.Element, RightBase.Generator.Element)
    
    public init(_ left: LeftBase, _ right: RightBase, extendingWithDefaultValues defaultValues: (left: LeftBase.Generator.Element, right: RightBase.Generator.Element)) {
        self.left = left
        self.right = right
        self.defaultValues = defaultValues
    }
    
    public func generate() -> FullZip2Generator<LeftBase.Generator, RightBase.Generator> {
        return FullZip2Generator(left.generate(), right.generate(), extendingWithDefaultValues: defaultValues)
    }
}

public struct FullZip2Generator<LeftBase: GeneratorType, RightBase: GeneratorType>: GeneratorType {
    private var left: LeftBase
    private var right: RightBase
    private let defaultValues: (left: LeftBase.Element, right: RightBase.Element)
    
    public init(_ left: LeftBase, _ right: RightBase, extendingWithDefaultValues defaultValues: (LeftBase.Element, RightBase.Element)) {
        self.left = left
        self.right = right
        self.defaultValues = defaultValues
    }
    
    public mutating func next() -> (LeftBase.Element, RightBase.Element)? {
        let leftValue = left.next()
        let rightValue = right.next()
        guard leftValue != nil || rightValue != nil else { return nil }
        return (leftValue ?? defaultValues.0, rightValue ?? defaultValues.1)
    }
}

public func zip<LeftBase: SequenceType, RightBase: SequenceType>(left: LeftBase, _ right: RightBase, extendingWithDefaultValues defaultValues: (LeftBase.Generator.Element, RightBase.Generator.Element)) -> FullZip2Sequence<LeftBase, RightBase> {
    return FullZip2Sequence(left, right, extendingWithDefaultValues: defaultValues)
}

