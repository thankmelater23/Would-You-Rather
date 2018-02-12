//
//  AppDelegate.swift
//  Would You Rather
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import CoreData
import SwiftyBeaver
import Siren

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.setup()
    // Override point for customization after application launch.
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    self.saveContext()
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "Would_You_Rather")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  ///MARK: - Setup
  func setup(){
    self.buddyBuildConfig()
    self.swiftBeaverSetUp()
    self.printAppInfo()
    self.removeConstraintFromLogger()
  }
  fileprivate func buddyBuildConfig() {
    log.verbose(#function)
//    BuddyBuildSDK.setup()
  }
  // MARK: - 3rd Party Integration
  /** Swifty Beaver logger configuration
   
   -  Note: Logger
   */
  func swiftBeaverSetUp() {
    log.verbose(#function)
    let console = ConsoleDestination()
    log.addDestination(console)
    let file = FileDestination()
    log.addDestination(file)
    log.verbose("Verbose Test") // prio 1, VERBOSE in silver
    log.debug("Debug Test") // prio 2, DEBUG in blue
    log.info("Info Test") // prio 3, INFO in green
    log.warning("Warning Test") // prio 4, WARNING in yellow
    log.error("Error Test") // prio 5, ERROR in red
    let platform = SBPlatformDestination(appID: PrivateKeys.swiftBeaverAppid, appSecret: PrivateKeys.swiftBeaverSecret, encryptionKey: PrivateKeys.swiftBeaverEncryptionKey)
    log.addDestination(platform)
  }
  /// Logs app details
  func printAppInfo() {
    
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      log.info("Version Running: \(version)")
    }
    if let CFBundleDevelopmentRegion = Bundle.main.infoDictionary?["CFBundleDevelopmentRegion"] as? String {
      log.info("Develope Region: \(CFBundleDevelopmentRegion)")
    }
    if let CFBundleDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
      log.info("Display Name: \(CFBundleDisplayName)")
    }
    if let CFBundleDocumentTypes = Bundle.main.infoDictionary?["CFBundleDocumentTypes"] as? String {
      log.info("Document Types: \(CFBundleDocumentTypes)")
    }
    if let CFBundleExecutable = Bundle.main.infoDictionary?["CFBundleDeCFBundleExecutablevelopmentRegion"] as? String {
      log.info("Bundle Executable: \(CFBundleExecutable)")
    }
    if let CFBundleIconFile = Bundle.main.infoDictionary?["CFBundleIconFile"] as? String {
      log.info("Icon file: \(CFBundleIconFile)")
    }
    if let CFBundleIcons = Bundle.main.infoDictionary?["CFBundleIcons"] as? String {
      log.info("Bundle Icon: \(CFBundleIcons)")
    }
    if let CFBundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String {
      log.info("Bundle Identifier : \(CFBundleIdentifier)")
    }
    if let CFBundleLocalizations = Bundle.main.infoDictionary?["CFBundleLocalizations"] as? String {
      log.info("Bundle Localization : \(CFBundleLocalizations)")
    }
    if let CFBundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
      log.info("Bundle Name: \(CFBundleName)")
    }
    if let CFBundlePackageType = Bundle.main.infoDictionary?["CFBundlePackageType"] as? String {
      log.info("Bundle Package: \(CFBundlePackageType)")
    }
    
    if let CFBundleShortVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      log.info("Short Version String: \(CFBundleShortVersionString)")
    }
    if let CFBundleSignature = Bundle.main.infoDictionary?["CFBundleSignature"] as? String {
      log.info("Bundle Signature : \(CFBundleSignature)")
    }
    if let CFBundleSpokenName = Bundle.main.infoDictionary?["CFBundleSpokenName"] as? String {
      log.info("Spoken Name : \(CFBundleSpokenName)")
    }
    if let CFBundleURLTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? String {
      log.info("Bundle URL Type : \(CFBundleURLTypes)")
    }
    if let CFBundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
      log.info("Bundle Version : \(CFBundleVersion)")
    }
    if let CFBundleTypeName = Bundle.main.infoDictionary?["CFBundleTypeName"] as? String {
      log.info("Bundle Type Name: \(CFBundleTypeName)")
    }
    if let LSHandlerRank = Bundle.main.infoDictionary?["LSHandlerRank"] as? String {
      log.info(" Handler Rank: \(LSHandlerRank)")
    }
    if let CFBundlePackageType = Bundle.main.infoDictionary?["CFBundlePackageType"] as? String {
      log.info("Bundle Package Type: \(CFBundlePackageType)")
    }
  }
  
  /// Removes constrait logging
  func removeConstraintFromLogger() {
    log.verbose(#function)
    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
  }

  func sirenConfiguration() {
    log.verbose(#function)
    /* Siren code should go below window?.makeKeyAndVisible() */
    
    // Siren is a singleton
    let siren = Siren.shared
    
    // Required: Your app's iTunes App Store ID
    //        siren.appID = "1300481560"
    
    // Optional: Defaults to .Option
    
    /*
     Replace .Immediately with .Daily or .Weekly to specify a maximum daily or weekly frequency for version
     checks.
     */
    siren.checkVersion(checkType: .daily)
    
    siren.alertType = .option // SirenAlertType.option
    
    siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 3
  }
}
