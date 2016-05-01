//
//  AboutViewController.swift
//  VideoPoker
//
//  Created by Nazariy Vlizlo on 5/1/16.
//  Copyright © 2016 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuButtonClicked(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension AboutViewController: UITextViewDelegate {
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
}
