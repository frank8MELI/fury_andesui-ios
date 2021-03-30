//
//  LabelViewDefault.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 11/12/20.
//

import Foundation

class AndesDropdownStandaloneView: AndesDropdownAbstractView {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override var text: String {
        get {
            return titleLbl.text ?? ""
        }
        set {
            titleLbl.text = newValue
        }
    }

    override func loadNib() {
        let bundle = AndesDropdownBundle.bundle()
        bundle.loadNibNamed("AndesDropdownStandaloneView", owner: self, options: nil)
    }

    override func setup() {
        super.setup()
        self.setupGestureRecognizer()
    }

    func setupGestureRecognizer() {
        titleLbl.isUserInteractionEnabled = true
        iconImg.isUserInteractionEnabled = true
        titleLbl.addGestureRecognizer(self.setRecognizer())
        iconImg.addGestureRecognizer(self.setRecognizer())
    }

    func setRecognizer() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        tap.numberOfTapsRequired = 1
        return tap
    }

    override func updateView() {

        guard let config = self.config, let font = config.font, let height = config.heightChevron else { return }

        AndesIconsProvider.loadIcon(name: config.icon ?? "", placeItInto: iconImg)
        iconImg.tintColor = config.iconColor
        titleLbl.setAndesStyle(style: font)
        widthConstraint.constant = height
    }

    @objc func didSelect(sender: UITapGestureRecognizer) {
        delegate?.didSelectTrigger()
    }
}
