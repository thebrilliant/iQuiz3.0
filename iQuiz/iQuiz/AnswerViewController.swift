//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/10/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var correctText: UILabel!
    @IBOutlet weak var qAText: UILabel!
    var currentQ = 0
    var totalQ = 0
    var totalCorrect = 0
    var wasCorrect = false
    var qText: String = ""
    var aText: String = ""
    
    var subject = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("\(currentQ)")
        correctText.text? = "You were: "
        if wasCorrect {
            correctText.text? += "right!"
        } else {
            correctText.text? += "wrong..."
        }
        qAText.text? = "\(qText) \(aText)"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Complete" {
            NSLog("segue is for finish")
            if let destination = segue.destinationViewController as? FinishedViewController {
                destination.total = totalQ
                destination.correct = totalCorrect
            }
        } else if segue.identifier == "NextQ" {
            if let destination = segue.destinationViewController as? SubjectViewController {
                destination.questionNum = currentQ + 1
                destination.subject = subject
                destination.numCorrect = totalCorrect
            }
        } else {
            
        }
    }
    
    @IBAction func quitPressed(sender: UIButton) {
        performSegueWithIdentifier("Back", sender: self)
    }
    
    @IBAction func nextPressed(sender: UIButton) {
        if totalQ - 1 == currentQ {
            NSLog("Hit the complete button")
            performSegueWithIdentifier("Complete", sender: self)
        } else {
            performSegueWithIdentifier("NextQ", sender: self)
        }
    }
}