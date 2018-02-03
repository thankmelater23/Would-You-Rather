//
//  ViewController.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  ///MARK: - Variables
  var questions = [Question]()
  var duel:Duel?
  var onePlayed = false
  
  
  ///MARK: - IBOutlets
  @IBOutlet weak var topQuestionLabel: UILabel!
  @IBOutlet weak var bottomQuestionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  
  
  ///MARK: - IBActions
  @IBAction func topQuestionButton(_ sender: Any) {
  }
  @IBAction func bottomQuestionButton(_ sender: Any) {
  }
  @IBAction func nextDuel(_ sender: Any) {
    self.setup()
  }
  
  
  ///MARK: - View Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.setup()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  ///MARK: - Setup
  ///Setup function
  func setup(){
    self.getData()
    self.setUpDuel()
    self.setView()
    
  }
  ///Sets viewcontroller view
  func setView(){
    topQuestionLabel.text = duel?.question1.scene.capitalized
    bottomQuestionLabel.text = duel?.question2.scene.capitalized
    categoryLabel.text = duel?.category.rawValue.capitalized
  }
  ///Get data
  func getData(){
    let q1 = Question.init(scene: "Like This", category: QuestionCategory.gross)
    let q2 = Question.init(scene: "Like That", category: QuestionCategory.gross)
    
    questions = [q1, q2]
  }
  
  func setUpDuel(){
    let categoryType = self.getCaegory()
    
    let twoQuestionsArray = self.getQuestionsWith(category: categoryType)
    let q1 = twoQuestionsArray.first
    let q2 = twoQuestionsArray.last
    
    
    duel = Duel.init(question1: q1!, question2: q2!, category: categoryType)
  }
  
  func getCaegory()->QuestionCategory{
    //Random number between amount of cateories
    //Return category from that index
    return QuestionCategory.gross
  }
  
  func getQuestionsWith(category: QuestionCategory)->[Question]{
    let filteredQuestions = questions.filter({ $0.category == category })
    
    //Randomize 1 number between the array size
    //Randomize 2 number between the array size
    //Check its different number or do over
    //Grab question from first random index
    //Grab question from second random index
    //Check if duel is in history, if so do over
    
    let twoQustions = [filteredQuestions.first, filteredQuestions.last]
    
    return twoQustions as! [Question]
  }
  
}

