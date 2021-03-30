//
//  AndesCoachmarkNavBarTests.swift
//  AndesUI_Tests
//
//  Created by JONATHAN DANIEL BANDONI on 18/08/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesCoachmarkNavBarTests: QuickSpec {
    override func spec() {

        describe("Coachmark navigation bar tests") {
            context("Title and close") {
                it("Check that title and button was setted correctly") {
                    let navBar = AndesCoachMarkNavBarView()
                    navBar.title = "some"
                    navBar.showExitButton = true

                    guard let titleLabel = navBar.subviews.compactMap({$0 as? UILabel}).first else {
                        fail()
                        return
                    }
                    let buttons = navBar.subviews.compactMap({$0 as? UIButton})
                    let hiddenButtons = buttons.filter({$0.isHidden})
                    expect(hiddenButtons.count).to(equal(0))
                    expect(titleLabel.text).to(equal("some"))
                }
                it("Check that button was hidden correctly") {
                    let navBar = AndesCoachMarkNavBarView()
                    navBar.showExitButton = false

                    let buttons = navBar.subviews.compactMap({$0 as? UIButton})
                    let hiddenButtons = buttons.filter({$0.isHidden})
                    expect(hiddenButtons.count).to(equal(1))
                }
                it("Check that delegate works") {
                    let navBar = AndesCoachMarkNavBarView()
                    let viewDelegateMock = NavBarMock()
                    navBar.delegate = viewDelegateMock
                    navBar.closeButtonTouchUpInside(UIControl(), with: nil)

                    MockSwift.verify(viewDelegateMock)
                }
            }
        }
    }
}

private class NavBarMock: AndesCoachMarkNavBarViewDelegate, Mock {
    var didCalldidClose = MockCounter()

    func didClose() {
        didCalldidClose.wasCalled()
    }

}
