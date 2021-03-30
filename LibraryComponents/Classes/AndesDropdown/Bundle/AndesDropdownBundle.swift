//
//  AndesDropdownBundle.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 3/12/20.
//

import Foundation

public class AndesDropdownBundle {
    public static func bundle() -> Bundle {
        if let path = Bundle(for: self).path(forResource: "AndesDropdownResources", ofType: "bundle"),
            let bundle = Bundle(path: path) {
            return bundle
        }
        return Bundle.main
    }
}
