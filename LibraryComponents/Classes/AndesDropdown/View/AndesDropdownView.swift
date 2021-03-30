//
//  AndesDropdownView.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

internal protocol AndesDropdownView: UIView {
    var delegate: AndesDropdownViewDelegate? { get set }
    var text: String { get set }
    func update(withConfig config: AndesDropdownViewConfig)
}
