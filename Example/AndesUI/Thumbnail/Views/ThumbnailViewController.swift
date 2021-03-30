//
//  ThumbnailViewController.swift
//  AndesUI-demoapp
//
//  Created by Alejo Echeguia on 01/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

import AndesUI

class ThumbnailViewController: UIViewController {

	@IBOutlet weak var stackView: UIStackView!

	@IBOutlet weak var iconDefault: AndesThumbnail!
	@IBOutlet weak var iconDefaultDisabled: AndesThumbnail!
	@IBOutlet weak var iconLoud: AndesThumbnail!
	@IBOutlet weak var iconLoudDisabled: AndesThumbnail!
	@IBOutlet weak var iconQuiet: AndesThumbnail!
	@IBOutlet weak var iconQuietDisabled: AndesThumbnail!
	@IBOutlet weak var imageCircle: AndesThumbnail!
	@IBOutlet weak var imageCircleDisabled: AndesThumbnail!
	@IBOutlet weak var imageSquare: AndesThumbnail!
	@IBOutlet weak var imageSquareDisabled: AndesThumbnail!

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

	@IBAction func sizeSelected(_ sender: Any) {
		guard let segment = sender as? UISegmentedControl else {return}

		let sizeArray: [AndesThumbnailSize] = AndesThumbnailSize.allCases

		iconDefault.size = sizeArray[segment.selectedSegmentIndex]
		iconDefaultDisabled.size = sizeArray[segment.selectedSegmentIndex]
		iconLoud.size = sizeArray[segment.selectedSegmentIndex]
		iconLoudDisabled.size = sizeArray[segment.selectedSegmentIndex]
		iconQuiet.size = sizeArray[segment.selectedSegmentIndex]
		iconQuietDisabled.size = sizeArray[segment.selectedSegmentIndex]
		imageCircle.size = sizeArray[segment.selectedSegmentIndex]
		imageCircleDisabled.size = sizeArray[segment.selectedSegmentIndex]
		imageSquare.size = sizeArray[segment.selectedSegmentIndex]
		imageSquareDisabled.size = sizeArray[segment.selectedSegmentIndex]
	}
}
