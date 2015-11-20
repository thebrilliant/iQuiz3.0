//
//  Subject.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/19/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation

class Subject {
    var title : String
    var desc: String
    var questions: [Question]
    
    init (sub: String, descr: String, quest: [Question]) {
        title = sub
        desc = descr
        questions = quest
    }
}
