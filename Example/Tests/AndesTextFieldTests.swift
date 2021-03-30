//
//  AndesTextFieldTests.swift
//  AndesUI_Tests
//
//  Created by Martin Damico on 01/04/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI
protocol AndesTextFieldTestValues {
    var state: AndesTextInputState { get }
    var label: String { get }
    var placeholder: String { get }
    var helper: String { get }
    var counter: UInt16 { get }
    var counterLabel: String { get }
    var actionText: String { get }
}

class TestTextFieldDelegate: AndesTextFieldDelegate {
    var returnValue = false
    var shouldBeginEditingCalled = false
    var shouldEndEditingCalled = false
    var didBeginEditingCalled = false
    var didEndEditingCalled = false
    var shouldChangeCharsCalled = false
    var didChangeSelectionCalled = false
    var didChangeCalled = false
    var didTapRightAction = false
    var shouldReturnCalled = false

    func andesTextFieldShouldBeginEditing(_ textField: AndesTextField) -> Bool {
        shouldBeginEditingCalled = true
        return returnValue
    }

    func andesTextFieldShouldEndEditing(_ textField: AndesTextField) -> Bool {
        shouldEndEditingCalled = true
        return returnValue
    }

    func andesTextFieldDidBeginEditing(_ textField: AndesTextField) {
        didBeginEditingCalled = true
    }

    func andesTextFieldDidEndEditing(_ textField: AndesTextField) {
        didEndEditingCalled = true
    }

    func andesTextField(_ textField: AndesTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        shouldChangeCharsCalled = true
        return returnValue
    }

    func andesTextFieldDidChangeSelection(_ textField: AndesTextField, selectedRange range: UITextRange?) {
        didChangeSelectionCalled = true
    }

    func andesTextFieldDidChange(_ textField: AndesTextField) {
        didChangeCalled = true
    }

    func andesTextFieldDidTapRightAction(_ textField: AndesTextField) {
        didTapRightAction = true
    }

    func andesTextFieldShouldReturn(_ textField: AndesTextField) -> Bool {
        shouldReturnCalled = true
        return true
    }
}

class AndesTextFieldTests: QuickSpec {

    var internalView: AndesTextFieldDefaultView!
    var textInputView: AndesTextField!

    override func spec() {
        struct DefaultValues: AndesTextFieldTestValues {
            let state: AndesTextInputState = .idle
            let label = "Label"
            let helper = "Helper"
            let counter: UInt16 = 3
            let counterLabel = "0 / 3"
            let placeholder = "Placeholder"
            let actionText = "Action"
        }

        struct ModifiedValues: AndesTextFieldTestValues {
            let state: AndesTextInputState = .idle
            let label = "Label Changed"
            let helper = "Helper Changed"
            let counter: UInt16 = 5
            let counterLabel = "0 / 5"
            let placeholder = "Placeholder Changed"
            let actionText = "Changed Action"
        }

        func createTextView(values: AndesTextFieldTestValues = DefaultValues()) -> AndesTextField {
            return AndesTextField(state: .idle, label: values.label, helper: values.helper, counter: values.counter, placeholder: values.placeholder)
        }

        beforeEach {
            self.textInputView = createTextView()
            self.internalView = self.textInputView.contentView as? AndesTextFieldDefaultView
        }

        afterEach {
            self.textInputView = nil
            self.internalView = nil
        }

        describe("Tests AndesTextField") {
            context("AndesTextField updates internal labels") {
                it("Initial labels correctly setted") {
                    //Given
                    let values: AndesTextFieldTestValues = DefaultValues()

                    //When using default view
                    //Expect
                    expect(self.internalView?.labelLabel.text).to(equal(values.label))
                    expect(self.internalView?.helperLabel.text).to(equal(values.helper))
                    expect(self.internalView?.textField.placeholder).to(equal(values.placeholder))
                    expect(self.internalView?.counterLabel.text).to(equal(values.counterLabel))
                }

                it("Changes label correctly") {
                    //Given
                    let modifiedLabel = ModifiedValues().label

                    //When
                    self.textInputView.label = modifiedLabel

                    //Expect
                    expect(self.internalView?.labelLabel.text).to(equal(modifiedLabel))
                }

                it("Changes placeholder correctly") {
                    //Given
                    let modifiedValue = ModifiedValues().placeholder

                    //When
                    self.textInputView.placeholder = modifiedValue

                    //Expect
                    expect(self.internalView?.textField.placeholder).to(equal(modifiedValue))
                }

                it("Changes helper correctly") {
                    //Given
                    let modifiedValue = ModifiedValues().helper

                    //When
                    self.textInputView.helper = modifiedValue

                    //Expect
                    expect(self.internalView?.helperLabel.text).to(equal(modifiedValue))
                }

                it("Changes counter correctly") {
                    //Given
                    let modifiedValue = ModifiedValues().counter
                    let modifiedLabel = ModifiedValues().counterLabel

                    //When
                    self.textInputView.counter = modifiedValue

                    //Expect
                    expect(self.internalView?.counterLabel.text).to(equal(modifiedLabel))
                }

                it("Counter label updates on text changes correctly, and trims the text if needed") {
                    //Given default values
                    //When
                    self.textInputView.text = "Four"

                    //Expect
                    expect(self.internalView?.counterLabel.text).to(equal("3 / 3"))
                    expect(self.internalView?.text).to(equal("Fou"))
                }
            }

            context("AndesTextField state changes, updates style") {
                it("When icon set, helperIcon ImageVIew is shown") {
                    //Given

                    //When
                    self.textInputView.state = .error

                    //Then
                    expect(self.internalView?.helperIconImageView.isHidden).to(beFalse())
                }
            }

            context("AndesTextField inputTraits") {
                it("When numberPad set, keyboard type updates") {
                    //Given
                    let trait: AndesTextInputTraits = .numberPad

                    //When
                    self.textInputView.textInputTraits = trait

                    //Then
                    expect(self.internalView.textField.keyboardType).to(equal(.numberPad))
                }

                it("When password set, input is secure text entry ") {
                    //Given
                    let trait: AndesTextInputTraits = .password

                    //When
                    self.textInputView.textInputTraits = trait

                    //Then
                    expect(self.internalView.textField.isSecureTextEntry).to(beTrue())
                }

                it("When email set, keyboard type set to email ") {
                    //Given
                    let trait: AndesTextInputTraits = .email

                    //When
                    self.textInputView.textInputTraits = trait

                    //Then
                    expect(self.internalView.textField.keyboardType).to(equal(.emailAddress))
                }
            }

            context("AndesTextField state changes, updates border") {
                it("border properties updates correctly") {
                    //Given
                    let config = AndesTextFieldStateError(focuesd: false)

                    //When
                    self.self.textInputView.state = .error

                    //Then
                    expect(self.internalView?.borderLayer?.strokeColor).to(equal(config.borderColor.cgColor))
                    expect(self.internalView?.borderLayer?.lineWidth).to(equal(config.borderWidth))
                }

                it("border updates when textfield first responder") {
                    //Given
                    let config = AndesTextFieldStateIdle(focuesd: true)
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.internalView?.fieldView.becomeFirstResponder()

                    //Then
                    expect(self.internalView?.borderLayer?.strokeColor).to(equal(config.borderColor.cgColor))
                    expect(self.internalView?.borderLayer?.lineWidth).to(equal(config.borderWidth))
                }

                it("border layer changed when config dashed") {
                    //Given default values

                    //When
                    self.textInputView.state = .disabled

                    //Then
                    expect(self.internalView?.borderLayer).to(beAKindOf(AndesTextFieldBorderLayerDashed.self))
                }

                it("can set custom input view") {
                    //given
                    let picker = UIPickerView()

                    //When
                    self.textInputView.inputView = picker

                    //Then
                    expect(self.internalView?.textField.inputView).to(beAKindOf(UIPickerView.self))
                }
            }
            context("AndesTextField delegate tests") {
                it("andesTextFieldShouldBeginEditing called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    delegate.returnValue = false
                    let valueFalse = self.internalView?.textField.delegate?.textFieldShouldBeginEditing?(self.internalView.textField)
                    delegate.returnValue = true
                    let valueTrue = self.internalView?.textField.delegate?.textFieldShouldBeginEditing?(self.internalView.textField)

                    //Then
                    expect(delegate.shouldBeginEditingCalled).toEventually(beTrue())
                    expect(valueFalse).to(beFalse())
                    expect(valueTrue).to(beTrue())
                }

                it("andesTextFieldShouldEndEditing called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    delegate.returnValue = false
                    let valueFalse = self.internalView?.textField.delegate?.textFieldShouldEndEditing?(self.internalView.textField)
                    delegate.returnValue = true
                    let valueTrue = self.internalView?.textField.delegate?.textFieldShouldEndEditing?(self.internalView.textField)

                    //Then
                    expect(delegate.shouldEndEditingCalled).toEventually(beTrue())
                    expect(valueFalse).to(beFalse())
                    expect(valueTrue).to(beTrue())
                }

                it("shouldChangeChars called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    delegate.returnValue = false
                    let valueFalse = self.internalView.textField.delegate?.textField?(self.internalView.textField, shouldChangeCharactersIn: NSRange(), replacementString: "")
                    delegate.returnValue = true
                    let valueTrue = self.internalView.textField.delegate?.textField?(self.internalView.textField, shouldChangeCharactersIn: NSRange(), replacementString: "")

                    //Then
                    expect(delegate.shouldChangeCharsCalled).toEventually(beTrue())
                    expect(valueFalse).to(beFalse())
                    expect(valueTrue).to(beTrue())
                }

                it("andesTextFieldDidBeginEditing called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView?.textField.delegate?.textFieldDidBeginEditing?(self.internalView.textField)

                    //Then
                    expect(delegate.didBeginEditingCalled).toEventually(beTrue())
                }

                it("andesTextFieldDidEndEditing called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView?.textField.delegate?.textFieldDidEndEditing?(self.internalView.textField)

                    //Then
                    expect(delegate.didEndEditingCalled).toEventually(beTrue())
                }

                it("andesTextFieldDidChangeSelection called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    if #available(iOS 13.0, *) {
                        // When
                        self.internalView?.textField.delegate?.textFieldDidChangeSelection?(self.internalView.textField)
                        // Expect
                        expect(delegate.didChangeSelectionCalled).toEventually(beTrue())
                    } else {
                        expect(true).to(beTrue())
                    }
                }

                it("andesTextFieldDidChange called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView.textChanged(self.internalView.textField)

                    //Then
                    expect(delegate.didChangeCalled).toEventually(beTrue())
                }

                it("andesTextFieldDidTapRightAction called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate
                    self.textInputView.rightContent = AndesTextFieldComponentAction("Action")

                    // When
                    let btn = self.internalView.textField.rightView as? AndesTextFieldActionView
                    btn?.tapped(UIControl())

                    //Then
                    expect(btn).notTo(beNil())
                    expect(delegate.didTapRightAction).toEventually(beTrue())
                }

                it("andesTextFieldShouldReturn called") {
                    // Given
                    let delegate = TestTextFieldDelegate()
                    self.textInputView.delegate = delegate
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    // When
                    _ = self.internalView.textField.becomeFirstResponder()
                    _ = self.internalView.textField.delegate?.textFieldShouldReturn?(self.internalView.textField)

                    //Then
                    expect(delegate.shouldReturnCalled).toEventually(beTrue())
                }
            }
            context("AndesTextField keyboard management") {
                it("responds to isFirstResponder") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    self.internalView.fieldView.becomeFirstResponder()

                    //Then
                    expect(self.textInputView.isFirstResponder).to(beTrue())
                }

                it("responds to becomeFirstResponder") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)

                    //When
                    _ = self.textInputView.becomeFirstResponder()

                    //Then
                    expect(self.textInputView.isFirstResponder).to(beTrue())
                }

                it("responds to resignFirstResponder") {
                    //Given
                    let window = UIWindow()
                    window.addSubview(self.textInputView)
                    _ = self.textInputView.becomeFirstResponder()

                    //When
                    _ = self.textInputView.resignFirstResponder()

                    //Then
                    expect(self.textInputView.isFirstResponder).to(beFalse())
                }
            }
        }
    }
}
