//
//  TagViewController.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 5/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

protocol TagView: NSObject {

}

class TagViewController: UIViewController, TagView {

    @IBOutlet weak var tagView: AndesTagSimple!

    @IBOutlet weak var updateButton: AndesButton!

    @IBOutlet weak var textTextField: UITextField!

    @IBOutlet weak var dismissibleSwitch: UISwitch!
    var isDismissible: Bool = false

    @IBOutlet weak var typeField: UITextField!
    var typePicker: UIPickerView = UIPickerView()
    var type: AndesTagType = .neutral

    @IBOutlet weak var sizeField: UITextField!
    var sizePicker: UIPickerView = UIPickerView()
    var size: AndesTagSize = .small

    @IBOutlet weak var leftContentField: UITextField!
    var leftContentPicker: UIPickerView = UIPickerView()
    var leftContentType: AndesTagLeftContentEnum = .none

    @IBOutlet weak var leftContentDotFieldsHeight: NSLayoutConstraint!
    @IBOutlet weak var dotBackgroundColorTextField: UITextField!
    @IBOutlet weak var dotTextTextField: UITextField!
    @IBOutlet weak var dotTextColorTextField: UITextField!

    @IBOutlet weak var leftContentIconFieldsHeight: NSLayoutConstraint!
    @IBOutlet weak var iconBackgroundColorTextField: UITextField!
    @IBOutlet weak var iconColorTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTag()
        setupUpdateButton()
        setupControls()
        hideLeftContents()
        switchLeftContentFieldEnabled()
    }

    func setupTag() {
        tagView.text = self.textTextField.text
        tagView.isDismissible = isDismissible
        tagView.type = type
        tagView.size = size
        tagView.leftContent = getLeftContent(leftContentEnum: self.leftContentType)
        tagView.setDidDismiss(callback: didTapDismiss(tag:))
    }

    func setupUpdateButton() {
        updateButton.text = "badge.button.updateConfig".localized
    }

    func setupControls() {
        createPickerViews()
        self.dismissibleSwitch.isOn = isDismissible
    }

    func createPickerViews() {
        typeField.inputView = typePicker
        typeField.text = self.type.toString()
        typePicker.delegate = self
        typePicker.dataSource = self

        sizeField.inputView = sizePicker
        sizeField.text = self.size.toString()
        sizePicker.delegate = self
        sizePicker.dataSource = self

        leftContentField.inputView = leftContentPicker
        leftContentField.text = AndesTagLeftContentEnum.init(rawValue: 0)?.toString()
        leftContentPicker.delegate = self
        leftContentPicker.dataSource = self
    }

    func showLeftContent(leftContent: AndesTagLeftContentEnum) {
        hideLeftContents()
        switch leftContent {
        case .dot:
            self.showLeftContentDot()
        case .icon:
            self.showLeftContentIcon()
        default:
            break
        }
    }

    func showLeftContentDot() {
        self.leftContentDotFieldsHeight.constant = 150
    }

    func showLeftContentIcon() {
        self.leftContentIconFieldsHeight.constant = 106
    }

    func hideLeftContents() {
        self.leftContentDotFieldsHeight.constant = 0
        self.leftContentIconFieldsHeight.constant = 0
    }

    func switchLeftContentFieldEnabled() {
        if case .large = self.size {
            leftContentField.isEnabled = true
            leftContentField.alpha = 1.0
        } else {
            leftContentField.isEnabled = false
            leftContentField.alpha = 0.5
            hideLeftContents()
            self.leftContentPicker.selectedRow(inComponent: 0)
            self.leftContentType = .none
            self.leftContentField.text = self.leftContentType.toString()
        }
    }

    @IBAction func dismssibleSwitchChanged(_ sender: UISwitch) {
        self.isDismissible = sender.isOn
    }

    @IBAction func updateButtonTouched(_ sender: AndesButton) {
        setupTag()
    }

    func didTapDismiss(tag: AndesTagSimple) {
        let alert = UIAlertController(title: "AndesUI Tag", message: "Tag was dismissed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func getLeftContent(leftContentEnum: AndesTagLeftContentEnum) -> AndesTagLeftContent? {
        switch leftContentEnum {
        case .none:
            return nil
        case .dot:
            let bgColor = UIColor(hex: "#" + (dotBackgroundColorTextField.text ?? "000000"))
            return AndesTagLeftContentDot(backgroundColor: bgColor!, text: dotTextTextField.text ?? "", textColor: UIColor(hex: "#" + (dotTextColorTextField.text ?? "FFFFFF"))!)
        case .icon:
            let bgColor = UIColor(hex: "#" + (iconBackgroundColorTextField.text ?? "000000"))
            return AndesTagLeftContentIcon(backgroundColor: bgColor!, andesIconName: "andes_ui_feedback_success_24", iconColor: UIColor(hex: "#" + (iconColorTextField.text ?? "FFFFFF"))!)
        case .image:
            return AndesTagLeftContentImage(avatar: UIImage(named: "item-example")!)
        }
    }
}

extension TagViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case typePicker:
            typeField.resignFirstResponder()
            self.type = AndesTagType.init(rawValue: row)!
            typeField.text = type.toString()
        case sizePicker:
            sizeField.resignFirstResponder()
            self.size = AndesTagSize.init(rawValue: row)!
            sizeField.text = size.toString()
            switchLeftContentFieldEnabled()
        case leftContentPicker:
            leftContentField.resignFirstResponder()
            let contentType = AndesTagLeftContentEnum.init(rawValue: row)!
            self.leftContentType = contentType
            leftContentField.text = contentType.toString()
            self.showLeftContent(leftContent: contentType)
        default:
            return
        }
    }
}

extension TagViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case typePicker:
            return AndesTagType.allCases.count
        case sizePicker:
            return AndesTagSize.allCases.count
        case leftContentPicker:
            return AndesTagLeftContentEnum.allCases.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case typePicker:
            return AndesTagType.init(rawValue: row)!.toString()
        case sizePicker:
            return AndesTagSize.init(rawValue: row)!.toString()
        case leftContentPicker:
            return AndesTagLeftContentEnum.init(rawValue: row)!.toString()
        default:
            return ""
        }
    }
}

enum AndesTagLeftContentEnum: Int, CaseIterable {
    case none
    case dot
    case icon
    case image

    func toString() -> String {
        switch self {
        case .none:
            return "NONE"
        case .dot:
            return "DOT"
        case .icon:
            return "ICON"
        case .image:
            return "IMAGE"
        }
    }
}
