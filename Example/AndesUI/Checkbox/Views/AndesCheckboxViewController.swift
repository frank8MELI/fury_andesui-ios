//
//  AndesCheckboxShowcaseViewController.swift
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 6/12/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

protocol CheckboxView: NSObject {

}

class AndesCheckboxViewController: UIViewController, CheckboxView {
    @IBOutlet var checkbox: UIView!
    @IBOutlet weak var idleCheckboxView: AndesCheckbox!

    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        self.checkbox.addSubview(stackView)

        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .equalCentering

        self.idleCheckboxView.setCheckboxDidTapped(callback: didTapIdle(checkbox:))

        // Idle - Unselected - left
        let idleCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.idle, align: AndesCheckboxAlign.left, status: AndesCheckboxStatus.unselected, title: "Idle - Unselected - left")

        idleCheckboxView.setCheckboxDidTapped(callback: didTapIdle(checkbox:))

        // Idle - Unselected - right
        let idleRightCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.idle, align: AndesCheckboxAlign.right, status: AndesCheckboxStatus.unselected, title: "Idle - Unselected - right")

        idleRightCheckboxView.setCheckboxDidTapped(callback: didTapIdle(checkbox:))

        // Idle - Undefined
        let idleUndefinedCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.idle, align: AndesCheckboxAlign.left, status: AndesCheckboxStatus.undefined, title: "Idle - Undefined")

        idleUndefinedCheckboxView.setCheckboxDidTapped(callback: didTapIdle(checkbox:))

        // Disabled - Selected
        let disabledCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.disabled, align: AndesCheckboxAlign.left, status: AndesCheckboxStatus.selected, title: "Disabled - Selected")

        // Disabled - Unselected
        let disabledUnselectedCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.disabled, align: AndesCheckboxAlign.left, status: AndesCheckboxStatus.unselected, title: "Disabled - Unselected")

        // Disabled - Unselected
        let disabledUndefinedCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.disabled, align: AndesCheckboxAlign.left, status: AndesCheckboxStatus.undefined, title: "Disabled - Undefined")

        // Error - Unselected
        let errorUndefinedCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.error, align: AndesCheckboxAlign.left, status: AndesCheckboxStatus.unselected, title: "Error - Unselected")

        errorUndefinedCheckboxView.setCheckboxDidTapped(callback: didTapIdle(checkbox:))

        // Error - Unselected - right
        let errorUndefinedRightCheckboxView: AndesCheckbox! = AndesCheckbox(type: AndesCheckboxType.error, align: AndesCheckboxAlign.right, status: AndesCheckboxStatus.unselected, title: "Error - Unselected - right")

        errorUndefinedRightCheckboxView.setCheckboxDidTapped(callback: didTapIdle(checkbox:))

        stackView.addArrangedSubview(idleCheckboxView)
        stackView.addArrangedSubview(idleRightCheckboxView)
        stackView.addArrangedSubview(idleUndefinedCheckboxView)

        stackView.addArrangedSubview(disabledUnselectedCheckboxView)
        stackView.addArrangedSubview(disabledCheckboxView)
        stackView.addArrangedSubview(disabledUndefinedCheckboxView)

        stackView.addArrangedSubview(errorUndefinedCheckboxView)
        stackView.addArrangedSubview(errorUndefinedRightCheckboxView)
    }

    func didTapIdle(checkbox: AndesCheckbox) {
        var alert: UIAlertController = UIAlertController()
        switch checkbox.type {
        case .idle:
            if checkbox.status == AndesCheckboxStatus.undefined {
                alert = UIAlertController(title: "AndesUI Checkbox", message: "Checkbox idle undefined pressed", preferredStyle: .alert)
            } else {
                alert = UIAlertController(title: "AndesUI Checkbox", message: "Checkbox idle pressed", preferredStyle: .alert)
            }
        case .disabled:
            return
        case .error:
            alert = UIAlertController(title: "AndesUI Checkbox", message: "Checkbox error pressed", preferredStyle: .alert)
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
