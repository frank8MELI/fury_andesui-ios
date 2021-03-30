//
//  TextAreaViewController.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 4/15/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

class TextAreaViewController: UIViewController {
    @IBOutlet weak var textField: AndesTextArea!
    @IBOutlet weak var configToggleButton: AndesButton!
    @IBOutlet weak var stateTField: UITextField!
    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var placeholderField: UITextField!
    @IBOutlet weak var helperField: UITextField!
    @IBOutlet weak var counterField: UITextField!
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var updateButton: AndesButton!
    @IBOutlet weak var boldAttributeText: UITextField!

    var statePicker: UIPickerView = UIPickerView()
    var typePicker: UIPickerView = UIPickerView()
    var state: AndesTextInputState = .idle

    var rightComponents: [String: () -> AndesTextFieldRightComponent?] {
        return [
            "None": { return nil },
            "Sufijo": { return AndesTextFieldComponentLabel(text: "Sufix")},
            "Icon": { return AndesTextFieldComponentIcon(andesIconName: "andes_ui_feedback_info_16", tintColor: UIColor.red)},
            "Clear": { return AndesTextFieldComponentClear() },
            "Action": { return AndesTextFieldComponentAction("Action A") }
        ]
    }

    var textTriggers: [String: () -> Void] {
        return [
            "ERROR": { [weak self] in self?.textField.state = .error },
            "ERRO": { [weak self] in self?.textField.state = .idle },
            "DISABLED": { [weak self] in self?.textField.state = .disabled },
            "DISABL": { [weak self] in self?.textField.state = .idle },
            "READ": { [weak self] in self?.textField.state = .readOnly },
            "REA": { [weak self] in self?.textField.state = .idle }
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerViews()
        createTextViews()
        setupUI()
    }

    func setupUI() {
        configView.isHidden = true
        textField.delegate = self
    }

    func createPickerViews() {
        stateTField.inputView = statePicker
        statePicker.delegate = self
        statePicker.dataSource = self
    }

    func createTextViews() {
        counterField.delegate = self
    }

    func attributedText(withString string: String, boldString: String) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: attributes)
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 14)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }

    @IBAction func updateBtnTapped(_ sender: Any) {
        let counter: UInt16 = UInt16(counterField.text!) ?? 0
        textField.counter = counter
        textField.label = self.labelField.text
        textField.placeholder = self.placeholderField.text
        textField.helper = self.helperField.text
        textField.state = self.state
        textField.attributeText = attributedText(withString: self.textField.text ,
                                                 boldString: boldAttributeText.text ?? "")
    }

    @IBAction func toggleConfigTapped(_ sender: Any) {
        if !self.configView.isHidden {
            self.configToggleButton.text = "message.button.changeConfig".localized
                self.configToggleButton.hierarchy = .quiet

        } else {
            self.configToggleButton.text = "message.button.hideConfig".localized
            self.configToggleButton.hierarchy = .transparent

        }

        UIView.transition(with: configView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.configView.isHidden = !self.configView.isHidden
        }, completion: nil)
    }
}

extension TextAreaViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            self.stateTField.resignFirstResponder()
            self.state = AndesTextInputState.init(rawValue: row)!
            stateTField.text = state.toString()
        }
    }
}

extension TextAreaViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return AndesTextInputState.allCases.count
        }
        if pickerView == typePicker {
            return 2
        }
        return 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == statePicker {
            let state = AndesTextInputState.init(rawValue: row)!
            return state.toString()
        }
        return ""
    }
}

extension TextAreaViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
          -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension TextAreaViewController: AndesTextAreaDelegate {
    func andesTextAreaDidChange(_ textField: AndesTextArea) {
        let str = textField.text.uppercased()
        textTriggers[str]?()
    }
}
