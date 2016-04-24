//
//  ArrayExtension.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 4/24/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import Foundation

typealias Hand = Combination

extension SequenceType where Generator.Element == Hand {
    func evaluateCombination() -> Hand {
        let c = self.reduce(0, combine: {$0 + $1.rawValue}) 
        return Hand(rawValue: c)!
    }
}