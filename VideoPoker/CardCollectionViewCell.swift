//
//  CardCollectionViewCell.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/25/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var holdButton: UIButton!
    
    var holded = false {
        didSet {
            let imageName = holded ? "holdButtonGreen_3x" : "holdButton_3x"
            holdButton.setImage(UIImage(named: imageName) ?? UIImage(), forState: .Normal)
        }
    }
    
    override func drawRect(rect: CGRect) {
        //backgroundView = UIImageView(image: UIImage(named: "back22"))
        self.isAccessibilityElement = true
    }
    
    @IBAction func holdButtonClicked(sender: UIButton) {
        holded = !holded
    }
    
    override func accessibilityElementDidBecomeFocused() {
        if let collectionView = self.superview as? UICollectionView {
            collectionView.scrollToItemAtIndexPath(collectionView.indexPathForCell(self)!,
                                                    atScrollPosition: [.CenteredHorizontally, .CenteredVertically],
                                                    animated: false)
            UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self)
        }
    }
}
