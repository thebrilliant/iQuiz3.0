//
//  Question.swift
//  iQuiz
//
//  Created by Vivyan Woods on 11/19/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation

class Question {
    var text: String
    var answer: Int
    var answers : [Answer]
    
    init (quest: String, correct: Int, ans: [Answer]) {
        text = quest
        answer = correct
        answers = ans
    }
}