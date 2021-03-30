//
//  AndesDropdownAbstractView.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

class AndesDropdownAbstractView: UIView, AndesDropdownView {

    var text: String = ""

    @IBOutlet var view: UIView!

    var config: AndesDropdownViewConfig?
    weak var delegate: AndesDropdownViewDelegate?

    init(withConfig config: AndesDropdownViewConfig) {
        super.init(frame: .zero)
        self.config = config
        setup()
        updateView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesDropdownViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(view)
        view.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }

    internal func updateView() {
        fatalError("This should be overriden by a subclass")
    }
}
