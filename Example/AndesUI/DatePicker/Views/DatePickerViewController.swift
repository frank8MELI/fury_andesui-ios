//
//  DatePickerViewController.swift
//  AndesUI-demoapp
//
//  Created by Ândriu Felipe Coelho on 14/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class DatePickerViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var datePickerView: AndesDatePicker!
    @IBOutlet weak var buttonSetDate: AndesButton!
    @IBOutlet weak var buttonReset: AndesButton!
    @IBOutlet weak var maxDateTextField: UITextField!

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDatePicker()
    }

    func setupView() {
        maxDateTextField.delegate = self

        buttonSetDate.text = "Set MIN MAX date"
        buttonSetDate.size = .medium

        buttonReset.text = "Reset"
        buttonReset.size = .medium
    }

    func setupDatePicker() {
        datePickerView.setDatePickerDate { (_, _ ) in }
    }

    func parse(date: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        guard let newDate = dateFormatter.date(from: date ?? "") else { return nil }
        return Calendar.current.date(byAdding: .day, value: 1, to: newDate)
    }

    // MARK: - IBActions

    @IBAction func didTouchSetDate(_ sender: AndesButton) {
        let maxDate = parse(date: maxDateTextField.text)
        datePickerView.setDatePickerDate(maxDate: maxDate) { (_, _ ) in }
    }

    @IBAction func didTouchResetCalendar(_ sender: AndesButton) {
        datePickerView.setDatePickerDate { (_, _ ) in }
    }
}

extension DatePickerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == maxDateTextField {
            if (maxDateTextField?.text?.count == 2) || (maxDateTextField?.text?.count == 5) {
                if !(string == "") {
                    maxDateTextField?.text = (maxDateTextField?.text ?? "") + "/"
                }
            }
            return !(textField.text?.count ?? 0 > 9 && (string.count ) > range.length)
        } else {
            return true
        }
    }
}
