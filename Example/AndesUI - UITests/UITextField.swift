//
//  UITextField.swift
//  AndesUI - UITests
//
//  Created by Nicolas Rostan Talasimov on 4/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import XCTest
class AndesUI_UITestsTextField: XCTestCase {

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

    func testFieldScreen() {
        app.buttons["andesTextField"].tap()
        app.swipeLeft()
        app.swipeLeft()
        snapshot("TextField 1")
        app.otherElements["textField1"].tap()
        snapshot("TextField selected")
        app.otherElements["textField2"].tap()
        snapshot("TextField selected error")
        app.swipeUp()
        snapshot("TextField 2")
        app.swipeUp()
        snapshot("TextField 3")
        app.otherElements["textArea1"].tap()
        snapshot("TextArea selected")
        app.otherElements["textArea2"].tap()
        snapshot("TextArea selected error")
        app.swipeUp()
        snapshot("TextField 4")
    }
}
