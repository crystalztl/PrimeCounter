//
//  ComputeOperation.swift
//  primeCounter
//
//  Created by Zhang Tianli on 2/12/18.
//  Copyright © 2018 tianli. All rights reserved.
//

import Foundation

class ComputeOperation: Operation {
    var startPoint: Int64
    var endPoint: Int64
    var delegate: PrimeCounterDelegate? = nil
    
    init(startPoint: Int64, endPoint: Int64) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    override func start() {
        for i in self.startPoint...self.endPoint {
            if isPrime(num: i) {
                delegate?.didFoundPrime(prime: i)
            }
        }
    }
    
    private func isPrime(num: Int64) -> Bool{
        if num <= 1 {
            return false
        }
        
        if num % 2 == 0 && num > 2 {
            return false
        }
        
        for i in stride(from: 3, to: num/2, by: 2) {
            if num % i == 0 {
                return false
            }
        }
        
        return true
    }

}
