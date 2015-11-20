//
//  ViewController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 10/29/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var subjectTable: UITableView!
    private var subjects = [Subject]() //["Mathematics", "Marvel Super Heroes", "Science"] //
    //private let subjectsDescr = ["Math questions here!", "All the MSH trivia here!", "Science is so much fun!"]
    let tableID = "QuizTopics"
    private var sub : SubjectViewController!
    private var ans : AnswerViewController!
    var qNum = 0
    var subjectClicked = ""
    
    //JSON file, local
    var json: String = "[{\"title\":\"Science!\",\"desc\":\"Because SCIENCE!\",\"questions\":[{\"text\":\"What is fire?\",\"answer\":\"1\",\"answers\":[\"One of the four classical elements\",\"A magical reaction given to us by God\",\"A band that hasn't yet been discovered\",\"Fire! Fire! Fire! heh-heh\"]}]},{ \"title\":\"Marvel Super Heroes\", \"desc\": \"Avengers, Assemble!\",\"questions\":[{\"text\":\"Who is Iron Man?\",\"answer\":\"1\",\"answers\":[\"Tony Stark\",\"Obadiah Stane\",\"A rock hit by Megadeth\",\"Nobody knows\"]},{\"text\":\"Who founded the X-Men?\",\"answer\":\"2\",\"answers\":[\"Tony Stark\",\"Professor X\",\"The X-Institute\",\"Erik Lensherr\"]},{\"text\":\"How did Spider-Man get his powers?\",\"answer\":\"1\",\"answers\":[\"He was bitten by a radioactive spider\",\"He ate a radioactive spider\",\"He is a radioactive spider\",\"He looked at a radioactive spider\"]}]},{ \"title\":\"Mathematics\", \"desc\":\"Did you pass the third grade?\",\"questions\":[{\"text\":\"What is 2+2?\",\"answer\":\"1\",\"answers\":[\"4\",\"22\",\"An irrational number\",\"Nobody knows\"]}]}]"
    
    @IBAction func settingsPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings go here", message: "OK", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //for JSON
        let jsonFileName = "questions.json"
        var jsonText : NSString = ""
        if let directory : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = directory.stringByAppendingPathComponent(jsonFileName)
            do {
                jsonText = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            } catch let error as NSError {
                NSLog("Something isn't working... \(error.localizedDescription)")
                NSLog("file path: \(path)")
                jsonText = json
            }
        }
        let data = jsonText.dataUsingEncoding(NSUTF8StringEncoding)
        let options = NSJSONReadingOptions()
        do {
            let jsonObj = try NSJSONSerialization.JSONObjectWithData(data!, options: options) as! NSArray
            NSLog("here's what we have: \(jsonObj)")
            NSLog("Trying to access the objects... \(jsonObj[0])")
            
            for subject in jsonObj {
                let title = subject["title"] as! String
                let description = subject["desc"] as! String
                let questions = subject["questions"]  as! [AnyObject]
                var listOfQ = [Question]()
                for quest in questions {
                    NSLog("question: \(quest)")
                    let correct = quest["answer"] as! Int
                    let text = quest["text"] as! String
                    let answers = quest["answers"] as! [String]
                    var listOfAns = [Answer]()
                    for ans in answers {
                        NSLog("anseweer: \(ans)")
                        listOfAns.append(Answer(text: ans))
                    }
                    NSLog("answers: \(listOfAns)")
                    listOfQ.append(Question(quest: text, correct: correct, ans: listOfAns))
                }
                subjects.append(Subject(sub: title, descr: description, quest: listOfQ))
                //NSLog("Subject title: \(title)")
                //NSLog("Questions: \(questions)")
            }
            /*if let jsonSubject = jsonObj["title"] as? [Subject] {
                NSLog("\(jsonSubject)")
                NSLog("It worked!")
            } else {
                NSLog("What is \(jsonObj)? Something went wrong")
                NSLog("\(jsonObj)...")
            }*/
        } catch let error as NSError {
            NSLog("Something isn't working... \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(tableID) as UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableID)
        }
        cell.imageView?.image = UIImage(named: "200px-ALBW_Triforce")
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = subjectsDescr[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Start" {
            if let destination = segue.destinationViewController as? SubjectViewController {
                destination.subject = subjectClicked
                destination.questionNum = 0
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        subjectClicked = subjects[indexPath.row]
        performSegueWithIdentifier("Start", sender: self)
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
        subjectTable.hidden = true
    }
}

