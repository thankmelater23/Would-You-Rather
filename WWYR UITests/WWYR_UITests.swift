//
//  WWYR_UITests.swift
//  WWYR UITests
//
//  Created by Andre on 5/3/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import XCTest

class WWYR_UITests: XCTestCase {
    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs./
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

    func test_GET_SCREEN_SHOTS() {
        let app = XCUIApplication()

        snapshot("Main Menu")

        app.buttons["Play"].tap()

        snapshot("Play 1 - Fun")

        let element = app.otherElements.containing(.navigationBar, identifier: "Would You Rather").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()

        let wouldYouRatherNavigationBar = app.navigationBars["Would You Rather"]
        let nextButton = wouldYouRatherNavigationBar.buttons["Next"]
        nextButton.tap()
        snapshot("Play 2 - Wacky")
        element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        nextButton.tap()
        wouldYouRatherNavigationBar.buttons["Skip"].tap()
        wouldYouRatherNavigationBar.buttons["Back"].tap()
        app.buttons["History"].tap()
        snapshot("History")
        app.navigationBars["Would_You_Rather.HistoryTableView"].buttons["Back"].tap()
        app.buttons["Options"].tap()
        app.buttons["About"].tap()
        snapshot("About - Us")
    }
}
