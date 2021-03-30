//
//  AndesCoachmarkHighlightInteractorTests.swift
//  AndesUI_Tests
//
//  Created by JONATHAN DANIEL BANDONI on 10/08/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesCoachmarkHighlightInteractorTests: QuickSpec {
    override func spec() {
        let overlayView = UIView(frame: UIScreen.main.bounds)
        let bodyViewBounds = CGRect(x: 24, y: 64, width: 200, height: 400)

        describe("Coachmark Highlight Interactor Tests") {
            context("Rectangle highlighted") {
                let viewToHighlight = UIView(frame: CGRect(x: 40, y: 100, width: 30, height: 50))
                let interactor = AndesCoachMarkHighlightInteractor(overlayView: overlayView, view: viewToHighlight, bodyViewBounds: bodyViewBounds, style: .rectangle)

                it("should return the corner radius") {
                    expect(interactor.getHighlightCornerRadius()).to(equal(8))
                }

                it("should create a highlightRect with some margins") {
                    expect(interactor.getHighlightRect()).to(equal(CGRect(x: 28, y: 88, width: 54, height: 74)))
                }

                it("should return that view to highlight is not below of half bodyView") {
                    expect(interactor.isHighlightedViewBelow()).to(beFalse())
                }

                it("should get the mask path correctly") {
                    let path = UIBezierPath(rect: overlayView.bounds)
                    let viewPath = UIBezierPath(roundedRect: viewToHighlight.frame.insetBy(dx: -12, dy: -12), cornerRadius: 8)
                    path.append(viewPath)

                    expect(interactor.getMaskPath()).to(equal(path.cgPath))
                }
            }

            context("Rectangle highlighted with insets") {
                let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                let viewToHighlight = UIView(frame: CGRect(x: 40, y: 100, width: 30, height: 50))
                let interactor = AndesCoachMarkHighlightInteractor(overlayView: overlayView, view: viewToHighlight, bodyViewBounds: bodyViewBounds, style: .rectangle, insets: insets)

                it("should return the corner radius") {
                    expect(interactor.getHighlightCornerRadius()).to(equal(8))
                }

                it("should create a highlightRect with some margins") {
                    expect(interactor.getHighlightRect()).to(equal(CGRect(x: 23, y: 83, width: 64, height: 84)))
                }

                it("should return that view to highlight is not below of half bodyView") {
                    expect(interactor.isHighlightedViewBelow()).to(beFalse())
                }

                it("should get the mask path correctly") {
                    let path = UIBezierPath(rect: overlayView.bounds)
                    let frame: CGRect = UIEdgeInsetsInsetRect(viewToHighlight.frame.insetBy(dx: -12, dy: -12), UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
                    let viewPath = UIBezierPath(roundedRect: frame, cornerRadius: 8)
                    path.append(viewPath)

                    expect(interactor.getMaskPath().boundingBox).to(equal(path.cgPath.boundingBox))
                }
            }

            context("Circle highlighted") {
                let viewToHighlight = UIView(frame: CGRect(x: 40, y: 300, width: 40, height: 40))
                let interactor = AndesCoachMarkHighlightInteractor(overlayView: overlayView, view: viewToHighlight, bodyViewBounds: bodyViewBounds, style: .circle)

                it("should return the corner radius") {
                    expect(interactor.getHighlightCornerRadius()).to(equal(32))
                }

                it("should create a highlightRect with some margins") {
                    expect(interactor.getHighlightRect()).to(equal(CGRect(x: 28, y: 288, width: 64, height: 64)))
                }

                it("should return that view to highlight is below of half bodyView") {
                    expect(interactor.isHighlightedViewBelow()).to(beTrue())
                }

                it("should get the mask path correctly") {
                    let path = UIBezierPath(rect: overlayView.bounds)
                    let viewPath = UIBezierPath(roundedRect: viewToHighlight.frame.insetBy(dx: -12, dy: -12), cornerRadius: 32)
                    path.append(viewPath)

                    expect(interactor.getMaskPath()).to(equal(path.cgPath))
                }
            }

            context("Circle highlighted with insets") {
                let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                let viewToHighlight = UIView(frame: CGRect(x: 40, y: 300, width: 40, height: 40))
                let interactor = AndesCoachMarkHighlightInteractor(overlayView: overlayView, view: viewToHighlight, bodyViewBounds: bodyViewBounds, style: .circle, insets: insets)

                it("should return the corner radius") {
                    expect(interactor.getHighlightCornerRadius()).to(equal(37))
                }

                it("should create a highlightRect with some margins") {
                    expect(interactor.getHighlightRect()).to(equal(CGRect(x: 23, y: 283, width: 74, height: 74)))
                }

                it("should return that view to highlight is below of half bodyView") {
                    expect(interactor.isHighlightedViewBelow()).to(beTrue())
                }

                it("should get the mask path correctly") {
                    let path = UIBezierPath(rect: overlayView.bounds)
                    let frame: CGRect = UIEdgeInsetsInsetRect(viewToHighlight.frame.insetBy(dx: -12, dy: -12), UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
                    let viewPath = UIBezierPath(roundedRect: frame, cornerRadius: 32)
                    path.append(viewPath)

                    expect(interactor.getMaskPath()).to(equal(path.cgPath))
                }
            }
        }
    }
}
