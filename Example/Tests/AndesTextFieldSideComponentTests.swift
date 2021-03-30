//
//  AndesTextFieldSideComponentTests.swift
//  AndesUI_Tests
//
//  Created by Nicolas Rostan Talasimov on 4/21/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesTextFieldSideComponentTests: QuickSpec {
    var config: AndesTextFieldViewConfig = AndesTextFieldViewConfig()

    override func spec() {
        beforeEach {
            self.config = AndesTextFieldViewConfig()
        }

        describe("Tests AndesTextField side components") {
            context("Test component factory") {
                it("test label (prefix suffix)") {
                    // Given
                    let lblText = "Label"
                    let labelSpec = AndesTextFieldComponentLabel(text: "Label")
                    self.config.leftViewComponent = labelSpec
                    self.config.rightViewComponent = labelSpec

                    // When
                    let leftLabel = AndesTextFieldComponentFactory.generateLeftComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let rightLabel = AndesTextFieldComponentFactory.generateRightComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let internalLeftLbl = leftLabel?.subviews.first(where: {$0 is UILabel}) as? UILabel
                    let internalRightLbl = rightLabel?.subviews.first(where: {$0 is UILabel}) as? UILabel

                    // Expect
                    expect(internalLeftLbl?.text).to(equal(lblText))
                    expect(internalRightLbl?.text).to(equal(lblText))
                }
                it("test icon") {
                    // Given
                    let iconSpec = AndesTextFieldComponentIcon(andesIconName: AndesIcons.feedbackError16, tintColor: UIColor.green)
                    self.config.leftViewComponent = iconSpec
                    self.config.rightViewComponent = iconSpec

                    // When
                    let leftIcon = AndesTextFieldComponentFactory.generateLeftComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let rightIcon = AndesTextFieldComponentFactory.generateRightComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let internalLeftImg = leftIcon?.subviews.first(where: {$0 is UIImageView}) as? UIImageView
                    let internalRightImg = rightIcon?.subviews.first(where: {$0 is UIImageView}) as? UIImageView

                    // Expect
                    expect(internalLeftImg?.image).to(equal(iconSpec.icon))
                    expect(internalRightImg?.image).to(equal(iconSpec.icon))
                    expect(internalRightImg?.tintColor).to(equal(UIColor.green))
                    expect(internalLeftImg?.tintColor).to(equal(UIColor.green))
                }

                it("test non andes icon") {
                    // Given
                    let bundle = Bundle(path: Bundle(for: AndesBundle.self).path(forResource: "AndesIcons", ofType: "bundle")!)
                    let icon: UIImage = UIImage(named: AndesIcons.feedbackError16, in: bundle, compatibleWith: nil)!
                    let iconSpec = AndesTextFieldComponentIcon(icon: icon, tintColor: UIColor.green)
                    self.config.leftViewComponent = iconSpec
                    self.config.rightViewComponent = iconSpec

                    // When
                    let leftIcon = AndesTextFieldComponentFactory.generateLeftComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let rightIcon = AndesTextFieldComponentFactory.generateRightComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let internalLeftImg = leftIcon?.subviews.first(where: {$0 is UIImageView}) as? UIImageView
                    let internalRightImg = rightIcon?.subviews.first(where: {$0 is UIImageView}) as? UIImageView

                    // Expect
                    expect(internalLeftImg?.image).to(equal(icon))
                    expect(internalRightImg?.image).to(equal(icon))
                }

                it("test check") {
                    // Given
                    let checkSpec = AndesTextFieldComponentCheck()
                    self.config.rightViewComponent = checkSpec

                    // When
                    let rightView = AndesTextFieldComponentFactory.generateRightComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let internalRightImg = rightView?.subviews.first(where: {$0 is UIImageView}) as? UIImageView

                    // Expect
                    expect(internalRightImg?.tintColor).to(equal(checkSpec.tintColor))
                    expect(internalRightImg?.image).to(equal(checkSpec.icon))
                }

                it("test action") {
                    // Given
                    let actionSpec = AndesTextFieldComponentAction("action")
                    self.config.rightViewComponent = actionSpec

                    // When
                    let rightView = AndesTextFieldComponentFactory.generateRightComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let internalBtn = rightView?.subviews.first(where: {$0 is AndesButton}) as? AndesButton

                    // Expect
                    expect(internalBtn?.text).to(equal("action"))
                    expect(internalBtn?.hierarchy).to(equal(.transparent))
                }

                it("test clear") {
                    // Given
                    let clearSpec = AndesTextFieldComponentClear()
                    self.config.rightViewComponent = clearSpec

                    // When
                    let rightView = AndesTextFieldComponentFactory.generateRightComponentView(for: self.config, visibilities: [.always, .whenNotEmpty])
                    let internalBtn = rightView?.subviews.first(where: {$0 is UIButton}) as? UIButton

                    // Expect
                    expect(internalBtn).toNot(beNil())
                }
            }
        }
    }
}
