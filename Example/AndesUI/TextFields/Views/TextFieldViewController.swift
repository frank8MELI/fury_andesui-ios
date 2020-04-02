//
//  TextFieldViewController.swift
//  AndesUI-demoapp
//
//  Created by Martin Damico on 13/03/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

protocol TextFieldView: NSObject {

}

class TextFieldViewController: UIViewController, TextFieldView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: AndesTextField!
    @IBOutlet weak var stateTField: UITextField!
    @IBOutlet weak var typeField: UITextField!
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

    var state: AndesTextFieldState = .idle
    var type: AndesTextFieldType = .simple
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
            "Sufijo": { return AndesTextFieldComponentLabel(text: "Sufix")},
            "Icon": { return AndesTextFieldComponentIcon(andesIconName: "andes_ui_feedback_info_16", tintColor: UIColor.red)},
            "Clear": { return AndesTextFieldComponentClear() }
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
        textField.textInputTraits = .numberPad
        textField.leftComponent = AndesTextFieldComponentLabel(text: "Prefix")
        textField.rightComponent = AndesTextFieldComponentCheck()
        configView.isHidden = true
    }

    fileprivate func setupButtons() {
        updateButton.setText("message.button.updateConfig".localized)
        .setHierarchy(.loud)
        .setSize(.large)
        configToggleButton.setText("message.button.changeConfig".localized)
        .setHierarchy(.quiet)
        .setSize(.medium)
    }

    func createPickerViews() {
        stateTField.inputView = statePicker
        leftCompField.inputView = leftCompPicker
        rightCompField.inputView = rightCompPicker
        typeField.inputView = typePicker
        statePicker.delegate = self
        statePicker.dataSource = self

        leftCompPicker.delegate = self
        leftCompPicker.dataSource = self

        rightCompPicker.delegate = self
        rightCompPicker.dataSource = self

        typePicker.delegate = self
        typePicker.dataSource = self

    }

    func createTextViews() {
        counterField.delegate = self
    }

    @IBAction func updateTapped(_ sender: Any) {
        if counterField.text != nil {
            let counter: UInt16 = UInt16(counterField.text!) ?? 0
            textField.counter = counter
        }
        textField.leftComponent = self.leftComponents[leftCompField.text!]!()
        textField.rightComponent = self.rightComponents[rightCompField.text!]!()
        textField.type = AndesTextFieldType(typeField.text!)!
    }

    @IBAction func toggleTapped(_ sender: Any) {
        if !self.configView.isHidden {
            self.configToggleButton.setText("message.button.changeConfig".localized)
                .setHierarchy(.quiet)

        } else {
            self.configToggleButton.setText("message.button.hideConfig".localized)
                .setHierarchy(.transparent)

        }

        UIView.transition(with: configView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.configView.isHidden = !self.configView.isHidden

        }, completion: { _ in

            if self.configView.isHidden {
                //self.scrollView.setContentOffset(.zero, animated: true)
            } else {
                //self.scrollView.scrollRectToVisible(self.configView.frame, animated: true)
            }
        })
    }
}

extension TextFieldViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            self.stateTField.resignFirstResponder()
            self.state = AndesTextFieldState.init(rawValue: row)!
            stateTField.text = state.description
            textField.state = state

        } else if pickerView == leftCompPicker {
            self.leftCompField.resignFirstResponder()
            leftCompField.text = Array(leftComponents.keys.sorted())[row]

        } else if pickerView == rightCompPicker {
            self.rightCompField.resignFirstResponder()
            rightCompField.text = Array(rightComponents.keys.sorted())[row]
        } else if pickerView == typePicker {
            self.typeField.resignFirstResponder()
            let type = AndesTextFieldType(rawValue: row)!
            typeField.text = type.description

            leftCompField.isEnabled = type == .simple
            rightCompField.isEnabled = type == .simple

        }
    }
}

extension TextFieldViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return 4
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
            let state = AndesTextFieldState.init(rawValue: row)!
            return state.description
        }
        if pickerView == leftCompPicker {
            return Array(leftComponents.keys.sorted())[row]
        }
        if pickerView == rightCompPicker {
            return Array(rightComponents.keys.sorted())[row]
        }
        if pickerView == typePicker {
            return AndesTextFieldType(rawValue: row)?.description
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
