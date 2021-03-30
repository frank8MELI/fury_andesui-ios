//
//  AndesDropDownDelegate.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 18/11/20.
//

import Foundation

@objc public protocol AndesDropdownDelegate {
    func didSelectRowAt(indexPath: IndexPath)
}
