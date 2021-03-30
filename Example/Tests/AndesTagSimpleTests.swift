//
//  AndesTagSimpleTests.swift
//  AndesUI_Tests
//
//  Created by Samuel Sainz on 6/12/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesTagSimpleTests: QuickSpec {

    override func spec() {
        describe("Andes Tag Simple should draw its view depends on their properties") {
            context("When creating AndesTagSimple") {
                it("Has the right view type") {
                    let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)

                    expect(tag.contentView.isKind(of: AndesTagSimpleView.self)).to(beTrue())
                }
            }

            context("If it has a small size") {
                it("Must not have a left content") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagSimple(text: "Andes Tag", size: .small, type: .neutral, isDismissible: false)
                    tag.leftContent = leftContent
                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                    expect(configuration.leftContent).to(beNil())
                }

                it("should have a height of 24 px") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagSimple(text: "Andes Tag", size: .small, type: .neutral, isDismissible: false)
                    tag.leftContent = leftContent
                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                    expect(configuration.height).to(equal(24.0))
                }

                context("If it's dismissible") {
                    it("should have a right button of 24 px width") {

                        let tag = AndesTagSimple(text: "Andes Tag", size: .small, type: .neutral, isDismissible: true)
                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(24.0))
                    }
                }

                context("if it's not dismissible") {
                    it("should hide the right button") {
                        let tag = AndesTagSimple(text: "Andes Tag", size: .small, type: .neutral, isDismissible: false)
                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(0))
                    }
                }
            }

            context("If it has a large size") {
                it("Coudl have a left content") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)
                    tag.leftContent = leftContent
                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                    expect(configuration.leftContent).toNot(beNil())
                }

                context("If have a left content") {
                    it("set the right left content class: Dot") {
                        let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)
                        let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)
                        tag.leftContent = leftContent

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.leftContent).to(beAKindOf(AndesTagLeftContentDot.self))
                    }

                    it("set the right left content class: Icon") {
                        let leftContent = AndesTagLeftContentIcon(backgroundColor: UIColor.white, icon: UIImage(named: "andes")!, iconColor: UIColor.black)
                        let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)
                        tag.leftContent = leftContent

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.leftContent).to(beAKindOf(AndesTagLeftContentIcon.self))
                    }

                    it("set the right left content class: Image") {
                        let leftContent = AndesTagLeftContentImage(avatar: UIImage(named: "avatar-example")!)
                        let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)
                        tag.leftContent = leftContent

                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.leftContent).to(beAKindOf(AndesTagLeftContentImage.self))
                    }
                }

                it("should have a height of 32 px") {
                    let leftContent = AndesTagLeftContentDot(backgroundColor: UIColor.green)

                    let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)
                    tag.leftContent = leftContent
                    let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                    expect(configuration.height).to(equal(32.0))
                }

                context("If it's dismissible") {
                    it("should have a right button of 32 px width") {

                        let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: true)
                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(32.0))
                    }
                }

                context("if it's not dismissible") {
                    it("should hide the right button") {
                        let tag = AndesTagSimple(text: "Andes Tag", size: .large, type: .neutral, isDismissible: false)
                        let configuration = AndesTagViewConfigFactory.provideInternalConfig(fromSimpleTag: tag)

                        expect(configuration.rightButtonWidth).to(equal(0))
                    }
                }
            }
        }
    }
}
