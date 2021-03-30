//
//  AndesStandaloneSizeFactory.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 11/12/20.
//

import Foundation

class AndesStandaloneSizeFactory {
    static func provideSize(withSize size: AndesStandaloneSize) -> AndesStandaloneSizeProtocol {
        switch size {
        case .large:
            return AndesStandaloneLarge()
        case .medium:
            return AndesStandaloneMedium()
        case .small:
            return AndesStandaloneSmall()
        }
    }
}
