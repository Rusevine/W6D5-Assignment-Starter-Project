//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Wiljay Flores on 2018-09-07.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func deleteMeal(app: XCUIApplication, meal: String, calories: String){
    let staticText = app.tables.staticTexts["\(meal) - \(calories)"]
    if staticText.exists {
    staticText.swipeLeft()
    app.tables.buttons["Delete"].tap()
        }
    }
    
    func addMeal (app: XCUIApplication, meal: String, calories: String){
        app.navigationBars["Master"].buttons["Add"].tap()
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("\(meal)")
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("\(calories)")
        addAMealAlert.buttons["Ok"].tap()
    }
    
    
    func testExample() {
        
        let app = XCUIApplication()
        let meal = "Burgers"
        let calories = "3000"
        
        
        addMeal(app: app, meal: meal, calories: calories)
        app.tables.staticTexts["\(meal) - \(calories)"].tap()
        app.navigationBars["Detail"].buttons["Master"].tap()
        deleteMeal(app: app, meal: meal, calories: calories)
        
        }
        
    func testMealDetails() {
        let app = XCUIApplication()
        let meal = "banana"
        let calories = "300"
        addMeal(app: app, meal: meal, calories: calories)
        app.tables.staticTexts["\(meal) - \(calories)"].tap()
        let label = app.staticTexts["details"].label
        XCTAssertEqual(label, "\(meal) - \(calories)")
        app.navigationBars["Detail"].buttons["Master"].tap()
    }
}
    

