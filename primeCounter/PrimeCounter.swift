//
//  PrimeCounter.swift
//  primeCounter
//
//  Created by Zhang Tianli on 2/12/18.
//  Copyright © 2018 tianli. All rights reserved.
//

import Foundation
protocol PrimeCounterDelegate {
    func didFoundPrime(prime: Int64)
}

struct PrimeCounter {
    private let start: Int64
    private let end: Int64
    private let queue = OperationQueue()

    private let threads: Int
    var delegate: PrimeCounterDelegate? = nil
    
    private var map: [Int: (Int64,Int64)] {
        let len = roundUp(value: (end - start), divisor: Int64(threads))
        var startPoint: Int64 = 1
        var tempMap: [Int: (Int64,Int64)] = [:]
        for thread in 1...threads {
            tempMap[thread] = startPoint + len > end ? (startPoint, end) : (startPoint, startPoint+len)
            startPoint += len + 1
        }
        return tempMap
    }

    
    init(start:Int64, end:Int64, threads: Int) {
        self.start = start
        self.end = end
        self.threads = threads
    }
    
    mutating func startCounting() {
        for (_, dataPoints) in map {
            let operation = ComputeOperation(startPoint: dataPoints.0, endPoint: dataPoints.1)
            operation.delegate = delegate
            queue.addOperation(operation)
        }
        
    }
    
    func pause() {
        print("operation is paused.")
        queue.isSuspended = true
    }
    func resume() {
        print("operation is resumed.")
        queue.isSuspended = false
    }
    
    func stop() {
        print("all operation is stopped.")
        queue.cancelAllOperations()
    }
    
    private func roundUp(value: Int64, divisor: Int64) -> Int64 {
        let rem = value % divisor
        return rem == 0 ? value/divisor : value/divisor + divisor - rem
    }
}
