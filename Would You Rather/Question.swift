//
//  Question.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum QuestionCategory:String, Codable{
  case romance, food, technology, crime, surgery, annoying, death, pain, gross, embarrassing, psycological//music
  
  static func randomCategory()->QuestionCategory{
    typealias q = QuestionCategory
    var arrayOfCategories = [q.romance, q.food, q.technology, q.crime, q.surgery, q.annoying, q.death, q.pain, q.gross, q.embarrassing, q.psycological]//,q.music,
    let count = arrayOfCategories.count
    
    //Random between 1-count
    let randomNumber = Int.random(0, (count - 1))
    let category = arrayOfCategories[randomNumber]
    print("Number: \(randomNumber)/\(count)\n\(category)")
    return category
  }
}

enum Magnitude:String, Codable{
  case light, stiff, heavy, extreme
  
  static func randomMagnitude()->Magnitude{
    typealias m = Magnitude
    var arrayOfMagnitudes = [m.light, m.stiff, m.heavy, m.extreme]
    let count = arrayOfMagnitudes.count
    
    //Random between 1-count
    let randomNumber = Int.random(0, (count - 1))
    let magnitude = arrayOfMagnitudes[randomNumber]
    print("Number: \(randomNumber)//\(count)\n\(magnitude)")
    
    return magnitude
  }
}

struct Question: Codable{
  var scene: String
  var category: QuestionCategory
    var magnitude: Magnitude
  
  init(scene:String, category: QuestionCategory, magnitude: Magnitude) {
    self.scene = scene
    self.category = category
    self.magnitude = magnitude
  }
}

struct Duel: Codable{
  var question1: Question
  var question2: Question
  var pick: Question?
  var category:QuestionCategory
  var magnitude:Magnitude
  
  init(question1: Question, question2: Question, category:QuestionCategory, magnitude: Magnitude) {
    self.question1 = question1
    self.question2 = question2
    self.category = category
    self.magnitude = magnitude
  }
}
