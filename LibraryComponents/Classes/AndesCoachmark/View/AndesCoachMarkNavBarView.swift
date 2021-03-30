//
//  AndesCoachMarkNavBarView.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 16/07/2020.
//

import Foundation

protocol AndesCoachMarkNavBarViewDelegate: class {
    func didClose()
}

class AndesCoachMarkNavBarView: UIView {

    var title = "" {
        didSet {
             titleLabel.text = title
        }
    }

    var showExitButton = true {
        didSet {
            closeButton.isHidden = !showExitButton
            setupAccessibility()
        }
    }

    private lazy var closeButton = UIButton(type: .system)
    private lazy var titleLabel = UILabel()

    weak var delegate: AndesCoachMarkNavBarViewDelegate?

    // MARK: - Initialization
    required init() {
        super.init(frame: .zero)

        setupViews()
        setupAccessibility()
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 64).isActive = true

        setupCloseButton()
        setupTitle()
    }

    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTouchUpInside(_:with:)), for: .touchUpInside)
        AndesIconsProvider.loadIcon(name: AndesIcons.close20) { (closeImage) in
            closeButton.setImage(closeImage, for: .normal)
            closeButton.tintColor = AndesStyleSheetManager.styleSheet.textColorWhite
        }
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])

    }

    private func setupTitle() {
        titleLabel.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorWhite, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS), sketchLineHeight: 18))

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }

    private func setupAccessibility() {
        closeButton.isAccessibilityElement = showExitButton
        closeButton.accessibilityTraits = .button
        closeButton.accessibilityLabel = "Cerrar".localized()
        accessibilityElements = [titleLabel, showExitButton ? closeButton : nil].compactMap { $0 }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    @objc func closeButtonTouchUpInside(_ sender: UIControl, with event: UIEvent?) {
        delegate?.didClose()
    }
}
