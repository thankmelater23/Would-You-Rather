//
//  Would_You_RatherUITests.swift
//  Would You RatherUITests
//
//  Created by Andre on 2/2/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import XCTest

class Would_You_RatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
      let app = XCUIApplication()
      setupSnapshot(app)
      
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
      app.launch()
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
      
      let app = XCUIApplication()
      app.buttons["Play"].tap()
      
      let element = app.otherElements.containing(.navigationBar, identifier:"Would You Rather").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      let button = element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element
      
      snapshot("Main Screen")
      
      button.tap()
      
      snapshot("Play 1")
      
      let wouldYouRatherNavigationBar = app.navigationBars["Would You Rather"]
      let nextButton = wouldYouRatherNavigationBar.buttons["Next"]
      
      nextButton.tap()
      
      snapshot("Play 2")
      
      let button2 = element.children(matching: .other).element(boundBy: 2).children(matching: .button).element
      button2.tap()
      nextButton.tap()
      
      snapshot("Play 3")
      
      
      wouldYouRatherNavigationBar.buttons["Skip"].tap()
      button.tap()
      button2.tap()
      button.tap()
      nextButton.tap()
      
      snapshot("Play 4")
      
      wouldYouRatherNavigationBar.buttons["Back"].tap()
      app.buttons["Options"].tap()
      app.buttons["About"].tap()
      
      snapshot("About")
      
      app.navigationBars["About"].buttons["Back"].tap()
      app.navigationBars["Prefrences"].buttons["Back"].tap()
      
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
  
  func test_GET_SCREEN_SHOTS(){
  }
    
}
