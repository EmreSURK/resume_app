//
//  ResumeAppUITests.swift
//  ResumeAppUITests
//
//  Created by Emre on 12.05.2022.
//

import XCTest

class ResumeAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    // add a skill and expecting it is added and saved on the disk, persist after re-launch.
    func testAddingSkill() throws {
        let randomSkillNo = Int.random(in: 0...99999)
        let testSkillName = "test skill \(randomSkillNo)"
        
        let app = XCUIApplication()
        app.launch()
        
        sleep(1)
        
        // if it is the first openin, then use the button, if it is not the first openin, that is ok, just continue to test.
        if app.buttons["Create A Resume"].exists {
            app.buttons["Create A Resume"].tap()
        }
        
        sleep(1)

        app.buttons["Add Skill"].tap()
        wait(for: [], timeout: 1)
        
        app.textFields["skill name"].tap()
        app.textFields["skill name"].firstMatch.typeText(testSkillName)
        app.tap()
        sleep(1)
        app.buttons["Save"].tap()
        sleep(1)
        app.buttons["Go Back"].tap()
        sleep(1)
        XCTAssertTrue(app.staticTexts[testSkillName].exists)
        app.buttons["Save"].tap()

        
        // terminate and re-launch the app read the skill just added.
        XCUIApplication().terminate()
        
        let app2 = XCUIApplication()
        app2.launch()

        XCTAssertTrue(app.staticTexts[testSkillName].exists)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
