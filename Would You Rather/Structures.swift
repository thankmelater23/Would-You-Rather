//
//  Structures.swift
//  Would You Rather
//
//  Created by Andre on 2/3/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

import UIKit

// MARK: - Settings Keys
/// Keys for userdefaults settings
struct SettingsKeys {
  static let adPurchased = "adPurchased"
  static let firstStart = "firstStart"
  static let lastDateActive = "lastDateActive"
  static let notificationsEnabled = "notificationsEnabled"
  static let daysSinceNotActive = "daysSinceNotActive"
  static let onBoardComplete = "onBoardComplete"
}

// MARK: - Private Keys
/// Private keys for 3rd party system integrations
struct PrivateKeys {
  static let fireBaseAnalytics = ""
  static let googleAdAppIdKey = "ca-app-pub-9306645534991006~3597230472"
  static let googleAdFakeAppIdKey = "ca-app-pub-3940256099942544/2934735716"
  static let oneSignalAppId = "4b840221-9aed-40f2-9785-43feebf12669"
  static let swiftBeaverAppid = "36rzYN"
  static let swiftBeaverSecret = "qCh8ir0vsoXhtwtDlofujtkuw5kBLynm"
  static let swiftBeaverEncryptionKey = "h3Cgwnudkxt3o0zdEdPyj7cFoTmvU6dl"
  static let furryAppID = "RWR4Q7N65VXWNXCH35SS"
  static let amplitudeProjectID = "185614"
  static let furryWatchAppID = "WMCWZVS4K3WS9YGJZBYS"
  static let amplitudeAPIKey = "5c06ebb3dbe5af8603f2ccd7d27e5697"
  static let amplitudeSecretKey = "b05205e77372c5c1566ed7ae9cd7bc19"
  static let facebookAnalyticsAppID = "190235348192860"
  static let facebookAnalyticsAppSecret = "5075a7039f3fef64149583b6d247e197"
  static let facebookAnalyticsClientToken = "fbfca28e74f26978e23e1d96beabbfad"
  static let appAnalyticsAPIKey = " z3bfi5Lgv8MwiyxjgylyylPnUOQaJzTZ"
}


// MARK: - Day Of Week
// Day Of The Week enum that returns day of week abriviated
enum DayOfTheWeek: String {
  case mon, tue, wed, thur, fri, sat, sun, na
  /// Returns: Abreviation string of current day of the week
  mutating func returnShrtDayOfTheWeek() -> String! {
    switch self {
    case .mon:
      return "M"
      
    case .tue:
      return "T"
      
    case .wed:
      return "W"
      
    case .thur:
      return "TH"
      
    case .fri:
      return "F"
      
    case .sat:
      return "S"
      
    case .sun:
      return "SU"
    case .na:
      return "-"
    }
  }
}

// MARK: - JSON Keys
/// JSON keys for Lotteries
struct JSONLotteryiesKeyString {
  // Lottery
  static let shortDayOfWeek = "shortDayOfWeek"
  static let dayOfWeek = "dayOfWeek"
  static let dayPlayed = "dayPlayed"
  static let id = "id"
  static let winnings = "winnings"
}

/// JSON keys for Pick3 and Lottery
struct JSONPrizeKeyString {
  static let prize1 = "prize1"
  static let prize2 = "prize2"
  static let prize3 = "prize3"
}

/// JSON keys for Fantasy5
struct JSONFantasy5KeyString {
  static let numbers = "numbers"
  static let letter = "letter"
  static let jackPot = "jackpot"
  static let date = "date"
}

/// JSON keys for Boledo
struct JSONBoledoKeyString {
  static let number = "number"
}

// MARK: - Cell Identifiers
/// Tableview Cells Identifiers
struct CellIdentifier {
  static let boledoHistoryCell = "boledoHistoryCell"
  static let fantasy5HistoryCell = "fantasy5HistoryCell"
  static let pick3HistoryCell = "pick3HistoryCell"
  static let lotteryHistoryCell = "lotteryHistoryCell"
}

// MARK: - Segues
/// Segue keys
struct Segue {
  // Boledo
  static let BoledoMain_To_BoledoMainMenu = "BoledoMainToBoledoMainMenu"
  static let BoledoMain_To_BoledoHistory = "BoledoMainToBoledoHistory"
  static let BoledoMain_To_BoledoGenerator = "BoledoMainToBoledoNumberGenerator"
  static let BoledoHistory_To_BoledoMain = "BoledoHistoryToBoledoMain"
  static let BoledoNumberGenerator_To_BoledoMain = "BoledoNumberGeneratorToBoledoMain"
  
  // Lottery
  static let LotteryMain_To_LotteryMainMenu = "LotteryMainToLotteryMainMenu"
  static let LotteryMain_To_LotteryHistory = "LotteryMainToLotteryHistory"
  static let LotteryMain_To_LotteryGenerator = "LotteryMainToLotteryNumberGenerator"
  static let LotteryHistory_To_LotteryMain = "LotteryHistoryToLotteryMain"
  static let LotteryNumberGenerator_To_LotteryMain = "LotteryNumberGeneratorToLotteryMain"
  
  // Pick3
  static let Pick3Main_To_Pick3MainMenu = "Pick3MainToPick3MainMenu"
  static let Pick3Main_To_Pick3History = "Pick3MainToPick3History"
  static let Pick3Main_To_Pick3Generator = "Pick3MainToPick3NumberGenerator"
  static let Pick3History_To_Pick3Main = "Pick3HistoryToPick3Main"
  static let Pick3NumberGenerator_To_Pick3Main = "Pick3NumberGeneratorToPick3Main"
  
  // Fantasy
  static let Fantasy5Main_To_Fantasy5MainMenu = "Fantasy5MainToFantasy5MainMenu"
  static let Fantasy5Main_To_Fantasy5History = "Fantasy5MainToFantasy5History"
  static let Fantasy5Main_To_Fantasy5Generator = "Fantasy5MainToFantasy5NumberGenerator"
  static let Fantasy5History_To_Fantasy5Main = "Fantasy5HistoryToFantasy5Main"
  static let Fantasy5NumberGenerator_To_Fantasy5Main = "Fantasy5NumberGeneratorToFantasy5Main"
  
  // Global
  static let Unwind_To_MainMenu = "UnwindToMainMenu"
}

// MARK: - Constants
/// Constants
struct Constants {
  static let NumberMockObjects = 10000
}

// MARK: - Images
/// Common app images
struct Images {
  static let welcomeScreenImage = UIImage(named: "icon")
}

