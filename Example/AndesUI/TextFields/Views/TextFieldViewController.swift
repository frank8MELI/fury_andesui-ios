//
//  TextFieldViewController.swift
//  AndesUI-demoapp
//
//  Created by Martin Damico on 13/03/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

class TextFieldViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: AndesTextField!
    @IBOutlet weak var stateTField: UITextField!
    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var placeholderField: UITextField!
    @IBOutlet weak var helperField: UITextField!
    @IBOutlet weak var counterField: UITextField!
    @IBOutlet weak var leftCompField: UITextField!
    @IBOutlet weak var rightCompField: UITextField!
    @IBOutlet weak var updateButton: AndesButton!
    @IBOutlet weak var configToggleButton: AndesButton!
    @IBOutlet weak var configView: UIView!

    var statePicker: UIPickerView = UIPickerView()
    var typePicker: UIPickerView = UIPickerView()
    var leftCompPicker: UIPickerView = UIPickerView()
    var rightCompPicker: UIPickerView = UIPickerView()

    var state: AndesTextInputState = .idle
    var leftComponents: [String: () -> AndesTextFieldLeftComponent?] {
        return [
            "None": { return nil },
            "Prefix": { return AndesTextFieldComponentLabel(text: "Prefix")},
            "Icon": { return AndesTextFieldComponentIcon(andesIconName: "andes_ui_feedback_info_16", tintColor: UIColor.red)}
        ]
    }

    var rightComponents: [String: () -> AndesTextFieldRightComponent?] {
        return [
            "None": { return nil },
            "Suffix": { return AndesTextFieldComponentLabel(text: "Suffix")},
            "Icon": { return AndesTextFieldComponentIcon(andesIconName: "andes_ui_feedback_info_16", tintColor: UIColor.red)},
            "Clear": { return AndesTextFieldComponentClear() },
            "Check": { return AndesTextFieldComponentCheck() },
            "Action": { return AndesTextFieldComponentAction("Label") }
        ]
    }

    var textTriggers: [String: () -> Void] {
        return [
            "CHECK": { [weak self] in self?.textField.rightContent = AndesTextFieldComponentCheck() },
            "CHEC": { [weak self] in self?.textField.rightContent = AndesTextFieldComponentClear() },
            "ERROR": { [weak self] in self?.textField.state = .error },
            "ERRO": { [weak self] in self?.textField.state = .idle },
            "WARNIN": { [weak self] in self?.textField.state = .warning },
            "WARNINING": { [weak self] in self?.textField.state = .warning }
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        createPickerViews()
        createTextViews()
        setupUI()
    }

    func setupUI() {
        textField.leftContent = AndesTextFieldComponentLabel(text: "Prefix")
        textField.rightContent = AndesTextFieldComponentClear()
        configView.isHidden = true
        textField.delegate = self
    }

    fileprivate func setupButtons() {
        updateButton.text = "message.button.updateConfig".localized
        updateButton.hierarchy = .loud
        updateButton.size = .large
        configToggleButton.text = "message.button.changeConfig".localized
        configToggleButton.hierarchy = .quiet
        configToggleButton.size = .medium
    }

    func createPickerViews() {
        stateTField.inputView = statePicker
        leftCompField.inputView = leftCompPicker
        rightCompField.inputView = rightCompPicker
        statePicker.delegate = self
        statePicker.dataSource = self

        leftCompPicker.delegate = self
        leftCompPicker.dataSource = self

        rightCompPicker.delegate = self
        rightCompPicker.dataSource = self
    }

    func createTextViews() {
        counterField.delegate = self
    }

    @IBAction func updateTapped(_ sender: Any) {
        let counter: UInt16 = UInt16(counterField.text!) ?? 0
        textField.counter = counter
        textField.leftContent = self.leftComponents[leftCompField.text!]!()
        textField.rightContent = self.rightComponents[rightCompField.text!]!()
        textField.label = self.labelField.text
        textField.placeholder = self.placeholderField.text
        textField.helper = self.helperField.text
        textField.state = self.state
    }

    @IBAction func toggleTapped(_ sender: Any) {
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

extension TextFieldViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            self.stateTField.resignFirstResponder()
            self.state = AndesTextInputState.init(rawValue: row)!
            stateTField.text = state.toString()

        } else if pickerView == leftCompPicker {
            self.leftCompField.resignFirstResponder()
            leftCompField.text = Array(leftComponents.keys.sorted())[row]

        } else if pickerView == rightCompPicker {
            self.rightCompField.resignFirstResponder()
            rightCompField.text = Array(rightComponents.keys.sorted())[row]
        }
    }
}

extension TextFieldViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return AndesTextInputState.allCases.count
        }
        if pickerView == leftCompPicker {
            return leftComponents.count
        }
        if pickerView == rightCompPicker {
            return rightComponents.count
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
        if pickerView == leftCompPicker {
            return Array(leftComponents.keys.sorted())[row]
        }
        if pickerView == rightCompPicker {
            return Array(rightComponents.keys.sorted())[row]
        }
        return ""
    }
}

extension TextFieldViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
          -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension TextFieldViewController: AndesTextFieldDelegate {
    func andesTextFieldDidTapRightAction(_ textField: AndesTextField) {
        let alert = UIAlertController(title: "Right action pressed", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func andesTextFieldDidChange(_ textField: AndesTextField) {
        let str = textField.text.uppercased()
        textTriggers[str]?()
    }
}
