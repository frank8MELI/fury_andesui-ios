//
//  AndesCheckboxInitViewController.swift
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 6/24/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class AndesCheckboxInitViewController: UIViewController {

    var typePicker: UIPickerView = UIPickerView()
    var statusPicker: UIPickerView = UIPickerView()
    var alignPicker: UIPickerView = UIPickerView()

    @IBOutlet weak var andesCheckbox: AndesCheckbox!
    @IBOutlet weak var typeTxt: UITextField!
    @IBOutlet weak var statusTxt: UITextField!
    @IBOutlet weak var alignTxt: UITextField!
    @IBOutlet weak var numberOfLinesTxt: UITextField!
    @IBOutlet weak var checkboxTxt: UITextField!

    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    override func viewDidLoad() {
        self.andesCheckbox.setCheckboxDidTapped(callback: didTapIdle(checkbox:))
        createPickerViews()
    }

    func createPickerViews() {
        typeTxt.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
        typeTxt.text = self.andesCheckbox.type.toString()

        statusTxt.inputView = statusPicker
        statusPicker.delegate = self
        statusPicker.dataSource = self
        statusTxt.text = self.andesCheckbox.status.toString()

        alignTxt.inputView = alignPicker
        alignPicker.delegate = self
        alignPicker.dataSource = self
        alignTxt.text = self.andesCheckbox.align.toString()
    }

    @IBAction func updateTapped(_ sender: Any) {
        andesCheckbox.title = checkboxTxt.text
        let numberOfLines = Int(numberOfLinesTxt.text ?? "1") ?? 1
        andesCheckbox.titleNumberOfLines = numberOfLines
    }

    @IBAction func clearTapped(_ sender: Any) {
        self.andesCheckbox.title = "Andes Checkbox"
        self.andesCheckbox.type = AndesCheckboxType.idle
        self.andesCheckbox.status = AndesCheckboxStatus.unselected
        self.andesCheckbox.align = AndesCheckboxAlign.left
        self.andesCheckbox.titleNumberOfLines = 1
        typeTxt.text = self.andesCheckbox.type.toString()
        statusTxt.text = self.andesCheckbox.status.toString()
        alignTxt.text = self.andesCheckbox.align.toString()

        checkboxTxt.text = ""
        numberOfLinesTxt.text = ""
    }

    func didTapIdle(checkbox: AndesCheckbox) {
        switch checkbox.type {
        case .idle:
            break
        case .disabled:
            break
        case .error:
            break
        }
    }
}

extension AndesCheckboxInitViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typePicker {
           typeTxt.resignFirstResponder()
            self.andesCheckbox.type = AndesCheckboxType.init(rawValue: row)!
            typeTxt.text = self.andesCheckbox.type.toString()
        }
        if pickerView == statusPicker {
            statusTxt.resignFirstResponder()
            self.andesCheckbox.status = AndesCheckboxStatus.init(rawValue: row)!
            statusTxt.text = self.andesCheckbox.status.toString()

        }
        if pickerView == alignPicker {
            alignTxt.resignFirstResponder()
            self.andesCheckbox.align = AndesCheckboxAlign.init(rawValue: row)!
            alignTxt.text = self.andesCheckbox.align.toString()
        }
    }
}

extension AndesCheckboxInitViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePicker {
            return 3
        }
        if pickerView == statusPicker {
            return 3
        }
        if pickerView == alignPicker {
            return 2
        }
        return 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == typePicker {
            let type = AndesCheckboxType.init(rawValue: row)!
            return type.toString()
        }
        if pickerView == statusPicker {
             let status = AndesCheckboxStatus.init(rawValue: row)!
            return status.toString()
        }
        if pickerView == alignPicker {
             let align = AndesCheckboxAlign.init(rawValue: row)!
            return align.toString()
        }
        return ""
    }
}
