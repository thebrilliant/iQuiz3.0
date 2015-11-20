//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/19/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var urlText: UITextField!
    var makeQuiz = [AnyObject]()
    
    var delegate : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //stuff
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //stuff
    }
    
    @IBAction func transferData(sender: UIButton) {
        delegate?.setData(makeQuiz)
    }
    
    @IBAction func loadURL(sender: UIButton) {
        let newURL = self.urlText.text
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let URL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            //Success
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            
            print("URL SessionTask Succeeded: HTTP \(statusCode)")
            
            do {
                var parseError: NSError?
                
                self.makeQuiz = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
                print(self.makeQuiz)
                
                let nav : NavController = self.view.window?.rootViewController as! NavController
                nav.makeQuiz = self.makeQuiz
                
            } catch let error as NSError{
                
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
}
