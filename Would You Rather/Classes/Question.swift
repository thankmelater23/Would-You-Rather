//
//  Question.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum QuestionCategory:String, Codable{
  case romance, technology, annoying, pain, gross, embarrassing, psychological
  
  static func randomCategory()->QuestionCategory{
    typealias q = QuestionCategory
    var arrayOfCategories = [q.romance, q.technology, q.annoying, q.pain, q.gross, q.embarrassing]
    let count = arrayOfCategories.count
    
    //Random between 1-count
    let randomNumber = Int.random(0, (count - 1))
    let category = arrayOfCategories[randomNumber]
    print("Number: \(randomNumber)/\(count - 1)\n\(category)")
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

extension Question: Equatable{
  /// Checks if object is an exact match
  static func == (lhs: Question, rhs: Question) -> Bool {
    guard lhs.category == rhs.category else {
      return false
    }
    
    guard lhs.magnitude == rhs.magnitude else {
      return false
    }
    
    guard lhs.scene == rhs.scene else {
      return false
    }
    return true
  }
}

struct Duel: Codable{
  var question1: Question
  var question2: Question
  var pick: Question?
  var category:QuestionCategory
  var magnitude:Magnitude
  var isQ1Selected: Bool
  
  init(question1: Question, question2: Question, pick: Question) {
    self.question1 = question1
    self.question2 = question2
    self.category = question1.category
    self.magnitude = question1.magnitude
    self.pick = pick
    self.isQ1Selected = (question1.scene == self.pick?.scene)
  }
//  required init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: LotteriesCodingKeys.self)
//    datePlayed = try values.decode(Date.self, forKey: .datePlayed)
//    //    var dowString = try values.decode(DayOfTheWeek.self, forKey: ._dayOfTheWeek)
//    _dayOfTheWeek = (datePlayed?.getDayOfWeek())!
//    winnings = try values.decodeIfPresent([Int].self, forKey: .winnings)
//    print(self)
//  }
//  func encode(to encoder: Encoder) throws {
//    print(#function)
//    //Containers
//    var personContainer = encoder.container(keyedBy: LotteriesCodingKeys.self)
//
//    //Initialization
//    try personContainer.encode(self.datePlayed, forKey: .datePlayed)
//    try personContainer.encode(self.dayOfTheWeek, forKey: ._dayOfTheWeek)
//    try personContainer.encodeIfPresent(self.winnings, forKey: .winnings)
//    print(self)
//  }
}

  extension Duel: Equatable{
    /// Checks if object is an exact match
    static func == (lhs: Duel, rhs: Duel) -> Bool {
      guard lhs.category == rhs.category else {
        return false
      }
      
      guard lhs.magnitude == rhs.magnitude else {
        return false
      }
      
      guard lhs.pick == rhs.pick! else {
        return false
      }
      
      guard lhs.question1 == rhs.question1 else {
        return false
      }
      
      guard lhs.question2 == rhs.question2 else {
        return false
      }
      return true
    }
}
