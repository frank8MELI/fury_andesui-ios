//
//  AndesStandaloneSize.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 11/12/20.
//

import Foundation

@objc public enum AndesStandaloneSize: Int, AndesEnumStringConvertible {
    case small
    case medium
    case large

    public static func keyFor(_ value: AndesStandaloneSize) -> String {
        switch value {
        case .large: return "LARGE"
        case .medium:  return "MEDIUM"
        case .small:  return "SMALL"
        }
    }
}
