
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import SwiftRandom
import GoogleMobileAds

class GameViewController: UIViewController {
    /// MARK: - Variables
    var bannerView: GADBannerView!
    @IBOutlet weak var adBannerPlaceHolder: GADBannerView!
    @IBOutlet weak var orLabel: UILabel!

    var questions = [Question]()
    var playingQuestions = [Question]()
    var duel: Duel?
    var currentCategory: QuestionCategory = QuestionCategory.randomCategory()
    var database = Database()
    var gamePlaysCountInitializer = 0
    let adPlaysCount = 10
    var interstitial = GADInterstitial()

    /// MARK: - IBOutlets
    @IBOutlet weak var topQuestionLabel: UILabel!
    @IBOutlet weak var bottomQuestionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!

    @IBOutlet weak var topQuestionImageView: UIImageView!

    @IBOutlet weak var bottomQuestionImageView: UIImageView!

    @IBOutlet weak var skipNextBarButton: UIBarButtonItem!

    /// MARK: - IBActions
    @IBAction func topQuestionButton(_: Any) {
        let q1 = playingQuestions.first
        let q2 = playingQuestions.last

        let key = (duel?.pick?.scene) == (q1?.scene)

        if key {
            skipNextBarButton.title = "Skip"
            topQuestionImageView.isHidden = true
            bottomQuestionImageView.isHidden = true
            duel = nil
        } else {
            duel = Duel(question1: q1!, question2: q2!, pick: q1!)

            topQuestionImageView.image = UIImage(named: "Green-Check-Mark")
            bottomQuestionImageView.image = UIImage(named: "red x")
            skipNextBarButton.title = "Next"
            topQuestionImageView.isHidden = false
            bottomQuestionImageView.isHidden = false
        }
    }

    @IBAction func bottomQuestionButton(_: Any) {
        let q1 = playingQuestions.first
        let q2 = playingQuestions.last

        if duel?.pick?.scene == q2?.scene {
            skipNextBarButton.title = "Skip"
            topQuestionImageView.isHidden = true
            bottomQuestionImageView.isHidden = true
            duel = nil
        } else {
            duel = Duel(question1: q1!, question2: q2!, pick: q2!)

            bottomQuestionImageView.image = UIImage(named: "Green-Check-Mark")
            topQuestionImageView.image = UIImage(named: "red x")
            skipNextBarButton.title = "Next"
            topQuestionImageView.isHidden = false
            bottomQuestionImageView.isHidden = false
        }
    }

    @IBAction func nextDuel(_: Any) {
    }

    @IBAction func skipNextAction(_ sender: UIBarButtonItem) {
        setup()
        sender.title = "Skip"

        if duel != nil {
            /// Save to list
            saveToHistory()
        }
    }

    /// MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setup()
        loadVideoAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// MARK: - Setup
    /// Setup function
    func setup() {
        getData()
        setNewQuestions()
        setView()
        adBannerInit()
        playVideoAd()
    }

    /// Sets viewcontroller view
    func setView() {
        let q1 = playingQuestions.first
        let q2 = playingQuestions.last

        let topQuestionText = (q1?.scene)?.capitalized
        let bottomQuestionText = (q2?.scene)?.capitalized
        let categoryText = q1?.category.rawValue
        var magnitudeText = q1?.magnitude.rawValue
        magnitudeText = magnitudeText.map({ $0.capitalized })
        topQuestionLabel.text = topQuestionText.map({ $0.capitalized })
        bottomQuestionLabel.text = bottomQuestionText.map({ $0.capitalized })
        categoryLabel.text = categoryText.map({ $0.capitalized })
        magnitudeLabel.text = magnitudeText.map({ $0.capitalized })?.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)

        topQuestionImageView.isHidden = true
        bottomQuestionImageView.isHidden = true
    }

    /// MARK: - Setup Data
    func getData() {
        questions.removeAll()

        currentCategory = QuestionCategory.randomCategory()
        let categoryString = currentCategory.self.rawValue
        self.parseFile(file: categoryString)
    }

    func setNewQuestions() {
        playingQuestions.removeAll()

        let categoryType = QuestionCategory.randomCategory()
        let magnitudeType = Magnitude.randomMagnitude()

        playingQuestions = self.getQuestionsWith(magnitude: magnitudeType, category: currentCategory)
    }

    func getQuestionsWith(magnitude: Magnitude, category: QuestionCategory) -> [Question] {
        //    var filteredCategories = questions.filter({ $0.category == category })
        if questions.count < 2 {
            print("Not enough pairs for : \(category)")
            if questions.count > 0 {
                let backup = questions.first
                questions.append(backup!)
            }
        }

        var filteredMagnitudes = questions.filter({ $0.magnitude == magnitude })
        if filteredMagnitudes.count < 2 {
            print("Not enough pairs for : \(magnitude)")
            if filteredMagnitudes.count > 0 {
                let backup = filteredMagnitudes.first
                filteredMagnitudes.append(backup!)
            }
        }

        let amount = filteredMagnitudes.count - 1

        var index1 = Int.random(0, amount)
        var index2 = Int.random(0, amount)

        // Make sure the two objects aren't the same
        while index1 == index2 {
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

    func parseFile(file: String = "WouldYouRather") {
        questions = loadJson(filename: file)!
    }

    func loadJson(filename fileName: String) -> [Question]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Question].self, from: data)
                return (jsonData.filter { $0.scene.isEmpty == false })
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    func saveToHistory() {

        var duels: [Duel] = [Duel]()

        if Storage.fileExists(File.WWYRHistory, in: .documents) {
            duels = Storage.retrieve(File.WWYRHistory, from: .documents, as: [Duel].self)
        }

        if !duels.contains(duel!) {
            if questions.first?.scene.isEmpty == false && questions.last?.scene.isEmpty == false {
                duels.append(duel!)
            }
        } else {
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

extension GameViewController: GADInterstitialDelegate {

    func loadVideoAd() {
        interstitial = GADInterstitial(adUnitID: PrivateKeys.Game_Count_Plays_Initializer)
        let request = GADRequest()
        interstitial.load(request)
    }

    func gamePlaysCounter() -> Bool {
        gamePlaysCountInitializer += 1

        if gamePlaysCountInitializer % adPlaysCount == 0 {
            return true
        } else { return false }
    }

    func playVideoAd() {
        let key = gamePlaysCounter()

        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }

        if key == true {
            loadVideoAd()
        }
    }

    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
