//
//  Lookahead.swift
//  Generational
//
//  Created by Jaden Geller on 1/3/16.
//  Copyright © 2016 Jaden Geller. All rights reserved.
//

public struct LookaheadSequence<Base: SequenceType>: SequenceType {
    private let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public func generate() -> LookaheadGenerator<Base.Generator> {
        return LookaheadGenerator(base.generate())
    }
}

public struct LookaheadGenerator<Base: GeneratorType>: GeneratorType {
    private var base: Base
    private var buffer: [Base.Element] = []
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public mutating func lookahead(distance: Int) -> Base.Element? {
        while distance >= buffer.count {
            guard let value = base.next() else { return nil }
            buffer.append(value)
        }
        return buffer[distance]
    }
    
    public mutating func lookahead(range: Range<Int>) -> [Base.Element] {
        return Array(range.map{ lookahead($0) }.unwrap())
    }
    
    public mutating func next() -> Base.Element? {
        if buffer.count == 0 { return base.next() }
        else                 { return buffer.removeFirst() }
    }
}
