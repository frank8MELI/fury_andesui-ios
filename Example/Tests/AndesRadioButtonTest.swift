//
//  AndesRadioButtonTest.swift
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 7/3/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesRadioButtonTests: QuickSpec {
    override func spec() {
        describe("Andes radiobutton should draw its view depends on their properties") {
            context("When creating AndesRadioButton") {
                it("Has the idle view type, right view align, selected view status check align") {
                    let radioButton = AndesRadioButton(type: .idle, align: .right, status: .selected, title: "RadioButton")
                    let alignLeft = AndesRadioButtonAlign.left

                    radioButton.align = alignLeft
                    let configuration = AndesRadioButtonConfig.init(for: radioButton)

                    expect(configuration.align).to(equal(alignLeft))

                }

                it("Has the idle view error, left view align, unselected view status and border color red") {
                    let radioButton = AndesRadioButton(type: .error, align: .left, status: .unselected, title: "RadioButton")
                    let errorBorderColor = UIColor.Andes.red500

                    let configuration = AndesRadioButtonConfig.init(for: radioButton)

                    expect(configuration.tintColor).to(equal(errorBorderColor))

                }

                it("Has the idle view type, left view align, selected view status") {
                    let radioButton = AndesRadioButton(type: .idle, align: .left, status: .selected, title: "RadioButton")
                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.idle))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.left))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.selected))

                }

                it("Has the idle view type, left view align, unselected view status") {
                    let radioButton = AndesRadioButton(type: .idle, align: .left, status: .unselected, title: "RadioButton")
                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.idle))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.left))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.unselected))
                }

                it("Has the idle view type, left view align, selected view status") {
                    let radioButton = AndesRadioButton(type: .idle, align: .right, status: .selected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.idle))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.right))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.selected))

                }

                it("Has the idle view type, left view align, unselected view status") {
                    let radioButton = AndesRadioButton(type: .idle, align: .right, status: .unselected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.idle))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.right))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.unselected))

                }
            }

            context("When creating RadioButton") {
                it("Has the disabled view type, left view align, selected view status") {
                    let radioButton = AndesRadioButton(type: .disabled, align: .left, status: .selected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.disabled))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.left))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.selected))
                }

                it("Has the disabled view type, left view align, unselected view status") {
                    let radioButton = AndesRadioButton(type: .disabled, align: .left, status: .unselected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.disabled))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.left))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.unselected))
                }

                it("Has the disabled view type, right view align, selected view status") {
                    let radioButton = AndesRadioButton(type: .disabled, align: .right, status: .selected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.disabled))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.right))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.selected))
                }

                it("Has the disabled view type, right view align, unselected view status") {
                    let radioButton = AndesRadioButton(type: .disabled, align: .right, status: .unselected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.disabled))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.right))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.unselected))
                }

            }

            context("When creating RadioButton") {
                it("Has the error view type, left view align, unselected view status") {
                    let radioButton = AndesRadioButton(type: .error, align: .left, status: .unselected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.error))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.left))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.unselected))
                }

                it("Has the error view type, right view align, unselected view status") {
                    let radioButton = AndesRadioButton(type: .error, align: .right, status: .unselected, title: "RadioButton")

                    expect(radioButton.title).to(equal("RadioButton"))
                    expect(radioButton.type).to(equal(AndesRadioButtonType.error))
                    expect(radioButton.align).to(equal(AndesRadioButtonAlign.right))
                    expect(radioButton.status).to(equal(AndesRadioButtonStatus.unselected))
                }
            }
        }
    }
}
