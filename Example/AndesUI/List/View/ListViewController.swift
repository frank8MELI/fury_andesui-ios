//
//  ListViewViewController.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 16/10/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class ListViewController: UIViewController {

    @IBOutlet weak var andesList: AndesList!
    @IBOutlet weak var radioButtonSimple: AndesRadioButton!
    @IBOutlet weak var radioButtonChevron: AndesRadioButton!
    @IBOutlet weak var radioButtonIcon: AndesRadioButton!
    @IBOutlet weak var radioButtonThumbnail: AndesRadioButton!
    @IBOutlet weak var titleTxt: AndesTextField!
    @IBOutlet weak var numberOfLinesTitle: AndesTextField!
    @IBOutlet weak var descriptionTxt: AndesTextField!
    @IBOutlet weak var selection: UISegmentedControl!

    let icon = AndesThumbnail(hierarchy: .defaultHierarchy, type: .icon, size: .size24, state: .enabled, image: UIImage(named: "clip") ?? UIImage(), accentColor: UIColor.clear)
    let thumbnail = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size24, state: .enabled, image: UIImage(named: "clip") ?? UIImage(), accentColor: UIColor.clear)
    var cell: AndesListCell!
    var image: AndesThumbnail?
    var numberOfLines: Int?

    var simpleCellSelected: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        radioButtonSimple.setRadioButtonTapped(callback: didTapIdle(radiobutton:))
        radioButtonChevron.setRadioButtonTapped(callback: didTapIdle(radiobutton:))
        radioButtonIcon.setRadioButtonTapped(callback: didTapIdle(radiobutton:))
        radioButtonThumbnail.setRadioButtonTapped(callback: didTapIdle(radiobutton:))

        andesList.delegate = self
        andesList.dataSource = self
        andesList.separatorStyle = .singleLine
        andesList.selectionStyle = .defaultStyle
        andesList.listType = .simple
        andesList.size = .medium

        self.setValuesDefault()
    }

    @IBAction func update() {
        buildCell()
        andesList.reloadData()
    }

    @IBAction func setValuesDefault() {
        self.titleTxt.text = "list.label.titleCell".localized
        self.descriptionTxt.text = "list.label.subTitleCell".localized
        andesList.size = .medium
        self.image = nil
        self.numberOfLines = 0
        andesList.listType = .simple
        andesList.size = .medium
        simpleCellSelected = true
        selection.selectedSegmentIndex = 1
        self.numberOfLinesTitle.text = "0"
        self.radioButtonIcon.status = .unselected
        self.radioButtonThumbnail.status = .unselected
        self.radioButtonSimple.status = .selected
        self.radioButtonChevron.status = .unselected
        self.update()
    }

    func didTapIdle(radiobutton: AndesRadioButton) {
        if radiobutton == self.radioButtonSimple {
            self.radioButtonSimple.status = .selected
            self.radioButtonChevron.status = .unselected
            simpleCellSelected = true
            andesList.listType = .simple
        } else if radiobutton == self.radioButtonChevron {
            self.radioButtonSimple.status = .unselected
            self.radioButtonChevron.status = .selected
            simpleCellSelected = false
            andesList.listType = .chevron
        } else if radiobutton == self.radioButtonIcon {
            self.radioButtonIcon.status = .selected
            self.radioButtonThumbnail.status = .unselected
            self.image = icon
        } else if radiobutton == self.radioButtonThumbnail {
            self.radioButtonIcon.status = .unselected
            self.radioButtonThumbnail.status = .selected
            self.image = thumbnail
        }
    }

    func buildCell() {
        if simpleCellSelected {
            cell = AndesSimpleCell(withTitle: getTitleRow(),
                                   subtitle: self.descriptionTxt.text,
                                   thumbnail: self.image,
                                   numberOfLines: self.getNumberOfLines())
        } else {
            cell = AndesChevronCell(withTitle: getTitleRow(),
                                    subtitle: self.descriptionTxt.text,
                                    thumbnail: self.image,
                                    numberOfLines: self.getNumberOfLines())
        }
    }

    func getTitleRow() -> String {
        if self.titleTxt.text.isEmpty {
            return "list.label.titleCell".localized
        }
        return self.titleTxt.text
    }

    func getNumberOfLines() -> Int {
        if let lines = Int(self.numberOfLinesTitle.text) {
            return lines
        }
        return 0
    }

    @IBAction func valueChangeSegmented() {
        if selection.selectedSegmentIndex == 0 {
            andesList.size = .small
        } else if selection.selectedSegmentIndex == 1 {
            andesList.size = .medium
        } else {
            andesList.size = .large
        }
    }

    func onCellActionPressed(msg: String) {
        let alert = UIAlertController(title: "list.actions.titleAlert".localized,
                                      message: "\("list.actions.msgAlert".localized) row: \(msg)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListViewController: AndesListDelegate {
    func andesList(_ listView: AndesList, didSelectRowAt indexPath: IndexPath) {
        self.onCellActionPressed(msg: "\(indexPath.row)")
    }
}

extension ListViewController: AndesListDataSource {
    func andesList(_ listView: AndesList, cellForRowAt indexPath: IndexPath) -> AndesListCell {
        return self.cell
    }
    func numberOfSections(_ listView: AndesList) -> Int {
        return 1
    }

    func andesList(_ listView: AndesList, numberOfRowsInSection section: Int) -> Int {
        return Int.random(lower: 500, 1200)
    }
}
