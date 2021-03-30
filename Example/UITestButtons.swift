//
//  AndesUI_DemoAppUITests.swift
//  AndesUI DemoAppUITests
//
//  Created by Nicolas Rostan Talasimov on 4/28/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import XCTest
class AndesUI_UITestsButton: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launchArguments = ["UITesting"]
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testButtonScreen() {
        snapshot("0Launch")
        app.buttons["andesButtons"].tap()
        snapshot("1Buttons")
        app.buttons["smallTransparent"].swipeUp()
        snapshot("2Buttons")
    }
}
