//
//  Array+average.swift
//  Macrow-ADHD
//
//  Created by Ich on 23/10/23.
//

import Foundation

extension Array where Element == Double {
    func average() -> Double {
        guard !isEmpty else {
            return 0.0 // Handle empty array case
        }

        let sum = reduce(0.0, +)
        return sum / Double(count)
    }
}

// Extension to split an array into chunks of a given size
extension Array {
    func chunks(of size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
