//
//  Randoms.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 9/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

extension Int {
    /// SwiftRandom extension
    static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}
