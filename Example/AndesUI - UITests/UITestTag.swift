//
//  UITestTag.swift
//  AndesUI - UITests
//
//  Created by Samuel Sainz on 6/12/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import XCTest
class AndesUI_UITestsTag: XCTestCase {

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

    func testTagScreen() {
        app.buttons["andesTag"].tap()
        app.swipeLeft()
        snapshot("Tags 1")
    }
}
