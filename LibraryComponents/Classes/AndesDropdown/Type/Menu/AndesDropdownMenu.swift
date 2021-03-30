//
//  AndesDropdownMenuType.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

@objc public class AndesDropdownMenu: NSObject {
    private(set) var numberOfLines: Int
    private(set) var rows: [AndesDropDownMenuCell]
    private(set) var selectionStyle: AndesSelectionStyle
    private(set) var cellType: AndesDropdownCellType
    private(set) var type: AndesDropdownMenuType

    @objc public init(numberOfLines: Int = 0,
                      rows: [AndesDropDownMenuCell],
                      selectionStyle: AndesSelectionStyle = .defaultStyle,
                      cellType: AndesDropdownCellType = .none,
                      type: AndesDropdownMenuType = .bottomSheet) {
        self.numberOfLines = numberOfLines
        self.rows = rows
        self.selectionStyle = selectionStyle
        self.cellType = cellType
        self.type = type
    }
}
