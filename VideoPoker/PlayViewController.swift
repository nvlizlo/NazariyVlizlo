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
    var bet = 20 {
        didSet {
            if bet >= balance {
                plusButton.enabled = false
            } else if bet <= 0 {
                minusButton.enabled = false
            } else {
                addBetButtonsEnabled(true)
            }
        }
    }
    var balance = Constants.initialScore {
        didSet {
            balanceLabel.text = "Credits:\(balance)"
        }
    }
    var started = true
    
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var combinationLabel: UILabel!
    @IBOutlet weak var currentBetLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addBetButtonsEnabled(enabled: Bool) {
        plusButton.enabled = enabled
        minusButton.enabled = enabled
    }
    
    func redBlickAnimation() {
        UIView.transitionWithView(currentBetLabel, duration: 0.3, options: .TransitionCrossDissolve, animations: {
            self.currentBetLabel.textColor = UIColor.redColor()
        }) { completed in
            if completed {
                self.currentBetLabel.textColor = UIColor.blackColor()
            }
            
        }
    }
    
    @IBAction func startButtonClicked(sender: UIButton) {
        
        if started == true {
            if balance == 0 {
                addBetButtonsEnabled(false)
                combinationLabel.text = "Game Over"
                sender.enabled = false
                return
            } else if balance - bet < 0 {
                plusButton.enabled = false
                combinationLabel.text = "Your bet is higher than your balance. Please decrease it."
                redBlickAnimation()
                return
            } else {
                currentBetLabel.textColor = UIColor.blackColor()
            }
            deck.reloadCards()
            deck.handCards.removeAll()
            balance -= bet
            addBetButtonsEnabled(false)
            
            if let visibleCells = cardsCollectionView.visibleCells() as? [CardCollectionViewCell] {
                for cell in visibleCells {
                    deck.handCards.append(deck.drawRandomCard())
                    cell.holdButton.enabled = true
                    cell.userInteractionEnabled = true
                    cell.holded = false
                }
            }
            let currentCombination = deck.checkForCombinations()
            combinationLabel.text = currentCombination?.description
            sender.setImage(UIImage(named: "dealDrawButtonDark_3x") ?? UIImage(), forState: .Normal)
        } else {
            addBetButtonsEnabled(true)
            if let visibleCells = cardsCollectionView.visibleCells() as? [CardCollectionViewCell] {
                var tempCards = [Card]()
                for (index, cell) in visibleCells.enumerate() {
                    if !cell.holded {
                        tempCards.append(deck.handCards[index])
                        deck.handCards[index] = deck.drawRandomCard()
                    }
                    cell.holdButton.enabled = false
                    cell.userInteractionEnabled = false
                    cell.holdButton.setImage(UIImage(named: "holdButton_3x") ?? UIImage(), forState: .Normal)
                }
                for tempCard in tempCards {
                    deck.addCard(tempCard)
                }
                tempCards.removeAll()
            }
            
            let currentCombination = deck.checkForCombinations()
            let combinationString = currentCombination?.description
            balance += currentCombination!.odds * bet
            
            combinationLabel.text = combinationString
            if balance == 0 {
                addBetButtonsEnabled(false)
                sender.enabled = false
                combinationLabel.text = "Game Over"
            }
            sender.setImage(UIImage(named: "dealDrawButton_3x") ?? UIImage(), forState: .Normal)
        }
        
        started = !started
        print(cardsCollectionView.visibleCells())
        cardsCollectionView.reloadData()
        print(cardsCollectionView.visibleCells())
    }
    
    @IBAction func addBetClicked(sender: UIButton) {
        self.bet = self.bet + sender.tag * 5
        self.currentBetLabel.text = "Current bet:\(self.bet)"
    }
    
    @IBAction func menuButtonClicked(sender: UIButton) {
        var menuViewController: MenuViewController?
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is MenuViewController {
                    menuViewController = viewController as? MenuViewController
                }
            }
            menuViewController?.continuedViewController = self
            self.navigationController?.popToViewController(menuViewController!, animated: true)
        }
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CardCollectionViewCell {
            cell.holded = !cell.holded
        }
    }
}

extension PlayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5 - 10, height: collectionView.frame.size.height)
    }
}
