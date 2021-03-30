//
//  String+Additions.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 2/6/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, comment: "")
    }
}
