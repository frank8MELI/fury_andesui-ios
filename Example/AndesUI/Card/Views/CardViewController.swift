//
//  CardViewController.swift
//  AndesUI-demoapp
//
//  Created by Martin Victory on 14/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class CardViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var andesCard: AndesCard!
    @IBOutlet weak var configButton: AndesButton!
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var paddingField: UITextField!
    @IBOutlet weak var bodyPaddingField: UITextField!
    @IBOutlet weak var hierarchyField: UITextField!
    @IBOutlet weak var styleField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var cardActionSwitch: UISwitch!
    @IBOutlet weak var linkActionField: UITextField!
    @IBOutlet weak var updateButton: AndesButton!

    // MARK: - Properties
    private var paddingPicker: UIPickerView = UIPickerView()
    private var bodyPaddingPicker: UIPickerView = UIPickerView()
    private var hierarchyPicker: UIPickerView = UIPickerView()
    private var stylePicker: UIPickerView = UIPickerView()
    private var typePicker: UIPickerView = UIPickerView()
    private var padding: AndesCardPadding = .small
    private var bodyPadding: AndesCardBodyPadding = .small
    private var hierarchy: AndesCardHierarchy = .primary
    private var style: AndesCardStyle = .elevated
    private var type: AndesCardType = .none

    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        setupConfigView()
        createPickerViews()
        setupBaseCard()
    }

    private func setupButtons() {
        configButton.text = "card.button.changeConfigButton".localized
        configButton.hierarchy = .quiet
        configButton.size = .medium

        updateButton.text = "card.button.updateButton".localized
        updateButton.hierarchy = .loud
        updateButton.size = .large
    }

    private func setupConfigView() {
        configView.isHidden = true
    }

    private func createPickerViews() {
        paddingField.inputView = paddingPicker
        paddingPicker.delegate = self
        paddingPicker.dataSource = self

        bodyPaddingField.inputView = bodyPaddingPicker
        bodyPaddingPicker.delegate = self
        bodyPaddingPicker.dataSource = self

        hierarchyField.inputView = hierarchyPicker
        hierarchyPicker.delegate = self
        hierarchyPicker.dataSource = self

        styleField.inputView = stylePicker
        stylePicker.delegate = self
        stylePicker.dataSource = self

        typeField.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
    }

    private func setupBaseCard() {
        andesCard.cardView = cardView()
        andesCard.title = "card.default.title".localized
        andesCard.padding = .small

        andesCard.setLinkAction("card.default.link".localized) { [unowned self] _ in
            self.onLinkActionPressed()
        }
    }

    private func onLinkActionPressed() {
        let alert = UIAlertController(title: "card.actions.linkMsg".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func onCardActionPressed() {
        let alert = UIAlertController(title: "card.actions.cardMsg".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func cardView() -> UIView {
        let view = UIView()

        let imageView = UIImageView(image: UIImage(named: "item-example"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true

        let textLbl = UILabel()
        textLbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        textLbl.numberOfLines = 0
        textLbl.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16), lineSpacing: 1))

        let stackView = UIStackView(arrangedSubviews: [imageView, textLbl])
        stackView.axis = .horizontal
        stackView.spacing = 30

        view.addSubview(stackView)
        stackView.pinTo(view: view)

        return view
    }

    // MARK: - Actions
    @IBAction func onConfigButtonTap(_ sender: AndesButton) {
        if !self.configView.isHidden {
            self.configButton.text = "card.button.changeConfigButton".localized
            self.configButton.hierarchy = .quiet

        } else {
            self.configButton.text = "card.button.hideConfigButton".localized
            self.configButton.hierarchy = .transparent

            self.titleField.text = andesCard.title
            self.linkActionField.text = andesCard.actionLinkTitle
        }

        UIView.transition(with: configView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.configView.isHidden = !self.configView.isHidden
        })
    }

    @IBAction func onUpdateButtonTap(_ sender: AndesButton) {
        andesCard.padding = self.padding
        andesCard.bodyPadding = self.bodyPadding
        andesCard.hierarchy = self.hierarchy
        andesCard.style = self.style
        andesCard.type = self.type

        if let title = titleField.text, !title.isEmpty {
            andesCard.title = title
        } else {
            andesCard.title = nil
        }

        if cardActionSwitch.isOn {
            andesCard.setCardAction { [unowned self] _ in  self.onCardActionPressed() }
        } else {
            andesCard.removeCardAction()
        }

        if let linkTitle = linkActionField.text, !linkTitle.isEmpty {
            andesCard.setLinkAction(linkTitle) { [unowned self] _ in self.onLinkActionPressed() }
        } else {
            andesCard.removeLinkAction()
        }

        onConfigButtonTap(sender)
    }
}

extension CardViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == paddingPicker {
            self.padding = AndesCardPadding(rawValue: row)!
            self.paddingField.text = AndesCardPadding.keyFor(self.padding).capitalized
        }
        if pickerView == bodyPaddingPicker {
            self.bodyPadding = AndesCardBodyPadding(rawValue: row)!
            self.bodyPaddingField.text = AndesCardBodyPadding.keyFor(self.bodyPadding).capitalized
        }
        if pickerView == hierarchyPicker {
            self.hierarchy = AndesCardHierarchy(rawValue: row)!
            self.hierarchyField.text = AndesCardHierarchy.keyFor(self.hierarchy).capitalized
        }
        if pickerView == stylePicker {
            self.style = AndesCardStyle(rawValue: row)!
            self.styleField.text = AndesCardStyle.keyFor(self.style).capitalized
        }
        if pickerView == typePicker {
            self.type = AndesCardType(rawValue: row)!
            self.typeField.text = AndesCardType.keyFor(self.type).capitalized
        }
    }
}

extension CardViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == paddingPicker {
            return AndesCardPadding.allCases.count
        }
        if pickerView == bodyPaddingPicker {
            return AndesCardBodyPadding.allCases.count
        }
        if pickerView == hierarchyPicker {
            return AndesCardHierarchy.allCases.count
        }
        if pickerView == stylePicker {
            return AndesCardStyle.allCases.count
        }
        if pickerView == typePicker {
            return AndesCardType.allCases.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == paddingPicker {
            return AndesCardPadding.keyFor(AndesCardPadding(rawValue: row)!).capitalized
        }
        if pickerView == bodyPaddingPicker {
            return AndesCardBodyPadding.keyFor(AndesCardBodyPadding(rawValue: row)!).capitalized
        }
        if pickerView == hierarchyPicker {
            return AndesCardHierarchy.keyFor(AndesCardHierarchy(rawValue: row)!).capitalized
        }
        if pickerView == stylePicker {
            return AndesCardStyle.keyFor(AndesCardStyle(rawValue: row)!).capitalized
        }
        if pickerView == typePicker {
            return AndesCardType.keyFor(AndesCardType(rawValue: row)!).capitalized
        }
        return ""
    }
}
