//
//  Partitioning.swift
//  Generational
//
//  Created by Jaden Geller on 12/29/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public struct PartitioningSequence<Base: SequenceType>: SequenceType {
    public typealias Generator = PartitioningGenerator<Base.Generator>
    
    private let base: Base
    private let partition: Generator.Partitioner
    
    public init(_ base: Base, partition: Generator.Partitioner) {
        self.base = base
        self.partition = partition
    }
    
    public func generate() -> PartitioningGenerator<Base.Generator> {
        return PartitioningGenerator(base.generate(), partition: partition)
    }
}

public struct PartitioningGenerator<Base: GeneratorType>: GeneratorType {
    public typealias Partitioner = (left: Base.Element, right: Base.Element) -> Bool
    
    let partition: Partitioner
    var base: PairwiseComparisonGenerator<Base>
    
    init(_ base: Base, partition: Partitioner) {
        self.partition = partition
        self.base = PairwiseComparisonGenerator(base)
    }
    
    public mutating func next() -> [Base.Element]? {
        var accumulation: [Base.Element] = []
        
        partitioner: while let pair = base.next() {
            switch pair {
            case .Initial:
                continue
            case .Pair(let left, let right):
                accumulation.append(left)
                if partition(left: left, right: right) { break partitioner }
            case .Final(let value):
                accumulation.append(value)
            }
        }
        
        return accumulation.isEmpty ? nil : accumulation
    }
}

extension SequenceType {
    public func partition(partition: PartitioningSequence<Self>.Generator.Partitioner) -> PartitioningSequence<Self> {
        return PartitioningSequence(self, partition: partition)
    }
}
