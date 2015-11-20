//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/10/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation
import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var ratio: UILabel!
    
    var correct = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if correct == total {
            rank.text? = "Perfect!"
        } else {
            rank.text? = "Almost..."
        }
        ratio.text? = "You got \(correct) out of \(total)"
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func completePressed(sender: UIButton) {
        performSegueWithIdentifier("Home", sender: self)
    }
}
