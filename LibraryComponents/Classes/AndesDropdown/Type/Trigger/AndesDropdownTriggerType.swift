//
//  AndesDropdownTriggerType.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

@objc public enum AndesDropdownTriggerType: Int, AndesEnumStringConvertible {
    case formDropdown
    case standalone

    public static func keyFor(_ value: AndesDropdownTriggerType) -> String {
        switch value {
        case .formDropdown: return "FORMDROPDOWN"
        case .standalone: return "STANDALONE"
        }
    }
}
