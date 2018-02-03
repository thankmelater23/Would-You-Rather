//
//  Question.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum QuestionCategory:String{
  case music, romance, diet, internet, crime, surgery, annoyi8ing, death, pain, gross
}

class Question{
  var scene: String
  var category: QuestionCategory
  
  init(scene:String, category: QuestionCategory) {
    self.scene = scene
    self.category = category
  }
}

class Duel{
  var question1: Question
  var question2: Question
  var pick: Question?
  var category:QuestionCategory
  
  init(question1: Question, question2: Question, category:QuestionCategory) {
    self.question1 = question1
    self.question2 = question2
    self.category = category
  }
}
