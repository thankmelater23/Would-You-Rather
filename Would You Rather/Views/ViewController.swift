//
//  ViewController.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import SwiftRandom

class ViewController: UIViewController {
  ///MARK: - Variables
  var questions = [Question]()
  var duel:Duel?
  var currentCategory: QuestionCategory = QuestionCategory.randomCategory()
  var database = Database()
  
  
  ///MARK: - IBOutlets
  @IBOutlet weak var topQuestionLabel: UILabel!
  @IBOutlet weak var bottomQuestionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var magnitudeLabel: UILabel!
  
  @IBOutlet weak var topQuestionImageView: UIImageView!
  
  @IBOutlet weak var bottomQuestionImageView: UIImageView!
  
  @IBOutlet weak var skipNextBarButton: UIBarButtonItem!
  
  ///MARK: - IBActions
  @IBAction func topQuestionButton(_ sender: Any) {
    let q1 = questions.first
    let q2 = questions.last
    
    let key = (duel?.pick?.scene) == (q1?.scene)
    
    if key{
      skipNextBarButton.title = "Skip"
      self.topQuestionImageView.isHidden = true
      self.bottomQuestionImageView.isHidden = true
      duel = nil
    }else{
        duel = Duel.init(question1: q1!, question2: q2!, pick: q1!)
      
        topQuestionImageView.image = UIImage.init(named: "green check")
        bottomQuestionImageView.image = UIImage.init(named: "red x circle")
        skipNextBarButton.title = "Next"
        self.topQuestionImageView.isHidden = false
        self.bottomQuestionImageView.isHidden = false
      
    
    }
  }
  @IBAction func bottomQuestionButton(_ sender: Any) {
    let q1 = questions.first
    let q2 = questions.last
    
    if duel?.pick?.scene == q2?.scene{
      skipNextBarButton.title = "Skip"
      self.topQuestionImageView.isHidden = true
      self.bottomQuestionImageView.isHidden = true
      duel = nil
    }else{
        duel = Duel.init(question1: q1!, question2: q2!, pick: q2!)
      
        bottomQuestionImageView.image = UIImage.init(named: "green check")
        topQuestionImageView.image = UIImage.init(named: "red x circle")
        skipNextBarButton.title = "Next"
        self.topQuestionImageView.isHidden = false
        self.bottomQuestionImageView.isHidden = false
    }
  }
  @IBAction func nextDuel(_ sender: Any) {
    
  }
  
  @IBAction func skipNextAction(_ sender: UIBarButtonItem) {
    self.setup()
    sender.title = "Skip"
    
    if duel != nil{
      ///Save to list
      saveToHistory()
    }
  }
  
  ///MARK: - View Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.setup()
    
//    database.loadData()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  ///MARK: - Setup
  ///Setup function
  func setup(){
    self.getData()
    self.setNewQuestions()
    self.setView()
    
  }
  ///Sets viewcontroller view
  func setView(){
    let q1 = questions.first
    let q2 = questions.last
    
    let topQuestionText = (q1?.scene)?.capitalized
    let bottomQuestionText = (q2?.scene)?.capitalized
    let categoryText = q1?.category.rawValue
    var magnitudeText = q1?.magnitude.rawValue
    magnitudeText = magnitudeText.map({$0.capitalized})
    topQuestionLabel.text = topQuestionText.map({$0.capitalized})
    bottomQuestionLabel.text = bottomQuestionText.map({$0.capitalized})
    categoryLabel.text = categoryText.map({$0.capitalized})
    magnitudeLabel.text = magnitudeText.map({$0.capitalized})
    
    self.topQuestionImageView.isHidden = true
    self.bottomQuestionImageView.isHidden = true
  }
  ///Get data
  func getData(){
//    let q1 = Question.init(scene: "Like This", category: QuestionCategory.gross)
//    let q2 = Question.init(scene: "Like That", category: QuestionCategory.gross)
//    let q3 = Question.init(scene: "Like This here", category: QuestionCategory.gross)
//    let q4 = Question.init(scene: "Like That there", category: QuestionCategory.gross)
//    let q5 = Question.init(scene: "Like This guy", category: QuestionCategory.gross)
//    let q6 = Question.init(scene: "Like That kid", category: QuestionCategory.gross)
//    let q7 = Question.init(scene: "Like This was", category: QuestionCategory.gross)
//    let q8 = Question.init(scene: "Like That is", category: QuestionCategory.gross)
//    questions = [q1, q2, q3, q4, q5, q6, q7, q8]
    self.questions.removeAll()
    self.currentCategory = self.getCaegory()
    let categoryString = currentCategory.self.rawValue
    self.parseFile(file: categoryString)
  }
  
  func setNewQuestions(){
//    let categoryType = self.getCaegory()
    let magnitudeType = self.getMagnitude()
    
    self.questions = self.getQuestionsWith(magnitude: magnitudeType, category: currentCategory)
  }
  
  func getCaegory()->QuestionCategory{
    return QuestionCategory.randomCategory()
  }
  
  func getMagnitude()->Magnitude{
    return Magnitude.randomMagnitude()
  }
  
  func getQuestionsWith(magnitude: Magnitude, category: QuestionCategory)->[Question]{
//    var filteredCategories = questions.filter({ $0.category == category })
    if self.questions.count < 2{
      print("Not enough pairs for : \(category)")
      let backup = questions.first
      questions.append(backup!)
    }
    var filteredMagnitudes = questions.filter({ $0.magnitude == magnitude })
    if filteredMagnitudes.count < 2{
      print("Not enough pairs for : \(magnitude)")
      let backup = filteredMagnitudes.first
      filteredMagnitudes.append(backup!)
    }
    
    let amount = filteredMagnitudes.count - 1
    
    var index1 = Int.random(0, amount)
    var index2 = Int.random(0, amount)
    
    while (index1 == index2){
      index1 = Int.random(0, amount)
      index2 = Int.random(0, amount)
      let bool = (index1 == index2)
      print("Equal indexes: \(bool)")
    }
    
    //Grab question from first random index
    //Grab question from second random index
    //Check if duel is in history, if so do over
    
    let twoQustions = [filteredMagnitudes[index1], filteredMagnitudes[index2]]
    
    return twoQustions as! [Question]
  }
  
  func parseFile(file: String = "WouldYouRather"){
    self.questions = self.loadJson(filename: file)!
  }
  
  func loadJson(filename fileName: String) -> [Question]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode([Question].self, from: data)
        return jsonData
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }

  func saveToHistory(){
    var duels:[Duel] = [Duel]()
    
    if Storage.fileExists(File.WWYRHistory, in: .documents){
    duels = Storage.retrieve(File.WWYRHistory, from: .documents, as: [Duel].self)
    }
    
    if !duels.contains(duel!){
      if questions.first?.scene.isEmpty == false && questions.last?.scene.isEmpty == false{
        duels.append(self.duel!)
      }
    }else{
      
    }
    
    Storage.store(duels, to: Storage.Directory.documents, as: File.WWYRHistory)
    
//    database.saveData(duel: self.duel!)
//    let url = Bundle.main.url(forResource: File.WWYRHistory, withExtension: "json")
//
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//    encoder.dateEncodingStrategy = .formatted(dateFormatter)
//
//    let data = try! encoder.encode(duel)
//    print(data)
//
//    do {
//      try data.write(to: url!)
//      print("File Saved")
//    } catch {
//      print("Failed to write JSON data: \(error.localizedDescription)")
//    }
  }
}

