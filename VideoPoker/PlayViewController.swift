//
//  PlayViewController.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/25/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var deck = Deck()
    var bet = 20
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var combinationLabel: UILabel!
    
    var started = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonClicked(sender: UIButton) {
        if started == true {
            deck.reloadCards()
            deck.handCards.removeAll()
            
            if let visibleCells = cardsCollectionView.visibleCells() as? [CardCollectionViewCell] {
                for cell in visibleCells {
                        deck.handCards.append(deck.drawRandomCard())
                        cell.holdButton.userInteractionEnabled = true
                        cell.holded = false
                }
            }
            sender.setImage(UIImage(named: "dealDrawButtonDark_3x") ?? UIImage(), forState: .Normal)
        } else {
            if let visibleCells = cardsCollectionView.visibleCells() as? [CardCollectionViewCell] {
                var tempCards = [Card]()
                for (index, cell) in visibleCells.enumerate() {
                    if !cell.holded {
                        tempCards.append(deck.handCards[index])
                        deck.handCards[index] = deck.drawRandomCard()
                    }
                    cell.holdButton.userInteractionEnabled = false
                    cell.holdButton.setImage(UIImage(named: "holdButton_3x") ?? UIImage(), forState: .Normal)
                }
                for tempCard in tempCards {
                    deck.addCard(tempCard)
                }
                tempCards.removeAll()
            }
            
            let combinationString = deck.checkForCombinations()
            
            UIView.animateWithDuration(1, animations: {
                self.combinationLabel.text = combinationString
                self.combinationLabel.alpha = 1
                }, completion: { completed in
                    if completed {
                        UIView.animateWithDuration(3) {self.combinationLabel.alpha = 0}
                    }
            })
            sender.setImage(UIImage(named: "dealDrawButton_3x") ?? UIImage(), forState: .Normal)
        }
        
        started = !started
        cardsCollectionView.reloadData()
    }
    
    @IBAction func addBetClicked(sender: UIButton) {
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension PlayViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfCardsOnTable
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath) ?? UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegate

extension PlayViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? CardCollectionViewCell where deck.handCards.count > 0 {
            let card = deck.handCards[indexPath.row]
            cell.cardImageView.image = UIImage(named: "\(card.suit.rawValue)\(card.rank.rawValue)")
        }
    }
}
