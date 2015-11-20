//
//  SubjectController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/3/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var list: UILabel!
    
    let tableID = "QuestionAnswers"
    var questionNum = 0
    var numCorrect = 0
    var correct = false
    
    var subjectType = Subject()
    var listOfQ = [Question]()
    var listOfA = [Answer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfQ = subjectType.questions
        listOfA = listOfQ[questionNum].answers
        
        if questionNum < listOfQ.count {
            list.text = "\(listOfQ[questionNum].text)"
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
            destination.qText = listOfQ[questionNum].text
            destination.aText = listOfA[listOfQ[questionNum].answer - 1].text
            destination.currentQ = questionNum
            destination.wasCorrect = correct
            destination.totalQ = listOfQ.count
            destination.totalCorrect = numCorrect
            destination.subject = subjectType
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
        return listOfA.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(tableID) as UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableID)
        }
        cell.imageView?.image = UIImage(named: "200px-ALBW_Triforce")
        cell.textLabel?.text = listOfA[indexPath.row].text
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let answered = listOfA[indexPath.row].text
        if answered == listOfA[listOfQ[questionNum].answer - 1].text {
            correct = true
            numCorrect++
        }
        performSegueWithIdentifier("ToAnswer", sender: self)
    }
}