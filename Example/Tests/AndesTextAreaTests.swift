//
//  AndesTextAreaTests.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 4/21/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI
protocol AndesTextAreaTestValues {
    var state: AndesTextInputState { get }
    var label: String { get }
    var placeholder: String { get }
    var helper: String { get }
    var counter: UInt16 { get }
    var counterLabel: String { get }
    var actionText: String { get }
    var maxLines: UInt16 { get }
}

class TestTextAreaDelegate: AndesTextAreaDelegate {
    var returnValue = false
    var shouldBeginEditingCalled = false
    var shouldEndEditingCalled = false
    var didBeginEditingCalled = false
    var didEndEditingCalled = false
    var shouldChangeCharsCalled = false
    var didChangeSelectionCalled = false
    var didChangeCalled = false

    func andesTextAreaShouldBeginEditing(_ textArea: AndesTextArea) -> Bool {
        shouldBeginEditingCalled = true
        return returnValue
    }

    func andesTextAreaShouldEndEditing(_ textArea: AndesTextArea) -> Bool {
        shouldEndEditingCalled = true
        return returnValue
    }

    func andesTextAreaDidBeginEditing(_ textArea: AndesTextArea) {
        didBeginEditingCalled = true
    }

    func andesTextAreaDidEndEditing(_ textArea: AndesTextArea) {
        didEndEditingCalled = true
    }

    func andesTextArea(_ textArea: AndesTextArea, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        shouldChangeCharsCalled = true
        return returnValue
    }

    func andesTextAreaDidChangeSelection(_ textArea: AndesTextArea, selectedRange range: UITextRange?) {
        didChangeSelectionCalled = true
    }

    func andesTextAreaDidChange(_ textArea: AndesTextArea) {
        didChangeCalled = true
    }
}

class AndesTextAreaTests: QuickSpec {
    var internalView: AndesTextAreaView!
    var textInputView: AndesTextArea!
    override func spec() {
        struct DefaultValues: AndesTextAreaTestValues {
            let state: AndesTextInputState = .idle
            let label = "Label"
            let helper = "Helper"
            let counter: UInt16 = 3
            let counterLabel = "0 / 3"
            let placeholder = "Placeholder"
            let actionText = "Action"
            var maxLines: UInt16 = 3
        }

        struct ModifiedValues: AndesTextAreaTestValues {
            let state: AndesTextInputState = .idle
            let label = "Label Changed"
            let helper = "Helper Changed"
            let counter: UInt16 = 5
            let counterLabel = "0 / 5"
            let placeholder = "Placeholder Changed"
            let actionText = "Action Changed"
            let maxLines: UInt16 = 4
        }

        func createTextView(values: AndesTextAreaTestValues = DefaultValues()) -> AndesTextArea {
            return AndesTextArea(state: .idle, label: values.label, helper: values.helper, counter: values.counter, placeholder: values.placeholder)
        }

        beforeEach {
            self.textInputView = createTextView()
            self.internalView = self.textInputView.contentView as? AndesTextAreaView
        }

        afterEach {
            self.textInputView = nil
            self.internalView = nil
        }

        describe("Tests AndesTextArea") {
            context("AndesTextArea updates internal labels") {
                it("Initial labels correctly setted") {
                    //Given
                    let values = DefaultValues()

                    //When using default view

                    //Expect
                    expect(self.internalView?.labelLabel.text).to(equal(values.label))
                    expect(self.internalView?.helperLabel.text).to(equal(values.helper))
                    expect(self.internalView?.placeholderLabel.text).to(equal(values.placeholder))
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
                    expect(self.internalView?.placeholderLabel.text).to(equal(modifiedValue))
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
                    //Given default view

                    //When
                    self.textInputView.text = "Four"

                    //Expect
                    expect(self.internalView?.counterLabel.text).to(equal("3 / 3"))
                    expect(self.internalView?.text).to(equal("Fou"))
                }
            }

            context("AndesTextArea state changes, updates style") {
                it("When icon set, helperIcon ImageVIew is shown") {
                    //Given default values
                    //When
                    self.textInputView.state = .error

                    //Then
                    expect(self.internalView?.helperIconImageView.isHidden).to(beFalse())
                }
            }

            context("AndesTextArea state changes, updates border") {
                it("border properties updates correctly") {
                    //Given
                    let config = AndesTextFieldStateError(focuesd: false)

                    //When
                    self.textInputView.state = .error

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
            }

            context("AndesTextField inputTraits") {
                it("When numberPad set, keyboard type updates") {
                    //Given
                    let trait: AndesTextInputTraits = .numberPad

                    //When
                    self.textInputView.textInputTraits = trait

                    //Then
                    expect(self.internalView.textView.keyboardType).to(equal(.numberPad))
                }

                it("When password set, input is secure text entry ") {
                    //Given
                    let trait: AndesTextInputTraits = .password

                    //When
                    self.textInputView.textInputTraits = trait

                    //Then
                    expect(self.internalView.textView.isSecureTextEntry).to(beTrue())
                }

                it("When email set, keyboard type set to email ") {
                    //Given
                    let trait: AndesTextInputTraits = .email

                    //When
                    self.textInputView.textInputTraits = trait

                    //Then
                    expect(self.internalView.textView.keyboardType).to(equal(.emailAddress))
                }

                it("can set custom input view") {
                    //given
                    let picker = UIPickerView()

                    //When
                    self.textInputView.inputView = picker

                    //Then
                    expect(self.internalView?.textView.inputView).to(beAKindOf(UIPickerView.self))
                }
            }

            context("AndesTextArea delegate tests") {
                it("andesTextAreaShouldBeginEditing called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    delegate.returnValue = false
                    let valueFalse = self.internalView?.textView.delegate?.textViewShouldBeginEditing?((self.internalView?.textView!)!)
                    delegate.returnValue = true
                    let valueTrue = self.internalView?.textView.delegate?.textViewShouldBeginEditing?((self.internalView?.textView!)!)

                    //Then
                    expect(delegate.shouldBeginEditingCalled).toEventually(beTrue())
                    expect(valueFalse).to(beFalse())
                    expect(valueTrue).to(beTrue())
                }

                it("andesTextAreaShouldEndEditing called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    delegate.returnValue = false
                    let valueFalse = self.internalView?.textView.delegate?.textViewShouldEndEditing?((self.internalView?.textView!)!)
                    delegate.returnValue = true
                    let valueTrue = self.internalView?.textView.delegate?.textViewShouldEndEditing?((self.internalView?.textView!)!)

                    //Then
                    expect(delegate.shouldEndEditingCalled).toEventually(beTrue())
                    expect(valueFalse).to(beFalse())
                    expect(valueTrue).to(beTrue())
                }

                it("shouldChangeChars called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    delegate.returnValue = false
                    let valueFalse = self.internalView?.textView.delegate?.textView?(self.internalView.textView, shouldChangeTextIn: NSRange(), replacementText: "")
                    delegate.returnValue = true
                    let valueTrue = self.internalView?.textView.delegate?.textView?(self.internalView.textView, shouldChangeTextIn: NSRange(), replacementText: "")

                    //Then
                    expect(delegate.shouldChangeCharsCalled).toEventually(beTrue())
                    expect(valueFalse).to(beFalse())
                    expect(valueTrue).to(beTrue())
                }

                it("andesTextAreaDidBeginEditing called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView?.textView.delegate?.textViewDidBeginEditing?((self.internalView?.textView!)!)

                    //Then
                    expect(delegate.didBeginEditingCalled).toEventually(beTrue())
                }

                it("andesTextAreaDidEndEditing called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView?.textView.delegate?.textViewDidEndEditing?((self.internalView?.textView!)!)

                    //Then
                    expect(delegate.didEndEditingCalled).toEventually(beTrue())
                }

                it("andesTextAreaDidChangeSelection called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView?.textView.delegate?.textViewDidChangeSelection?(self.internalView.textView)

                    //Then
                    expect(delegate.didChangeSelectionCalled).toEventually(beTrue())
                }

                it("andesTextAreaDidChange called") {
                    // Given
                    let delegate = TestTextAreaDelegate()
                    self.textInputView.delegate = delegate

                    // When
                    self.internalView?.textView.delegate?.textViewDidChange?(self.internalView.textView)

                    //Then
                    expect(delegate.didChangeCalled).toEventually(beTrue())
                }
            }

            context("AndesTextArea keyboard management") {
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
