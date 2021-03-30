//
//  AndesDropdown.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

@objc public class AndesDropdown: UIView {

    private var contentView: AndesDropdownView!
    private var didSelect: Bool = false {
        didSet {
            self.updateView()
            didSelect.toggle()
        }
    }

    /// Set the trigger type, default is formDropdown
    @objc public var triggerType: AndesDropdownTrigger {
        didSet {
            self.updateContentView()
            self.setContentView()
        }
    }

    /// Set the menu type, default is bottomsheet
    @objc public var menuType: AndesDropdownMenu {
        didSet {
            self.setContentView()
        }
    }

    /// Set the delegate
    @objc public weak var delegate: AndesDropdownDelegate?

    private let rootViewController = UIApplication.shared.keyWindow?.rootViewController

    @objc public init() {
        self.triggerType = AndesDropdownTrigger()
        self.menuType = AndesDropdownMenu(rows: [])
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.triggerType = AndesDropdownTrigger()
        self.menuType = AndesDropdownMenu(rows: [])
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func getConfig() -> AndesDropdownViewConfig {
        return AndesDropdownViewConfigFactory.provide(from: self, isSelected: didSelect)
    }

    private func provideView() -> AndesDropdownView {
        switch self.triggerType.type {
        case .formDropdown:
            return AndesDropdownFormViewDefault(withConfig: getConfig())
        case .standalone:
            return AndesDropdownStandaloneView(withConfig: getConfig())
        }
    }

    private func drawContentView(with newView: AndesDropdownView) {
        self.contentView = newView
        self.contentView.delegate = self
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateView() {
        contentView.update(withConfig: getConfig())
    }

    private func updateContentView() {
        self.contentView.removeFromSuperview()
        drawContentView(with: provideView())
        contentView.update(withConfig: getConfig())
    }

    private func setContentView() {
        guard menuType.rows.count != 0 else {
            return
        }
        switch self.triggerType.type {
        case .standalone:
            contentView.text = menuType.rows[0].title
        case .formDropdown:
            contentView.text = ""
        }
    }
}

extension AndesDropdown: AndesDropdownViewDelegate {
    func didSelectTrigger() {
        didSelect.toggle()
        openMenuType()
    }

    func openMenuType() {
        switch self.menuType.type {
        case .bottomSheet:
            self.openSheet()
        case .floatingMenu:
            break
        }
    }
}

extension AndesDropdown {
    private func openSheet() {
        guard let viewController = configViewController() else { return }
        let sheet = AndesBottomSheetViewController(rootViewController: viewController)
        rootViewController?.present(sheet, animated: true)
    }

    func configViewController() -> UIViewController? {

        guard let menuType = self.menuType as? DropdownBottomSheetMenu else {
            return nil
        }

        let viewController = AndesDropdownBottomSheetViewController(nibName: "AndesDropdownBottomSheetViewController",
                                                                    bundle: AndesDropdownBundle.bundle())
        viewController.delegate = self
        viewController.configController(menuCellType: menuType.rows,
                                        numberOfLines: self.menuType.numberOfLines,
                                        separatorStyle: menuType.separatorStyle,
                                        selectionStyle: menuType.selectionStyle)
        return viewController
    }
}

extension AndesDropdown: AndesDropdownBottomSheetViewDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        rootViewController?.dismiss(animated: true)
        self.contentView.text = menuType.rows[indexPath.row].title
        delegate?.didSelectRowAt(indexPath: indexPath)
    }

    func dismiss() {
        self.updateView()
    }
}
