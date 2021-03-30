//
//  UITestMessage.swift
//  AndesUI - UITests
//
//  Created by Nicolas Rostan Talasimov on 4/28/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import XCTest
class AndesUI_UITestsMessage: XCTestCase {

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

    func testMessageScreen() {
        app.buttons["andesMessages"].tap()
        app.swipeLeft()
        snapshot("Message 1")
        app.swipeUp()
        snapshot("Message 3")
        app.swipeDown()
    }
}
