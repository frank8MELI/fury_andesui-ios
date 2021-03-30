//
//  AndesBadgeExtensionViewControllerMock.swift
//  AndesUI-demoapp
//
//  Created by Julián Lima on 04/02/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

final class AndesBadgeExtensionViewControllerMock: UIViewController {
    // MARK: Views
    private let addButton: AndesButton = .init(text: "+", hierarchy: .loud, size: .large)
    private let subtractButton: AndesButton  = .init(text: "-", hierarchy: .loud, size: .large)
    private let removeButton: AndesButton  = .init(text: "Remove Badge", hierarchy: .loud, size: .large)

    // MARK: BadgeProperties
    private var badgeCount: Int
    private let titleValue: String

    init(title: String, badgeCount: Int) {
        self.badgeCount = badgeCount
        self.titleValue = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupView()
        setupConstraints()
    }

    private func setupView() {
        title = titleValue
        tabBarItem.image = UIImage(named: "home_tabbar_item")
        view.backgroundColor = AndesStyleSheetManager.styleSheet.bgColorWhite
        view.addSubview(addButton)
        view.addSubview(subtractButton)
        view.addSubview(removeButton)
        addButton.addTarget(self, action: #selector(self.addBadgeCount), for: [.touchUpInside, .touchUpOutside])
        subtractButton.addTarget(self, action: #selector(self.subtractBadgeCount), for: [.touchUpInside, .touchUpOutside])
        removeButton.addTarget(self, action: #selector(self.removeBadge), for: [.touchUpInside, .touchUpOutside])
    }

    private func setupConstraints() {
        addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -27).isActive = true
        subtractButton.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 10).isActive = true
        subtractButton.topAnchor.constraint(equalTo: addButton.topAnchor).isActive = true
        removeButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10).isActive = true
        removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc private func addBadgeCount() {
        badgeCount = badgeCount < 0 ? 1 : badgeCount + 1
        tabBarItem.setAndesBadge(with: badgeCount)
    }

    @objc private func subtractBadgeCount() {
        badgeCount -= 1
        tabBarItem.setAndesBadge(with: badgeCount)
    }

    @objc private func removeBadge() {
        badgeCount = 0
        tabBarItem.removeAndesBadge()
    }
}
