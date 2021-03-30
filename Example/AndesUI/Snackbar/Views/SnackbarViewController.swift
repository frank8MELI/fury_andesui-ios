//
//  SnackbarViewController.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 6/16/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class SnackbarViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!

    var textTextField: AndesTextField?

    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    var type: AndesSnackbarType? = .neutral

    var durationTextField: UITextField?
    var durationPicker: UIPickerView?
    var duration: AndesSnackbarDuration? = .short

    var actionTitleTextField: AndesTextField?

    var showButton: AndesButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.typeSegmentedControl.tintColor = AndesStyleSheetManager.styleSheet.accentColor

        // Text TextField
        textTextField = AndesTextField(state: .idle, label: "Snackbar text", helper: nil, counter: 0, placeholder: "Message to be shown")
        textTextField?.text = "Something happened"
        self.view.addSubview(textTextField!)
        self.view.leadingAnchor.constraint(equalTo: textTextField!.leadingAnchor, constant: -32).isActive = true
        self.view.trailingAnchor.constraint(equalTo: textTextField!.trailingAnchor, constant: 32).isActive = true

        let textTopConstraint = NSLayoutConstraint(
            item: textTextField!, attribute: .top, relatedBy: .equal,
            toItem: typeSegmentedControl, attribute: .bottom, multiplier: 1.0, constant: 16
        )
        self.view.addConstraint(textTopConstraint)
        textTopConstraint.isActive = true

        let durationLabel = UILabel()
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.text = "Snackbar duration"
        durationLabel.textColor = UIColor.Andes.graySolid800
        durationLabel.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)
        self.view.addSubview(durationLabel)
        self.view.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -38).isActive = true

        let durationLabelTopConstraint = NSLayoutConstraint(
            item: durationLabel, attribute: .top, relatedBy: .equal,
            toItem: textTextField, attribute: .bottom, multiplier: 1.0, constant: 12
        )
        self.view.addConstraint(durationLabelTopConstraint)
        durationLabelTopConstraint.isActive = true

        // Duration TextField
        durationTextField = UITextField()
        durationTextField?.text = "SHORT"
        durationTextField?.textColor = UIColor.Andes.graySolid800
        durationTextField?.translatesAutoresizingMaskIntoConstraints = false
        durationTextField?.layer.borderColor = UIColor.Andes.graySolid250.cgColor
        durationTextField?.layer.borderWidth = 1
        durationTextField?.layer.cornerRadius = 6
        let heightConstraint = durationTextField?.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint?.isActive = true
        self.view.addSubview(durationTextField!)
        self.view.leadingAnchor.constraint(equalTo: durationTextField!.leadingAnchor, constant: -32).isActive = true
        self.view.trailingAnchor.constraint(equalTo: durationTextField!.trailingAnchor, constant: 32).isActive = true

        // inset
        let leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 12, height: 50)))
        durationTextField?.leftView = leftView
        durationTextField?.leftViewMode = .always

        let durationTopConstraint = NSLayoutConstraint(
            item: durationTextField!, attribute: .top, relatedBy: .equal,
            toItem: durationLabel, attribute: .bottom, multiplier: 1.0, constant: 6
        )
        self.view.addConstraint(durationTopConstraint)
        durationTopConstraint.isActive = true

        // Picker view for duration
        durationPicker = UIPickerView()
        durationPicker!.dataSource = self
        durationPicker!.delegate = self
        durationTextField?.inputView = durationPicker

        // Action title TextField
        actionTitleTextField = AndesTextField(state: .idle, label: "Snackbar action text", helper: nil, counter: 0, placeholder: "Title for the action shown into the snackbar")
        actionTitleTextField?.text = "DO SOMETHING"
        self.view.addSubview(actionTitleTextField!)
        self.view.leadingAnchor.constraint(equalTo: actionTitleTextField!.leadingAnchor, constant: -32).isActive = true
        self.view.trailingAnchor.constraint(equalTo: actionTitleTextField!.trailingAnchor, constant: 32).isActive = true

        let actionTopConstraint = NSLayoutConstraint(
            item: actionTitleTextField!, attribute: .top, relatedBy: .equal,
            toItem: durationTextField, attribute: .bottom, multiplier: 1.0, constant: 12
        )
        self.view.addConstraint(actionTopConstraint)
        actionTopConstraint.isActive = true

        // Show Snackbar Button
        showButton = AndesButton(text: "Show Snackbar", hierarchy: .loud, size: .large)
        self.view.addSubview(showButton!)
        self.view.leadingAnchor.constraint(equalTo: showButton!.leadingAnchor, constant: -32).isActive = true
        self.view.trailingAnchor.constraint(equalTo: showButton!.trailingAnchor, constant: 32).isActive = true
        self.view.bottomAnchor.constraint(equalTo: showButton!.bottomAnchor, constant: 48).isActive = true

        showButton?.addTarget(self, action: #selector(self.onShowButtonPressed), for: .touchUpInside)
    }

    @objc func onShowButtonPressed() {
        guard let text = textTextField?.text, text.count > 0 else {
            return
        }

        let snackbar = AndesSnackbar(text: text, duration: self.duration!, type: self.type!)

        if let actionText = actionTitleTextField?.text, actionText.count > 0 {
            snackbar.action = AndesSnackbarAction(text: actionText) {
                self.navigationController?.popViewController(animated: true)
            }
        }

        snackbar.show()
    }

    @IBAction func typeSegmentSelected(_ sender: UISegmentedControl) {
        self.type = AndesSnackbarType.init(rawValue: sender.selectedSegmentIndex)
    }
}

extension SnackbarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == durationPicker {
            return AndesSnackbarDuration.allCases.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == durationPicker {
            return AndesSnackbarDuration.init(pickerIndex: row)?.toString()
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.duration = AndesSnackbarDuration.init(pickerIndex: row)
        self.durationTextField?.text = self.duration?.toString()
    }
}

extension AndesSnackbarDuration {
    init?(pickerIndex: Int) {
        switch pickerIndex {
        case 0:
            self.init(rawValue: 3)
        case 1:
            self.init(rawValue: 6)
        case 2:
            self.init(rawValue: 10)
        default:
            self.init(rawValue: 3)
        }
    }
}
