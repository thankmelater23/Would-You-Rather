//
//  Duel.swift
//  Would You Rather
//
//  Created by Andre on 5/30/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

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
    
    let ls = [lhs.question1, lhs.question2]
    let rs = [rhs.question1, rhs.question2]
    
    guard rs.contains(lhs.question1) && rs.contains(lhs.question2) else {return false}
    
    return true
  }
  
  
  /// Checks if questions match
  static func *= (lhs: Duel, rhs: Duel) -> Bool {
    let ls = [lhs.question1, lhs.question2]
    let rs = [rhs.question1, rhs.question2]
    
    guard rs.contains(lhs.question1) && rs.contains(lhs.question2) else {return false}
    
    return true
  }
}
