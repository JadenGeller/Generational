//
//  Unwrapping.swift
//  Generational
//
//  Created by Jaden Geller on 12/30/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

// Required else we'd have to use multiple type arguments
public protocol OptionalType {
    typealias Wrapped
    
    var optionalValue: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optionalValue: Wrapped? {
        return self
    }
}

public struct UnwrappingSequence<Base: SequenceType where Base.Generator.Element: OptionalType>: SequenceType {
    private let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public func generate() -> UnwrappingGenerator<Base.Generator> {
        return UnwrappingGenerator(base.generate())
    }
}

public struct UnwrappingGenerator<Base: GeneratorType where Base.Element: OptionalType>: GeneratorType {
    private var base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public mutating func next() -> Base.Element.Wrapped? {
        while let value = base.next() {
            if let unwrappedValue = value.optionalValue {
                return unwrappedValue
            }
        }
        return nil
    }
}

extension SequenceType where Generator.Element: OptionalType {
    public func unwrap() -> UnwrappingSequence<Self> {
        return UnwrappingSequence(self)
    }
}

