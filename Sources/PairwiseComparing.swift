//
//  Comparing.swift
//  Generational
//
//  Created by Jaden Geller on 12/29/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public enum PairwiseComparison<Element> {
    case Initial(Element)
    case Pair(Element, Element)
    case Final(Element)
}

public func ==<Element: Equatable>(lhs: PairwiseComparison<Element>, rhs: PairwiseComparison<Element>) -> Bool {
    switch (lhs, rhs) {
    case let (.Initial(l), .Initial(r)):     return l == r
    case let (.Pair(l1, l2), .Pair(r1, r2)): return l1 == r1 && l2 == r2
    case let (.Final(l), .Final(r)):         return l == r
    default:                                 return false
    }
}

public struct PairwiseComparisonSequence<Base: SequenceType>: SequenceType {
    private let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public func generate() -> PairwiseComparisonGenerator<Base.Generator> {
        return PairwiseComparisonGenerator(base.generate())
    }
}

public struct PairwiseComparisonGenerator<Base: GeneratorType>: GeneratorType {
    private var base: Base
    private var previous: Base.Element?
    
    public init(_ base: Base){
        self.base = base
    }
    
    public mutating func next() -> PairwiseComparison<Base.Element>? {
        let next = base.next()
        defer { self.previous = next }
        
        switch (previous, next) {
        case let (nil, next?):       return .Initial(next)
        case let (previous?, next?): return .Pair(previous, next)
        case let (previous?, nil):   return .Final(previous)
        default:                     return nil
        }
    }
}

extension SequenceType {
    public func pairwiseComparison() -> PairwiseComparisonSequence<Self> {
        return PairwiseComparisonSequence(self)
    }
}
