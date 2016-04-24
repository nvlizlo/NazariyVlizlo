//
//  Deck.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/20/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import Foundation

class Deck {
    
    var cards: [Card]
    var handCards = [Card]()
    
    init() {
        cards = [Card]()
        for suit in Suit.suitArray() {
            for rank in Rank.rankArray() {
                self.addCard(Card(rank: rank, suit: suit))
            }
        }
    }
    
    func addCard(card: Card) {
        cards.append(card)
    }
    
    func drawRandomCard() -> Card {
        let random = Int(arc4random_uniform(UInt32(cards.count)))
        let card = cards.removeAtIndex(random)
        return card
    }
    
    func populateHandCards() {
        for _ in 1...5 {
            handCards.append(drawRandomCard())
        }
    }
    
    func checkForFlush() -> Bool {
        var counter = 0
        if let expectedSuit = handCards.first?.suit {
            handCards.forEach({
                if $0.suit == expectedSuit {
                    counter += 1
                }
                
            })
        }
        return counter == 5 ? true : false
    }
    
    func checkForStraight() -> Bool {
        var counter = 1
        let sortedHandCards = handCards.sort({$0.0.rank.rawValue < $0.1.rank.rawValue})
        if var expectedRank = sortedHandCards.first?.rank {
            for i in 1...4 {
                if sortedHandCards[i].rank.rawValue - expectedRank.rawValue == 1 {
                    counter += 1
                }
                expectedRank = sortedHandCards[i].rank
            }
        }
        return counter == 5 ? true : false
    }
}