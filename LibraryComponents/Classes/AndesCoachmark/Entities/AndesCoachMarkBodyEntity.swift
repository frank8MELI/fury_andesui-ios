//
//  AndesCoachMarkBodyEntity.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 22/07/2020.
//

import Foundation

struct AndesCoachMarkBodyEntity {
    let title: String
    let description: String
    let viewToPoint: UIView
    let position: Position?
    let nextText: String
    let buttonStyle: ButtonStyle
}

extension AndesCoachMarkBodyEntity {
    enum Position {
        case above
        case below
    }

    enum ButtonStyle {
           case normal
           case final
    }
}
