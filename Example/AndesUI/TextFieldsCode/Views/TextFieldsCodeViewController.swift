//
//  TextFieldsCodeViewController.swift
//  AndesUI-demoapp
//
//  Created by Esteban Adrian Boffa on 16/09/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

final class TextFieldsCodeViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var andesTextFieldCode: AndesTextFieldCode!
    @IBOutlet weak var textFieldCodeTitle: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!
    @IBOutlet weak var textTextField: UITextField!
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var helpLabelTextField: UITextField!
    @IBOutlet weak var updateButton: AndesButton!

    var statePicker: UIPickerView = UIPickerView()
    var stylePicker: UIPickerView = UIPickerView()
    var state: AndesTextFieldCodeState = .IDLE
    var style: AndesTextFieldCodeStyle = .THREESOME

    // AndesTextFieldCode programatically
    var textFieldCode: AndesTextFieldCode?

    override func viewDidLoad() {
        super.viewDidLoad()
        renderViews()
    }
}

// MARK: UI
private extension TextFieldsCodeViewController {
    func renderViews() {
//      Uncomment for instantiate AndesTextFieldCode programatically
//        andesTextFieldCode.removeFromSuperview()
//        textFieldCode = AndesTextFieldCode(label: nil, helpLabel: nil, style: .THREESOME, state: .IDLE)
//        if let textFieldCode = textFieldCode {
//            view.addSubview(textFieldCode)
//            NSLayoutConstraint.activate([
//                textFieldCode.topAnchor.constraint(equalTo: textFieldCodeTitle.bottomAnchor, constant: 24),
//                textFieldCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//                textFieldCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
//            ])
//        }

        andesTextFieldCode.delegate = self
        createPickerViews()
    }

    func createPickerViews() {
        statePicker.delegate = self
        statePicker.dataSource = self
        stateTextField.inputView = statePicker
        stylePicker.delegate = self
        stylePicker.dataSource = self
        styleTextField.inputView = stylePicker
    }
}

// MARK: Actions
private extension TextFieldsCodeViewController {
    @IBAction func updateTapped(_ sender: Any) {
        andesTextFieldCode?.style = style
        andesTextFieldCode?.state = state
        andesTextFieldCode?.text = textTextField.text ?? ""
        andesTextFieldCode?.label = labelTextField.text
        andesTextFieldCode?.helpLabel = helpLabelTextField.text

        // AndesTextFieldCode programatically
        textFieldCode?.style = style
        textFieldCode?.state = state
        textFieldCode?.text = textTextField.text ?? ""
        textFieldCode?.label = labelTextField.text
        textFieldCode?.helpLabel = helpLabelTextField.text
    }

    @IBAction func clearTapped(_ sender: Any) {
        andesTextFieldCode?.text = ""
        andesTextFieldCode?.label = ""
        andesTextFieldCode?.helpLabel = ""
        andesTextFieldCode?.state = .IDLE
        andesTextFieldCode?.style = .THREESOME

        // AndesTextFieldCode programatically
        textFieldCode?.text = ""
        textFieldCode?.label = ""
        textFieldCode?.helpLabel = ""
        textFieldCode?.state = .IDLE
        textFieldCode?.style = .THREESOME

        textTextField.text = ""
        labelTextField.text = ""
        helpLabelTextField.text = ""
        statePicker.selectRow(0, inComponent: 0, animated: true)
        pickerView(statePicker, didSelectRow: 0, inComponent: 0)
        stylePicker.selectRow(0, inComponent: 0, animated: true)
        pickerView(stylePicker, didSelectRow: 0, inComponent: 0)
    }
}

// MARK: UIPickerViewDelegate & UIPickerViewDataSource
extension TextFieldsCodeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            stateTextField.resignFirstResponder()
            state = AndesTextFieldCodeState.init(rawValue: row)!
            stateTextField.text = state.toString()
        } else if pickerView == stylePicker {
            styleTextField.resignFirstResponder()
            style = AndesTextFieldCodeStyle.init(rawValue: row)!
            styleTextField.text = style.toString()
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return 3
        }
        if pickerView == stylePicker {
            return 3
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePicker {
            let state = AndesTextFieldCodeState.init(rawValue: row)!
            return state.toString()
        }
        if pickerView == stylePicker {
            let style = AndesTextFieldCodeStyle.init(rawValue: row)!
            return style.toString()
        }
        return ""
    }
}

// MARK: AndesTextFieldCodeDelegate
extension TextFieldsCodeViewController: AndesTextFieldCodeDelegate {
    func textDidChange(_ text: String) {
        print("textDidChange: \(text)")
    }

    func textDidComplete(_ isComplete: Bool) {
        print("textDidComplete: \(isComplete)")
    }
}
