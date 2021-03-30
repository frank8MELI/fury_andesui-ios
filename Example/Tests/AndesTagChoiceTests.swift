//
//  AndesTagChoiceTests.swift
//  AndesUI_Tests
//
//  Created by Facundo Conil on 10/6/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesTagChoiceTests: QuickSpec {

    override func spec() {
        describe("Andes Tag Choice should draw its view depends on their properties") {
            context("When creating AndesTagChoice") {
                it("Has the right view type") {
                    let tag = AndesTagChoice(text: "Andes Tag", size: .large, type: .simple, state: .idle)
                    expect(tag.contentView.isKind(of: AndesTagChoiceView.self)).to(beTrue())
                }
            }

            context("If it has a small size") {
                it("Must not have a left content") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagChoice(text: "Some Tag", size: .small, type: .simple, state: .idle)
                    tag.leftContent = leftContent

                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                    expect(configuration.leftContent).to(beNil())
                }

                it("should have a height of 24 px") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagChoice(text: "Some Tag", size: .small, type: .simple, state: .idle)
                    tag.leftContent = leftContent

                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                    expect(configuration.height).to(equal(24.0))
                }

                context("If it's selected") {
                    it("should have a right button of 24 px width") {
                        let tag = AndesTagChoice(text: "Some Tag", size: .small, type: .simple, state: .selected)
                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)
                        expect(configuration.rightButtonWidth).to(equal(24.0))
                    }
                }

                context("if it's idle") {
                    it("should hide the right button") {
                        let tag = AndesTagChoice(text: "Some Tag", size: .small, type: .simple, state: .idle)
                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)
                        expect(configuration.rightButtonWidth).to(equal(0))
                    }
                }
            }

            context("If it has a large size") {
                it("Could have a left content") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .idle)
                    tag.leftContent = leftContent

                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                    expect(configuration.leftContent).toNot(beNil())
                }

                context("If have a left content") {
                    it("set the right left content class: Dot") {
                        let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .idle)
                        tag.leftContent = leftContent

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.leftContent).to(beAKindOf(AndesTagLeftContentDot.self))
                    }

                    it("set the right left content class: Icon") {
                        let leftContent = AndesTagLeftContentIcon(backgroundColor: UIColor.white, icon: UIImage(named: "andes")!, iconColor: UIColor.black)

                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .idle)
                        tag.leftContent = leftContent

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.leftContent).to(beAKindOf(AndesTagLeftContentIcon.self))
                    }

                    it("set the right left content class: Image") {
                        let leftContent = AndesTagLeftContentImage(avatar: UIImage(named: "avatar-example")!)

                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .idle)
                        tag.leftContent = leftContent

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.leftContent).to(beAKindOf(AndesTagLeftContentImage.self))
                    }
                }

                it("should have a height of 32 px") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .idle)
                    tag.leftContent = leftContent

                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                    expect(configuration.height).to(equal(32.0))
                }

                context("If it's simple type and selected") {
                    it("should have a right button of 32 px width") {

                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .selected)

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(32.0))
                    }
                }

                context("If it's simple type and idle") {
                    it("should hide the right button") {

                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .simple, state: .idle)

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(0))
                    }
                }

                context("if it's dropdown type and selected") {
                    it("should have a right button of 32 px width") {
                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .dropdown, state: .selected)

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(32.0))
                    }
                }

                context("if it's dropdown type and idle") {
                    it("should have a right button of 32 px width") {
                        let tag = AndesTagChoice(text: "Some Tag", size: .large, type: .dropdown, state: .idle)

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(32.0))
                    }
                }
            }
        }
    }
}
