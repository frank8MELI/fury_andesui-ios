//
//  AndesTagChoiceView.swift
//  AndesUI
//
//  Created by Facundo Conil on 10/6/20.
//

import Foundation

class AndesTagChoiceView: AndesTagSimpleView {

    override func updateView() {
        super.updateView()
        self.rightButton.isUserInteractionEnabled = false
        self.isAccessibilityElement = true
        self.accessibilityLabel = config.accessibilityLabel
    }

}
