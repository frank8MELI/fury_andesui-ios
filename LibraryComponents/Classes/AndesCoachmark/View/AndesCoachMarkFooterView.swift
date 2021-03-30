//
//  AndesCoachMarkFooterView.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 16/07/2020.
//

import Foundation

class AndesCoachMarkFooterView: UIView {

    // MARK: - Initialization
    required init() {
        super.init(frame: .zero)

        setupViews()
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 96).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}
