//
//  Card.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/20/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import Foundation

enum Suit: String {
    case Hearts = "Hearths"
    case Spades = "Spades"
    case Clubs = "Clubs"
    case Diamonds = "Diamonds"
    
    static func suitArray() -> [Suit] {
        return [Hearts, Spades, Clubs, Diamonds]
    }
}

enum Rank: Int {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
    
    static func rankArray() -> [Rank] {
        return [Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace]
    }
}

class Card {
    let suit: Suit
    let rank: Rank
    
    var holded = false
    
    init(rank: Rank, suit:Suit) {
        self.rank = rank
        self.suit = suit
    }
}
