//
//  UITestCard.swift
//  AndesUI - UITests
//
//  Created by Martin Victory on 22/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import XCTest
class AndesUI_UITestsCard: XCTestCase {

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
        app.buttons["andesCard"].tap()
        app.swipeLeft()
        snapshot("Card 1")
        app.swipeUp()
        snapshot("Card 2")
    }
}
