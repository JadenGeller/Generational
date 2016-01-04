//
//  Peekable.swift
//  Generational
//
//  Created by Jaden Geller on 1/3/16.
//  Copyright © 2016 Jaden Geller. All rights reserved.
//

public struct PeekableSequence<Base: SequenceType>: SequenceType {
    private let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public func generate() -> PeekableGenerator<Base.Generator> {
        return PeekableGenerator(base.generate())
    }
}

public struct PeekableGenerator<Base: GeneratorType>: GeneratorType {
    private var base: Base
    private var _next: Base.Element?
    
    public init(_ base: Base) {
        self.base = base
    }

    public mutating func next() -> Base.Element? {
        defer { _next = nil }
        return _next ?? base.next()
    }

    public mutating func peek() -> Base.Element? {
        if _next == nil { _next = base.next() }
        return _next
    }
}
