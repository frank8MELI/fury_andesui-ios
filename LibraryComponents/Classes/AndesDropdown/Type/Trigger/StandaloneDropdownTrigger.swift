//
//  StandaloneCell.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 27/11/20.
//

import Foundation

@objc public class StandaloneDropdownTrigger: AndesDropdownTrigger {
    public private(set) var size: AndesStandaloneSize
    /// This class define the standalone trigger
    /// - Parameter size: Define the size, default is medium
    @objc public init(size: AndesStandaloneSize = .medium) {
        self.size = size
        super.init(type: .standalone)
    }
}
