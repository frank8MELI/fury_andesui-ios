//
//  DropdownBottomSheetType.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 27/11/20.
//

import Foundation

@objc public class DropdownBottomSheetMenu: AndesDropdownMenu {
    @objc public var separatorStyle: AndesSeparatorStyle
    /// This class initialize the bottom sheet
    /// - Parameters:
    ///   - separatorStyle: Define the separator style
    ///   - numberOfLines: Define the number fo lines  to the title
    ///   - rows: Define the rows
    ///   - selectionStyle: Define the selection style
    @objc public init(separatorStyle: AndesSeparatorStyle = .none,
                      numberOfLines: Int = 0,
                      rows: [AndesDropDownMenuCell],
                      selectionStyle: AndesSelectionStyle = .defaultStyle) {
        self.separatorStyle = separatorStyle
        super.init(numberOfLines: numberOfLines,
                   rows: rows,
                   selectionStyle: selectionStyle,
                   cellType: .none,
                   type: .bottomSheet)
    }

}
