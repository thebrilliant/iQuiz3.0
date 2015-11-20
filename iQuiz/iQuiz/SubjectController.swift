//
//  SubjectController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/3/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation
import UIKit

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var list: UILabel!
    let mathQ = ["1+1?", "e is?"]
    let superQ = ["Who is Peter Parker?", "Thor is from which mythology?"]
    let scienceQ = ["What scientist studies rocks?", "What is RNAse used for?"]
    let mathA = ["1", "2", "3", "4", "3.141592...", "2.1718281828...", "42", "36"]
    let superA = ["Spiderman", "Antman", "Batman", "Mothman", "Nordic", "Greek", "Russian", "Germanic"]
    let scienceA = ["Geographer", "Cartographer", "Calligrapher", "Geologist", "To create DNA sequences", "To create RNA sequences", "To break up proteins", "To break up RNA sequences in cells"]
    var questions: [String] = []
    var currentAnswers: [String] = []
    let tableID = "QuestionAnswers"
    var subject:String = ""
    var questionNum = 0
    var numCorrect = 0
    var correctAnswer:String = ""
    var correct = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if subject == "Mathematics" {
            questions = mathQ
            if questionNum != mathQ.count {
                currentAnswers.append(mathA[(4 * questionNum)])
                currentAnswers.append(mathA[(4 * questionNum) + 1])
                currentAnswers.append(mathA[(4 * questionNum) + 2])
                currentAnswers.append(mathA[(4 * questionNum) + 3])
                correctAnswer = mathA[(4 * questionNum) + 1]
            }
        } else if subject == "Marvel Super Heroes" {
            questions = superQ
            if questionNum != superQ.count {
                currentAnswers.append(superA[(4 * questionNum)])
                currentAnswers.append(superA[(4 * questionNum) + 1])
                currentAnswers.append(superA[(4 * questionNum) + 2])
                currentAnswers.append(superA[(4 * questionNum) + 3])
                correctAnswer = superA[(4 * questionNum)]
            }
        } else {
            questions = scienceQ
            if questionNum != scienceQ.count {
                currentAnswers.append(scienceA[(4 * questionNum)])
                currentAnswers.append(scienceA[(4 * questionNum) + 1])
                currentAnswers.append(scienceA[(4 * questionNum) + 2])
                currentAnswers.append(scienceA[(4 * questionNum) + 3])
                correctAnswer = scienceA[(4 * questionNum) + 3]
            }
        }
        if questionNum < questions.count {
            list.text = "\(questions[questionNum])"
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToAnswer" {
            let destination = segue.destinationViewController as! AnswerViewController
            destination.qText = questions[questionNum]
            destination.aText = correctAnswer
            destination.currentQ = questionNum
            destination.wasCorrect = correct
            destination.totalQ = questions.count
            destination.totalCorrect = numCorrect
            destination.subject = subject
            NSLog("\(questionNum)")
        }
    }
    
    @IBAction func quitPressed(sender: UIButton) {
        performSegueWithIdentifier("GoBack", sender: self)
    }
    
    @IBAction func submitPressed(sender: UIButton) {
        NSLog("heading to answer page")
        performSegueWithIdentifier("ToAnswer", sender: self)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnswers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(tableID) as UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableID)
        }
        cell.imageView?.image = UIImage(named: "200px-ALBW_Triforce")
        cell.textLabel?.text = currentAnswers[indexPath.row]
        //cell.detailTextLabel?.text = subjectsDescr[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let answered = currentAnswers[indexPath.row]
        if answered == correctAnswer {
            correct = true
            numCorrect++
        }
    }
}