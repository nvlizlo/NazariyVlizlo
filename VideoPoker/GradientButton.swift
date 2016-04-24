//
//  GradientButton.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/20/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    override func drawRect(rect: CGRect) {
        self.drawGradient(firstColor: UIColor.whiteColor(), secondColor: UIColor.orangeColor())
    }
}
