//
//  Question.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

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

