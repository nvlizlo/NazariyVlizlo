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
    
    override func drawRect(rect: CGRect) {
        backgroundView = UIImageView(image: UIImage(named: "back22"))
    }
    
}
