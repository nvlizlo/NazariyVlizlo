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
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButtonClicked(sender: UIBarButtonItem) {
        deck.handCards.removeAll()
        cardsCollectionView.userInteractionEnabled = true
        for _ in 1...5 {
            deck.handCards.append(deck.drawRandomCard())
        }
        cardsCollectionView.reloadData()
        sender.enabled = false
    }
    
    @IBAction func applyButtonClicked(sender: UIBarButtonItem) {
        if let visibleCells = cardsCollectionView.visibleCells() as? [CardCollectionViewCell] {
            for (index, cell) in visibleCells.enumerate() {
                if cell.cardImageView.hidden {
                    deck.handCards[index] = deck.drawRandomCard()
                    cell.cardImageView.hidden = false
                }
            }
        }
        deck.checkForFlush()
        deck.checkForStraight()
        cardsCollectionView.reloadData()
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
            cell.cardImageView.hidden = !cell.cardImageView.hidden
        }
    }
}
