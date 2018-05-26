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
  static let googleAdAppIdKey = ""
  static let googleAdFakeAppIdKey = ""
  static let oneSignalAppId = ""
  static let swiftBeaverAppid = "e1PxQR"
  static let swiftBeaverSecret = "tPebny1jdhkv3fivIhfLqSmtlxgst8wk"
  static let swiftBeaverEncryptionKey = "ybEgaOtebsnmccasjubseipdufqnzHrf"
  static let furryAppID = ""
  static let amplitudeProjectID = ""
  static let furryWatchAppID = ""
  static let amplitudeAPIKey = ""
  static let amplitudeSecretKey = ""
  static let facebookAnalyticsAppID = ""
  static let facebookAnalyticsAppSecret = ""
  static let facebookAnalyticsClientToken = ""
  static let appAnalyticsAPIKey = " "
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
  static let key = ""
}


// MARK: - Cell Identifiers
/// Tableview Cells Identifiers
struct CellIdentifier {
  static let historyCell = "history cell"
}

// MARK: - Segues
/// Segue keys
struct Segue {
  // Boledo
  static let Main_To_History = "Main_To_History"
  
  
  // Global
  static let Unwind_To_ = "UnwindTo"
}

// MARK: - Constants
/// Constants
struct Constants {
  static let NumberMockObjects = 10000
}

// MARK: - Images
/// Common app images
struct Images {
  static let image = UIImage(named: "")
}

struct File{
  static let WWYRHistory = File.WWYRHistory
}

