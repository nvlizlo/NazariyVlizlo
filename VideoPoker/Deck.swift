//
//  Deck.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/20/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import Foundation

enum Combination: Int, CustomStringConvertible {
    case NoHand = 0b0
    
    case Pair = 0b10
    case ThreeOfAKind = 0b11
    case FourOfAKind = 0b100
    
    case TwoPairs = 0b101
    case FullHouse = 0b110
    
    case Straight = 0b111
    case Flush = 0b1000
    
    case StraightFlush = 0b1111
    
    var description: String {
        var description = ""
        
        switch self {
        case .NoHand:
            description = "No hand"
        case .Pair:
            description = "Pair!"
        case .ThreeOfAKind:
            description = "Three of a Kind!"
        case .FourOfAKind:
            description = "Four of a Kind!"
        case .TwoPairs:
            description = "Two pairs!"
        case .FullHouse:
            description = "Full House!"
        case .Straight:
            description = "Straight!"
        case .Flush:
            description = "Flush!"
        case .StraightFlush:
            description = "Straight Flush!"
        }
        
        return description
    }
    
    var odds: Int {
        var odds = 0
        switch self {
        case .NoHand:
            odds = 0
        case .Pair:
            odds = 1
        case .ThreeOfAKind:
            odds = 3
        case .FourOfAKind:
            odds = 7
        case .TwoPairs:
            odds = 2
        case .FullHouse:
            odds = 6
        case .Straight:
            odds = 4
        case .Flush:
            odds = 5
        case .StraightFlush:
            odds = 10
        }
        return odds
    }
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
    
    func reloadCards() {
        handCards.forEach({cards.append($0)})
    }
    
    func populateHandCards() {
        for _ in 1...5 {
            handCards.append(drawRandomCard())
        }
    }
    
    func checkForCombinations() -> Combination? {
        var currentCombination = Combination.NoHand
        
        if let flushCombination = checkForFlush() {
            currentCombination = flushCombination
        }
        if let straightCombination = checkForStraight() {
            currentCombination = currentCombination + straightCombination
        } else if let kindCombination = checkForAKind() {
            currentCombination = kindCombination
        }
        
        return currentCombination
    }
    
    func checkForFlush() -> Combination? {
        return handCards.filter({$0.suit == handCards.first?.suit}).count == 5 ? .Flush : nil
    }
    
    func checkForStraight() -> Combination? {
        let sortedHandCards = handCards.sort({$0.0.rank.rawValue < $0.1.rank.rawValue})
        var currentCombination: Combination?
        var tempCard = sortedHandCards.first!
        
        var count = 0
        for i in 1...4 {
            let currentCard = sortedHandCards[i]
            if currentCard.rank.rawValue - tempCard.rank.rawValue == 1 {
                count += 1
                tempCard = currentCard
            }
            
        }
        currentCombination = count == 4 ? .Straight : nil
        return currentCombination
    }
    
    func checkForAKind() -> Combination? {
        var currentCombinations = [Combination]()
        var counter = 1
        let sortedHand = handCards.sort({$0.0.rank.rawValue < $0.1.rank.rawValue})
        
        if var tempCard = sortedHand.first {
            for i in 1..<sortedHand.count {
                let currentCard = sortedHand[i]
                
                if currentCard.rank == tempCard.rank {
                    counter += 1
                } else {
                    if counter > 1 {
                        currentCombinations.append(Combination(rawValue: counter)!)
                        counter = 1
                    }
                    tempCard = currentCard
                }
            }
        }
        
        if counter > 1 {currentCombinations.append(Combination(rawValue: counter)!)}
        return self.evaluateCombination(currentCombinations)
    }
    
    func evaluateCombination(combinations: [Combination]) -> Combination? {
        let rawValue = combinations.reduce(0, combine: {$0 + $1.rawValue}) + (combinations.count - 1)
        return Combination(rawValue: rawValue)
    }
}












