//
//  AndesRadioButtonDefaultView.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/30/20.
//

import Foundation

class AndesRadioButtonDefaultView: UIView, AndesRadioButtonView {

    @IBOutlet weak var radioButtonLabel: UILabel!
    @IBOutlet weak var leftRadioButton: AndesRadioButtonControl!
    @IBOutlet weak var rightRadioButton: AndesRadioButtonControl!

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var radioButtonView: UIView!

    weak var delegate: AndesRadioButtonViewDelegate?

    var config: AndesRadioButtonConfig

    init(withConfig config: AndesRadioButtonConfig, delegate: AndesRadioButtonViewDelegate? = nil) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    override init(frame: CGRect) {
        self.config = AndesRadioButtonConfig()
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        self.config = AndesRadioButtonConfig()
        super.init(coder: coder)
        setup()
    }

    init() {
        self.config = AndesRadioButtonConfig()
        super.init(frame: .zero)
        setup()
    }

    func radioButtonTapped(_ sender: AndesRadioButtonControl) {
        delegate?.radioButtonTapped()
    }

    func update(withConfig config: AndesRadioButtonConfig) {
        self.config = config
        updateView()
    }

    func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesRadioButtonDefaultView", owner: self, options: nil)
    }

    func setup() {
        loadNib()
        self.addSubview(radioButtonView)
        radioButtonView.pinToSuperview()
        radioButtonView.translatesAutoresizingMaskIntoConstraints = false
        leftRadioButton.tapCallback = radioButtonTapped
        self.radioButtonLabel.isAccessibilityElement = false
        updateView()
    }

    func updateView() {
        self.radioButtonLabel.text = config.title
        self.radioButtonLabel.setAndesStyle(style: AndesStyleSheetManager.styleSheet.bodyM(color: config.textColor))
        self.radioButtonLabel.numberOfLines = config.titleNumberOfLines ?? 0
        radioButtonLabel.lineBreakMode = .byTruncatingTail
        setupButtonView()
        updateRadioButtonsStyles()
        updateAccessibilityProperties()
    }

    func setupButtonView() {
        let isTitleEmpty = radioButtonLabel.text?.isEmpty ?? true
        stackView.alignment = radioButtonLabel.numberOfLines > 1 ? .top : .fill
        stackView.spacing = 10
        radioButtonLabel.isHidden = isTitleEmpty

        if config.align == .left {
            self.rightRadioButton.isHidden = true
            self.leftRadioButton.isHidden = false
            self.leftRadioButton.filled = config.filled

        } else {
            self.rightRadioButton.isHidden = false
            self.leftRadioButton.isHidden = true
            self.rightRadioButton.filled = config.filled
        }
    }

    func updateRadioButtonsStyles() {
        if let tintColor = config.tintColor {
            self.leftRadioButton.color = tintColor
            self.rightRadioButton.color = tintColor
        }
    }

    func updateAccessibilityProperties() {
        if let accessibilityTraits = self.delegate?.buttonAccesibilityTraits() {
            if config.align == .left {
                self.leftRadioButton.isAccessibilityElement = true
                self.leftRadioButton.accessibilityTraits = accessibilityTraits
                self.leftRadioButton.accessibilityLabel = config.title
            } else {
                self.rightRadioButton.isAccessibilityElement = true
                self.rightRadioButton.accessibilityTraits = accessibilityTraits
                self.rightRadioButton.accessibilityLabel = config.title
            }
        }
    }
}
