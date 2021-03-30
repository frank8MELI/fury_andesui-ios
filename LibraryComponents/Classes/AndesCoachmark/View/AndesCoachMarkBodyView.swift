//
//  AndesCoachMarkBodyView.swift
//  CardsComponents
//
//  Created by JONATHAN DANIEL BANDONI on 17/07/2020.
//

protocol AndesCoachMarkBodyViewProtocol: class {
    func setupTextAbove(of positionY: CGFloat)
    func setupTextBelow(of positionY: CGFloat)
    func setupArrowAboveOfTextAndPointToLeft(positionY: CGFloat, width: CGFloat)
    func setupArrowAboveOfTextAndPointToRight(positionY: CGFloat, width: CGFloat)
    func setupArrowBelowOfTextAndPointToLeft(positionY: CGFloat, width: CGFloat)
    func setupArrowBelowOfTextAndPointToRight(positionY: CGFloat, width: CGFloat)

    func setupTitleLabel(title: String)
    func setupDescriptionLabel(description: String)
    func setupNextButton(nextText: String, buttonStyle: AndesCoachMarkBodyEntity.ButtonStyle)

    func convertCoordinates(view: UIView) -> CGRect

    var width: CGFloat { get }
}

protocol AndesCoachMarkBodyViewDelegate: class {
    func didNext()
}

class AndesCoachMarkBodyView: UIView {

    private lazy var labelsContainer = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private var arrowView: AndesCoachMarkArrowView?

    private lazy var finalButton = AndesButton(text: "", hierarchy: .loud, size: .large)

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = 6
        button.titleLabel?.textColor = AndesStyleSheetManager.styleSheet.textColorWhite
        button.titleLabel?.font =  AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyM)
        button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        return button
    }()
    weak var delegate: AndesCoachMarkBodyViewDelegate?

    var presenter: AndesCoachMarkBodyPresenter

    let animationDY = CGFloat(16)

    // MARK: - Initialization
    required init(presenter: AndesCoachMarkBodyPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)

        presenter.view = self
        setupViews()
        setupAccessibility()
    }

    private func setupViews() {
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        setupLabelsContainer()
    }

    private func setupLabelsContainer() {
        addSubview(labelsContainer)
        labelsContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelsContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }

    private func setupAccessibility() {
          accessibilityElements = [labelsContainer]
      }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        presenter.viewLaidOut()
    }

    func show() {
        UIView.animate(withDuration: AndesCoachMarkConstants.Animation.duration, delay: AndesCoachMarkConstants.Animation.delay, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 1
            self.labelsContainer.transform = CGAffineTransform(translationX: 0, y: self.animationDY)
            self.arrowView?.transform = CGAffineTransform(translationX: 0, y: self.animationDY)
        })
    }

    func hide() {
        UIView.animate(withDuration: AndesCoachMarkConstants.Animation.duration, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
        })
    }
}

extension AndesCoachMarkBodyView: AndesCoachMarkBodyViewProtocol {

    var width: CGFloat {
        return frame.width
    }

    func convertCoordinates(view: UIView) -> CGRect {
        return view.convert(view.bounds, to: self)
    }

    func setupTextAbove(of positionY: CGFloat) {
        labelsContainer.bottomAnchor.constraint(equalTo: topAnchor, constant: positionY - animationDY).isActive = true
    }

    func setupTextBelow(of positionY: CGFloat) {
        labelsContainer.topAnchor.constraint(equalTo: topAnchor, constant: positionY - animationDY).isActive = true
    }

    func setupArrowAboveOfTextAndPointToLeft(positionY: CGFloat, width: CGFloat) {
        arrowView = AndesCoachMarkArrowView(width: width, direction: .toUpLeft)
        guard let arrowView = arrowView else { return }

        addSubview(arrowView)
        arrowView.topAnchor.constraint(equalTo: topAnchor, constant: positionY - animationDY).isActive = true
        arrowView.trailingAnchor.constraint(equalTo: labelsContainer.centerXAnchor).isActive = true

        labelsContainer.topAnchor.constraint(equalTo: arrowView.bottomAnchor).isActive = true
    }

    func setupArrowAboveOfTextAndPointToRight(positionY: CGFloat, width: CGFloat) {
        arrowView = AndesCoachMarkArrowView(width: width, direction: .toUpRight)
        guard let arrowView = arrowView else { return }

        addSubview(arrowView)
        arrowView.topAnchor.constraint(equalTo: topAnchor, constant: positionY - animationDY).isActive = true
        arrowView.leadingAnchor.constraint(equalTo: labelsContainer.centerXAnchor).isActive = true

        labelsContainer.topAnchor.constraint(equalTo: arrowView.bottomAnchor).isActive = true
    }

    func setupArrowBelowOfTextAndPointToLeft(positionY: CGFloat, width: CGFloat) {
        arrowView = AndesCoachMarkArrowView(width: width, direction: .toDownLeft)
        guard let arrowView = arrowView else { return }

        addSubview(arrowView)
        arrowView.bottomAnchor.constraint(equalTo: topAnchor, constant: positionY - animationDY).isActive = true
        arrowView.trailingAnchor.constraint(equalTo: labelsContainer.centerXAnchor).isActive = true

        labelsContainer.bottomAnchor.constraint(equalTo: arrowView.topAnchor).isActive = true
    }

    func setupArrowBelowOfTextAndPointToRight(positionY: CGFloat, width: CGFloat) {
        arrowView = AndesCoachMarkArrowView(width: width, direction: .toDownRight)
        guard let arrowView = arrowView else { return }

        addSubview(arrowView)
        arrowView.bottomAnchor.constraint(equalTo: topAnchor, constant: positionY - animationDY).isActive = true
        arrowView.leadingAnchor.constraint(equalTo: labelsContainer.centerXAnchor).isActive = true

        labelsContainer.bottomAnchor.constraint(equalTo: arrowView.topAnchor).isActive = true
    }

    func setupTitleLabel(title: String) {
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorWhite, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.titleS), sketchLineHeight: 25))
        titleLabel.textAlignment = .center

        labelsContainer.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: labelsContainer.leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: labelsContainer.centerXAnchor)
        ])
        titleLabel.sizeToFit()
    }

    func setupDescriptionLabel(description: String) {
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorWhite, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyM), sketchLineHeight: 25))
        descriptionLabel.textAlignment = .center

        labelsContainer.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: labelsContainer.leadingAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: labelsContainer.centerXAnchor)
        ])
        descriptionLabel.sizeToFit()
    }

    func setupNextButton(nextText: String, buttonStyle: AndesCoachMarkBodyEntity.ButtonStyle) {
        var button: UIView = nextButton
        if buttonStyle == .normal {
            setNormalButton(nextText)
            nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true

        } else {
            setFinalButton(nextText)
            button = finalButton
        }
        accessibilityElements?.append(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 48),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: labelsContainer.leadingAnchor),
            button.centerXAnchor.constraint(equalTo: labelsContainer.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: labelsContainer.bottomAnchor, constant: -8)
        ])
        nextButton.sizeToFit()
    }

    private func setFinalButton(_ nextText: String) {
        finalButton.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
        finalButton.text = nextText
    }

    private func setNormalButton(_ nextText: String) {
        nextButton.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
        nextButton.setTitle(nextText, for: .normal)
    }

    @objc func nextButtonTouchUpInside(_ sender: UIControl, with event: UIEvent?) {
        delegate?.didNext()
    }
}
