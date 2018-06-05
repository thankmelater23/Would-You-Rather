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
  var playingQuestions = [Question]()
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
    let q1 = playingQuestions.first
    let q2 = playingQuestions.last
    
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
    let q1 = playingQuestions.first
    let q2 = playingQuestions.last
    
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
    let q1 = playingQuestions.first
    let q2 = playingQuestions.last
    
    let topQuestionText = (q1?.scene)?.capitalized
    let bottomQuestionText = (q2?.scene)?.capitalized
    let categoryText = q1?.category.rawValue
    var magnitudeText = q1?.magnitude.rawValue
    magnitudeText = magnitudeText.map({$0.capitalized})
    topQuestionLabel.text = topQuestionText.map({$0.capitalized})
    bottomQuestionLabel.text = bottomQuestionText.map({$0.capitalized})
    categoryLabel.text = categoryText.map({$0.capitalized})
    magnitudeLabel.text = magnitudeText.map({$0.capitalized})?.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
    
    self.topQuestionImageView.isHidden = true
    self.bottomQuestionImageView.isHidden = true
  }
  
  ///MARK: - Setup Data
  func getData(){
    self.questions.removeAll()
    
    self.currentCategory = QuestionCategory.randomCategory()
    let categoryString = currentCategory.self.rawValue
    self.parseFile(file: categoryString)
  }
  
  func setNewQuestions(){
    self.playingQuestions.removeAll()
    
    let categoryType = QuestionCategory.randomCategory()
    let magnitudeType = Magnitude.randomMagnitude()
    
    self.playingQuestions = self.getQuestionsWith(magnitude: magnitudeType, category: currentCategory)
  }
  
  func getQuestionsWith(magnitude: Magnitude, category: QuestionCategory)->[Question]{
    //    var filteredCategories = questions.filter({ $0.category == category })
    if self.questions.count < 2{
      print("Not enough pairs for : \(category)")
      if questions.count > 0{
      let backup = questions.first
      questions.append(backup!)
      }
    }
    
    var filteredMagnitudes = questions.filter({ $0.magnitude == magnitude })
    if filteredMagnitudes.count < 2{
      print("Not enough pairs for : \(magnitude)")
      if filteredMagnitudes.count > 0{
        let backup = filteredMagnitudes.first
        filteredMagnitudes.append(backup!)
      }
    }
    
    let amount = filteredMagnitudes.count - 1
    
    var index1 = Int.random(0, amount)
    var index2 = Int.random(0, amount)
    
    //Make sure the two objects aren't the same
    while (index1 == index2){
      index1 = Int.random(0, amount)
      index2 = Int.random(0, amount)
    }
    
    var twoQustions = [filteredMagnitudes[index1], filteredMagnitudes[index2]]
    
//    while (twoQustions.first?.scene.isEmpty)! || (twoQustions.last?.scene.isEmpty)!{
//      twoQustions = [Question]()
////      twoQustions = getQuestionsWith(magnitude: magnitude, category: category)
//
//      //Make sure the two objects aren't the same
//        index1 = Int.random(0, amount)
//        index2 = Int.random(0, amount)
//
//      twoQustions = [filteredMagnitudes[index1], filteredMagnitudes[index2]]
//    }
    
    return twoQustions
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
        return (jsonData.filter {$0.scene.isEmpty == false})
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

