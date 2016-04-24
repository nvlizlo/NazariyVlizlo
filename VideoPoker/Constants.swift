//
//  Constants.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/25/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import Foundation

struct Constants {
    static let initialScore = 100
    static let odds = 20
    static let attempt = 20
    
    static let pairMultiplier = 1 * odds
    static let twoPairMultiplier  = 2 * odds
    static let setMultiplier  = 3 * odds
    static let straightMultiplier = 4 * odds
    static let flushMultiplier = 5 * odds
    static let fullHouseMultiplier = 6 * odds
    static let fourOfAKindMultiplier = 7 * odds
    static let straightFlushMultiplier = 10 * odds
    
    static let numberOfCardsOnTable = 5
}
