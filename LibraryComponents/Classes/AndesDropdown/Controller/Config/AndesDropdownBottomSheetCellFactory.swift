//
//  AndesDropdownBottomSheetConfig.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 20/11/20.
//

import Foundation

class AndesDropdownBottomSheetCellFactory {

    static func provide(menuCellType: [AndesDropDownMenuCell], size: AndesListSize, numberOfLines: Int) -> [AndesSimpleCell] {
        return menuCellType.map {
            AndesSimpleCell(withTitle: $0.title,
                            subtitle: nil,
                            thumbnail: $0.thumbnail,
                            numberOfLines: numberOfLines)
        }
    }
}
