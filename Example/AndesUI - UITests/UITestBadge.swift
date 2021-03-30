//
//  UITestBadge.swift
//  AndesUI - UITests
//
//  Created by Nicolas Rostan Talasimov on 4/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import XCTest
class AndesUI_UITestsBadge: XCTestCase {

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

    func testBadgeScreen() {
        app.buttons["andesBadge"].tap()
        app.swipeLeft()
        snapshot("Badges 1")
    }
}
