//
//  MenuViewController.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 3/20/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var continuedViewController: PlayViewController? {
        didSet {
            continueButton.enabled = true
        }
    }
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func continueButtonClicked(sender: UIButton) {
        self.navigationController?.pushViewController(continuedViewController!, animated: true)
    }
}
