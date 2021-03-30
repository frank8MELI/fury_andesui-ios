//
//  AndesDropdownBottomSheetViewDelegate.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 20/11/20.
//

import Foundation

protocol AndesDropdownBottomSheetViewDelegate: class {
    func didSelectRowAt(indexPath: IndexPath)
    func dismiss()
}
