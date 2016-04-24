//
//  Deck.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/20/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import Foundation

enum Combination: Int {
    case NoHand = 0b0
    
    case Pair = 0b10
    case ThreeOfAKind = 0b11
    case FourOfAKind = 0b100
    
    case TwoPairs = 0b101
    case FullHouse = 0b110
    
    case Straight = 0b111
    case Flush = 0b1000
}

class Deck {
    
    var cards: [Card]
    var handCards = [Card]()
    var deckCombination = [Combination?]()
    
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
    
    func checkForFlush() -> Combination {
        //        var counter = 0
        //        if let expectedSuit = handCards.first?.suit {
        //            handCards.forEach({
        //                if $0.suit == expectedSuit {
        //                    counter += 1
        //                }
        //
        //            })
        //        }
        return handCards.filter({$0.suit == handCards.first?.suit}).count == 5 ? .Flush : .NoHand
    }
    
    func checkForStraight() -> Combination {
        let sortedHandCards = handCards.sort({$0.0.rank.rawValue < $0.1.rank.rawValue})
        var currentCombination = Combination.NoHand
        
        if let firstCard = sortedHandCards.first, let lastCard = sortedHandCards.last {
            currentCombination = lastCard.rank.rawValue - firstCard.rank.rawValue == 4 ? .Straight : .NoHand
        }
        return currentCombination
    }
    
    func checkForAKind() -> [Combination?] {
        var currentCombinations = [Combination?]()
        var counter = 1
        let sortedHand = handCards.sort({$0.0.rank.rawValue < $0.1.rank.rawValue})
        
        if var tempCard = sortedHand.first {
            for i in 1..<sortedHand.count {
                let currentCard = sortedHand[i]
                
                if currentCard.rank == tempCard.rank {
                    counter += 1
                } else {
                    if counter > 0 {
                        currentCombinations.append(Combination(rawValue: counter))
                        counter = 1
                    }
                    tempCard = currentCard
                }
            }
        }
        
        currentCombinations.append(Combination(rawValue: counter))
        return currentCombinations
    }
    
    func evaluateCombination(combinations: [Combination]) -> Combination {
        let rawValue = combinations.reduce(0, combine: {$0 + $1.rawValue}) - (combinations.count - 1)
        return Combination(rawValue: rawValue)!
    }
}












