//
//  AndesTextFieldCodeTests.swift
//  AndesUI-demoapp
//
//  Created by Esteban Adrian Boffa on 05/10/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble

@testable import AndesUI
protocol AndesTextFieldCodeTestValues {
    var state: AndesTextFieldCodeState { get }
    var style: AndesTextFieldCodeStyle { get }
    var label: String { get }
    var helpLabel: String { get }
}

extension AndesTextFieldCodeTests: AndesTextFieldCodeDelegate {
    func textDidChange(_ text: String) {
        textDidChange = text
    }

    func textDidComplete(_ isComplete: Bool) {
        textDidComplete = isComplete
    }
}

class AndesTextFieldCodeTests: QuickSpec {

    var internalView: AndesTextFieldCodeAbstractView!
    var textInputView: AndesTextFieldCode!

    var textDidChange = ""
    var textDidComplete = false

    override func spec() {
        struct DefaultValues: AndesTextFieldCodeTestValues {
            var state: AndesTextFieldCodeState = .IDLE
            var style: AndesTextFieldCodeStyle = .THREESOME
            let label = "Label"
            var helpLabel = "Helper"
        }

        struct ModifiedValues: AndesTextFieldCodeTestValues {
            var state: AndesTextFieldCodeState = .ERROR
            var style: AndesTextFieldCodeStyle = .FOURSOME
            let label = "Title"
            var helpLabel = "Helper text"
        }

        func createTextView(values: AndesTextFieldCodeTestValues = DefaultValues()) -> AndesTextFieldCode {
            return AndesTextFieldCode(label: values.label, helpLabel: values.helpLabel, style: values.style, state: values.state)
        }

        beforeEach {
            self.textInputView = createTextView()
            self.internalView = self.textInputView.contentView as? AndesTextFieldCodeAbstractView
        }

        afterEach {
            self.textInputView = nil
            self.internalView = nil
        }

        describe("Tests AndesTextFieldCode") {

            context("AndesTextFieldCode properties") {
                it("Initial properties correctly setted") {
                    //Given
                    let values: AndesTextFieldCodeTestValues = DefaultValues()

                    //When using default view

                    //Expect
                    expect(self.internalView?.label.text).to(equal(values.label))
                    expect(self.internalView?.helpLabel.text).to(equal(values.helpLabel))
                    expect(self.internalView?.config.state).to(equal(values.state))
                    expect(self.internalView?.config.style).to(equal(values.style))
                }

                it("Changes label correctly") {
                    //Given
                    let modifiedLabel = ModifiedValues().label

                    //When
                    self.textInputView.label = modifiedLabel

                    //Expect
                    expect(self.internalView?.label.text).to(equal(modifiedLabel))
                }

                it("Changes helpLabel correctly") {
                    //Given
                    let modifiedHelpLabel = ModifiedValues().helpLabel

                    //When
                    self.textInputView.helpLabel = modifiedHelpLabel

                    //Expect
                    expect(self.internalView?.helpLabel.text).to(equal(modifiedHelpLabel))
                }

                it("Changes style correctly") {
                    //Given
                    let modifiedStyle = ModifiedValues().style

                    //When
                    self.textInputView.style = modifiedStyle
                    self.internalView = self.textInputView.contentView as? AndesTextFieldCodeAbstractView

                    //Expect
                    expect(self.internalView?.config.style).to(equal(modifiedStyle))
                }

                it("Changes state correctly") {
                    //Given
                    let modifiedState = ModifiedValues().state

                    //When
                    self.textInputView.state = modifiedState

                    //Expect
                    expect(self.internalView?.config.state).to(equal(modifiedState))
                }
            }

            context("AndesTextFieldCode helperIconImageVIew") {
                it("When state is IDLE, helperIconImageVIew is not shown") {
                    //Given
                    //When
                    self.textInputView.state = .IDLE

                    //Then
                    expect(self.internalView?.helperIconImageView.isHidden).to(beTrue())
                }

                it("When state is DISABLED, helperIconImageVIew is not shown") {
                    //Given
                    //When
                    self.textInputView.state = .DISABLED

                    //Then
                    expect(self.internalView?.helperIconImageView.isHidden).to(beTrue())
                }

                it("When state is ERROR, helperIconImageVIew is shown") {
                    //Given
                    //When
                    self.textInputView.state = .ERROR

                    //Then
                    expect(self.internalView?.helperIconImageView.isHidden).to(beFalse())
                }
            }

            context("AndesTextFieldCode focus behaviour") {
                it("When AndesTextFieldCode is instantiated it is not focused") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    //Then
                    let firstTextField = self.internalView?.stackView.arrangedSubviews.first as? AndesTextField
                    expect(firstTextField?.isFirstResponder).to(beFalse())
                }

                it("When variable 'text' is set BEFORE AndesTextFieldCode is added to its parent window the component should not be focused") {
                    //Given
                    //When
                    let window = UIWindow()
                    self.textInputView.text = "12"
                    window.addSubview(self.textInputView)

                    //Then
                    let lastTextField = self.internalView?.stackView.arrangedSubviews.last as? AndesTextField
                    expect(lastTextField?.isFirstResponder).to(beFalse())
                }

                it("When variable 'text' is set AFTER AndesTextFieldCode is added to its parent window the component should be focused in the first empty textfield") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    // When
                    self.textInputView.text = "12"

                    //Then
                    let lastTextField = self.internalView?.stackView.arrangedSubviews.last as? AndesTextField
                    expect(lastTextField?.isFirstResponder).to(beTrue())
                }

                it("When setFocus() func is called AndesTextFieldCode is focused") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    // When
                    self.textInputView.setFocus()

                    //Then
                    let firstTextField = self.internalView?.stackView.arrangedSubviews.first as? AndesTextField
                    expect(firstTextField?.isFirstResponder).to(beTrue())

                    // When
                    self.textInputView.text = "123"

                    //Then
                    let lastTextField = self.internalView?.stackView.arrangedSubviews.last as? AndesTextField
                    expect(lastTextField?.isFirstResponder).to(beTrue())
                }

                it("When removeFocus() func is called AndesTextFieldCode loses focus") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    // When
                    self.textInputView.text = "12"
                    self.textInputView.removeFocus()

                    //Then
                    let lastTextField = self.internalView?.stackView.arrangedSubviews.last as? AndesTextField
                    expect(lastTextField?.isFirstResponder).to(beFalse())
                }

                it("When textField is filled and it is not the last textField focus si set on the next textField") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.textInputView.text = "1"

                    //Then
                    let secondTextField = self.internalView?.stackView.arrangedSubviews[1] as? AndesTextField
                    expect(secondTextField?.isFirstResponder).to(beTrue())
                }

                it("When last textField is filled focus stays in the last textField") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.textInputView.text = "123"

                    //Then
                    expect(self.internalView.stackView.arrangedSubviews.last?.isFirstResponder).to(beTrue())
                }
            }

            context("AndesTextFieldCode text behaviuor") {
                it("Text allows only numeric characters") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.textInputView.text = "abht<>,.-;:_´ç`+{}[]!#$%&/()?¿"

                    //Then
                    expect(self.internalView?.text.isEmpty).to(beTrue())
                }

                it("When empty String is set to 'text' it is cleaned") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)
                    self.textInputView.text = "123"

                    //When
                    self.textInputView.text = ""

                    //Then
                    expect(self.internalView?.text.isEmpty).to(beTrue())
                }

                it("When non-numeric and numeric characters are set at the same time only numeric characters are taken as valid") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.textInputView.text = "1th?2&% $6"

                    //Then
                    expect(self.internalView?.text == "126").to(beTrue())
                }

                it("When non-numeric characters are set to 'text' and 'text' already has a not empty String, 'text' maintains its value") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)
                    self.textInputView.text = "123"

                    //When
                    self.textInputView.text = "syjw<>*^}{$%&/()"

                    //Then
                    expect(self.internalView?.text == "123").to(beTrue())
                }

                it("When 'text' is set characters are taken until they complete the component boxes") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.textInputView.text = "123456789"

                    //Then
                    expect(self.internalView?.text == "123").to(beTrue())
                }
            }

            context("AndesTextFieldCode delegate") {
                it("TextDidComplete func receives a Bool parameter that tells if AndesTextFieldCode is completed or not. TextDidChange func receives a String parameter with the current 'text' value") {
                    //Given
                    let window = UIWindow()
                    self.textInputView.delegate = self
                    window.addSubview(self.textInputView)

                    //When
                    self.textInputView.text = "1"

                    // Then
                    expect(self.textDidChange == "1").to(beTrue())
                    expect(self.textDidComplete == false).to(beTrue())

                    //When
                    self.textInputView.text = "1f$% &23"

                    // Then
                    expect(self.textDidChange == "123").to(beTrue())
                    expect(self.textDidComplete == true).to(beTrue())
                }
            }
        }
    }
}
