//
//  AndesUIButtonExampleViewController.swift
//  AndesUI_Example
//
//  Created by LEANDRO FURYK on 03/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class AndesUIButtonExampleViewController: UIViewController {

    @IBOutlet var andesButton: AndesButton!
    @IBOutlet var sad: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.andesButton.setTitle(title: "Comprar")
        self.andesButton.setStyle(style: .loud)
        self.andesButton.setSize(sizeStyle: .large)
    }

    @IBAction func touchUpListener(_ sender: Any) {
       let alert = UIAlertController.init(title: "TOUCHED", message: "TOUCHED", preferredStyle: .alert)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
