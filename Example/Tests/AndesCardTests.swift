//
//  AndesCardTests.swift
//  AndesUI_Tests
//
//  Created by Martin Victory on 20/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesCardTests: QuickSpec {
    override func spec() {
        describe("AndesCard should draw it's view based on padding, hierarchy, style, type") {
            it("uses by default padding=NONE, style=ELEVATED, type=NONE, hierarchy=PRIMARY") {
                //Given
                let defaultPadding = AndesCardPadding.none
                let defaultBodyPadding = AndesCardBodyPadding.none
                let defaultStyle = AndesCardStyle.elevated
                let defaultType = AndesCardType.none
                let defaultHierarchy = AndesCardHierarchy.primary

                //When
                let card = AndesCard(cardView: UIView(), title: "Title")

                //Then
                expect(card.padding).to(equal(defaultPadding), description: "The default card padding should be NONE")
                expect(card.bodyPadding).to(equal(defaultBodyPadding), description: "The default card body padding should be NONE")
                expect(card.style).to(equal(defaultStyle), description: "The default card style should be ELEVATED")
                expect(card.type).to(equal(defaultType), description: "The default card type should be NONE")
                expect(card.hierarchy).to(equal(defaultHierarchy), description: "The default card hierarchy should be PRIMARY")
                expect(card.contentView.isKind(of: AndesCardDefaultView.self)).to(beTrue())
            }

            it("allows the user to customize it's properties") {
                //Given
                let padding = AndesCardPadding.small
                let paddingConstant = CGFloat(AndesCardPaddingSmall().paddingSize)
                let bodyPaddingConstant = CGFloat(AndesCardBodyPaddingSmall().bodyPaddingSize)
                let style = AndesCardStyle.outline
                let styleInstance = AndesCardStyleOutline()
                let type = AndesCardType.error
                let typeInstance = AndesCardTypeError()
                let hierarchy = AndesCardHierarchy.primary
                let hierarchyColor = AndesCardHierarchyPrimary(style: styleInstance, type: typeInstance)
                let title: String? = "Title text"

                //When
                let card = AndesCard(cardView: UIView(), title: title, padding: padding, hierarchy: hierarchy, style: style, type: type)

                //Then
                expect(card.contentView.isKind(of: AndesCardDefaultView.self)).to(beTrue())
                expect((card.contentView as! AndesCardDefaultView).titleLbl.text).to(equal(title))

                expect((card.contentView as! AndesCardDefaultView).topUserViewContainerConstraint.constant).to(equal(paddingConstant))
                expect((card.contentView as! AndesCardDefaultView).topUserViewContainerConstraint.constant).to(equal(bodyPaddingConstant))
                expect((card.contentView as! AndesCardDefaultView).leadingUserViewContainerConstraint.constant).to(equal(paddingConstant))
                expect((card.contentView as! AndesCardDefaultView).trailingUserViewContainerConstraint.constant).to(equal(paddingConstant))
                expect((card.contentView as! AndesCardDefaultView).bottomUserViewContainerConstraint.constant).to(equal(paddingConstant))

                expect((card.contentView as! AndesCardDefaultView).leftPipe.backgroundColor).to(equal(typeInstance.pipeColor))

                expect((card.contentView as! AndesCardDefaultView).containerView.backgroundColor).to(equal(hierarchyColor.backgroundColor))
            }
        }

        describe("AndesCard should be able to change it's ui dinamically") {
            context("AndesCard is already initailized") {
                it("supports changing padding dinamically") {
                    // Given
                    let paddingToChange = AndesCardPadding.small
                    let card = AndesCard(cardView: UIView(), padding: AndesCardPadding.none)

                    // When
                    card.padding = paddingToChange

                    // Then
                    let paddingSize = CGFloat(AndesCardPaddingSmall().paddingSize)
                    expect((card.contentView as! AndesCardDefaultView).topUserViewContainerConstraint.constant).to(equal(paddingSize))
                    expect((card.contentView as! AndesCardDefaultView).leadingUserViewContainerConstraint.constant).to(equal(paddingSize))
                    expect((card.contentView as! AndesCardDefaultView).trailingUserViewContainerConstraint.constant).to(equal(paddingSize))
                    expect((card.contentView as! AndesCardDefaultView).bottomUserViewContainerConstraint.constant).to(equal(paddingSize))
                }

                it("supports changing body padding dinamically") {
                    // Given
                    let paddingToChange = AndesCardPadding.small
                    let bodyPaddingToChange = AndesCardBodyPadding.none
                    let card = AndesCard(cardView: UIView(), padding: AndesCardPadding.none)

                    // When
                    card.title = "Title"
                    card.padding = paddingToChange
                    card.bodyPadding = bodyPaddingToChange

                    // Then
                    let paddingTitleHeight = CGFloat(AndesCardPaddingSmall().titleHeight)
                    expect((card.contentView as! AndesCardDefaultView).titleContainerHeightConstraint.constant).to(equal(paddingTitleHeight))

                    let paddingTitlePaddingSize = CGFloat(AndesCardPaddingSmall().titlePaddingSize)
                    expect((card.contentView as! AndesCardDefaultView).titleLblLeadingConstraint.constant).to(equal(paddingTitlePaddingSize))
                    expect((card.contentView as! AndesCardDefaultView).titleLblTrailingConstraint.constant).to(equal(paddingTitlePaddingSize))

                    let bodyPaddingSize = CGFloat(AndesCardBodyPaddingNone().bodyPaddingSize)
                    expect((card.contentView as! AndesCardDefaultView).topUserViewContainerConstraint.constant).to(equal(bodyPaddingSize))
                    expect((card.contentView as! AndesCardDefaultView).leadingUserViewContainerConstraint.constant).to(equal(bodyPaddingSize))
                    expect((card.contentView as! AndesCardDefaultView).trailingUserViewContainerConstraint.constant).to(equal(bodyPaddingSize))
                    expect((card.contentView as! AndesCardDefaultView).bottomUserViewContainerConstraint.constant).to(equal(bodyPaddingSize))
                }

                it("supports changing style dinamically") {
                    // Given
                    let styleToChange = AndesCardStyle.outline
                    let card = AndesCard(cardView: UIView(), style: AndesCardStyle.outline)

                    // When
                    card.style = styleToChange

                    // Then
                    let style = AndesCardStyleOutline()
                    expect((card.contentView as! AndesCardDefaultView).containerView.layer.borderColor).to(equal(style.borderColor?.cgColor))
                    expect((card.contentView as! AndesCardDefaultView).containerView.layer.borderColor).to(equal(style.borderColor?.cgColor ?? UIColor.clear.cgColor))
                }

                it("supports changing type dinamically") {
                    // Given
                    let typeToChange = AndesCardType.error
                    let card = AndesCard(cardView: UIView(), type: .none)

                    // When
                    card.type = typeToChange

                    // Then
                    let type = AndesCardTypeError()
                    expect((card.contentView as! AndesCardDefaultView).leftPipe.backgroundColor).to(equal(type.pipeColor))
                }

                it("supports changing hierarchy dinamically") {
                    // Given
                    let hierarchyToChange = AndesCardHierarchy.secondary
                    let card = AndesCard(cardView: UIView(), hierarchy: AndesCardHierarchy.primary)

                    // When
                    card.hierarchy = hierarchyToChange

                    // Then
                    let hierarchy = AndesCardHierarchySecondary()
                    expect((card.contentView as! AndesCardDefaultView).containerView.backgroundColor).to(equal(hierarchy.backgroundColor))
                }

                it("supports changing title dinamically") {
                    // Given
                    let titleToChange = "Title"
                    let card = AndesCard(cardView: UIView(), title: nil)

                    // When
                    card.title = titleToChange

                    // Then
                    expect((card.contentView as! AndesCardDefaultView).titleLbl.text).to(equal(titleToChange))
                }

                it("hides the title section when it's set to nil") {
                    // Given
                    let card = AndesCard(cardView: UIView(), title: "Title")

                    // When
                    card.title = nil

                    // Then
                    expect((card.contentView as! AndesCardDefaultView).titleLbl.isHidden).to(beTrue())
                    expect((card.contentView as! AndesCardDefaultView).titleContainerHeightConstraint.constant).to(equal(CGFloat.zero))
                }

                it("shows the title section when it's not nil") {
                    // Given
                    let card = AndesCard(cardView: UIView(), title: nil)

                    // When
                    card.title = "Title"

                    // Then
                    expect((card.contentView as! AndesCardDefaultView).titleLbl.isHidden).to(beFalse())
                }

                it("shows the link section when a link action is set") {
                    // Given
                    let card = AndesCard(cardView: UIView())

                    // When
                    card.setLinkAction("Link title") { _ in
                        // do something
                    }

                    // Then
                    expect(card.contentView.isKind(of: AndesCardWithLinkView.self)).to(beTrue())
                }
            }

            context("AndesCard is already initailized and link action set") {
                it("hides the title section when it's set to nil") {
                    // Given
                    let card = AndesCard(cardView: UIView(), title: "Title")
                    card.setLinkAction("Link title", handler: {_ in })

                    // When
                    card.title = nil

                    // Then
                    expect((card.contentView as! AndesCardWithLinkView).titleLbl.isHidden).to(beTrue())
                    expect((card.contentView as! AndesCardWithLinkView).titleContainerHeightConstraint.constant).to(equal(CGFloat.zero))
                }

                it("shows the title section when it's not nil") {
                    // Given
                    let card = AndesCard(cardView: UIView(), title: nil)
                    card.setLinkAction("Link title", handler: {_ in })

                    // When
                    card.title = "Title"

                    // Then
                    expect((card.contentView as! AndesCardWithLinkView).titleLbl.isHidden).to(beFalse())
                }

                it("hides the link when set to hierachy=secondary") {
                    // Given
                    let card = AndesCard(cardView: UIView(), title: "Title")
                    card.setLinkAction("Link title", handler: {_ in })

                    // When
                    card.hierarchy = .secondary

                    // Then
                    expect(card.contentView.isKind(of: AndesCardDefaultView.self)).to(beTrue())
                }
            }
        }

        describe("AndesCard should trigger callbacks on specifc events") {
            context("For every AndesCard already initializaed") {
                it("calls the card action handler on touch up") {
                    // Given
                    let card = AndesCard(cardView: UIView())
                    var called = false
                    card.setCardAction { _ in called = true }

                    // When
                    (card.contentView as! AndesCardAbstractView).onCardTouchUp()

                    // Then
                    expect(called).toEventually(beTrue())
                }
            }

            context("AndesCard is initialized with a link action") {
                it("calls the link action handler on touch") {
                    // Given
                    let card = AndesCard(cardView: UIView())
                    var called = false
                    card.setLinkAction("Link title") { _ in called = true }

                    // When
                    (card.contentView as! AndesCardWithLinkView).handleTap()

                    // Then
                    expect(called).toEventually(beTrue())
                }
            }
        }
    }
}
