//
//  AndeSnackbarManagerTests.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 6/26/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesSnackbarManagerTests: QuickSpec {

    class MockAndesSnackbarManager: AndesSnackbarManager {

        override func showAnimated(snackbar: AndesSnackbar) {
            if let snackbar = snackbar as? MockSnackbar {
                snackbar.showAnimatedCalled = true
            }
        }

        override func dismissSnackbarAnimated(snackbar: AndesSnackbar) {
            if snackbar.timer != nil {
                snackbar.timer?.invalidate()
            }

            if let snackbar = snackbar as? MockSnackbar {
                snackbar.dismissAnimatedCalled = true
            }
        }
    }

    class MockSnackbar: AndesSnackbar {
        public var showAnimatedCalled = false
        public var dismissAnimatedCalled = false
    }

    override func spec() {

        describe("Snackbar multiple shows") {
            context("When there is no snackbars being shown") {
                it("It's shown inmediatly") {
                    // Given a Snackbar and a SnackbarManager
                    let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let manager = MockAndesSnackbarManager()

                    // When showing a snackbar
                    manager.show(snackbar: snackbar)

                    // It's shown inmidiatly
                    expect(snackbar.showAnimatedCalled).to(beTrue())
                }
            }

            context("When there is one or more snackbars to be shown") {
                it("Is added to the queue") {
                    // Given two Snackbars and a SnackbarManager
                    let firstSnackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let secondSnackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let manager = MockAndesSnackbarManager()

                    // When showing another snackbar
                    manager.show(snackbar: firstSnackbar)
                    manager.show(snackbar: secondSnackbar)

                    // The first is shown but the second is not
                    expect(firstSnackbar.showAnimatedCalled).to(beTrue())
                    expect(secondSnackbar.showAnimatedCalled).to(beFalse())
                }
            }
        }

        describe("The snackbar appearance") {
            context("When it doesn't have a context anymore") {
                it("Is not shown") {
                    // Given a Snackbar without context and a SnackbarManager
                    let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    snackbar.context = nil
                    let manager = MockAndesSnackbarManager()
                    manager.snackbarsQueue = [snackbar]

                    // When showing a snackbar
                    manager.showNextSnackbar()

                    // It's shown inmidiatly
                    expect(snackbar.showAnimatedCalled).to(beFalse())
                }
            }

            context("When is going to be shown") {
                it("is added to the context") {
                    // Given a Snackbar and a SnackbarManager
                    let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let manager = MockAndesSnackbarManager()

                    // When showing a snackbar
                    manager.show(snackbar: snackbar)

                    // It's added to the context
                    expect(snackbar.superview).to(equal(snackbar.context?.view))
                }

                it("has the constraints set with the right values") {
                    // Given a Snackbar and a SnackbarManager
                    let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let manager = MockAndesSnackbarManager()

                    // When showing a snackbar
                    manager.show(snackbar: snackbar)

                    // Has the right constraints
                    expect(snackbar.leftMarginConstraint).toNot(beNil())
                    expect(snackbar.leftMarginConstraint?.constant).to(equal(snackbar.snackbarMargin))

                    expect(snackbar.rightMarginConstraint).toNot(beNil())
                    expect(snackbar.rightMarginConstraint?.constant).to(equal(-snackbar.snackbarMargin))

                    expect(snackbar.bottomMarginConstraint).toNot(beNil())
                }

                it("has a timer set") {
                    // Given a Snackbar and a SnackbarManager
                    let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let manager = MockAndesSnackbarManager()

                    // When showing a snackbar
                    manager.show(snackbar: snackbar)

                    // The timer is set
                    expect(snackbar.timer).toNot(beNil())
                }
            }
        }

        describe("The snackbar dismiss") {
            context("When showing a snackbar") {
                context("If the duration is normal") {
                    it("is dismissed after 7 seconds") {
                        // Given a Snackbar with normal duration and a SnackbarManager
                        let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                        let manager = MockAndesSnackbarManager()

                        // When showing a snackbar
                        manager.show(snackbar: snackbar)

                        expect(snackbar.dismissAnimatedCalled).toEventually(beTrue(), timeout: 7)
                    }
                }

                context("If the duration is short") {
                    it("is dismissed after 4 seconds") {
                        // Given a Snackbar with short duration and a SnackbarManager
                        let snackbar = MockSnackbar(text: "Snackbar message", duration: .short, type: .success)
                        let manager = MockAndesSnackbarManager()

                        // When showing a snackbar
                        manager.show(snackbar: snackbar)

                        expect(snackbar.dismissAnimatedCalled).toEventually(beTrue(), timeout: 4)
                    }
                }

                context("If the action button is tapped") {
                    it("is dismissed") {

                        // Given a Snackbar with some action and a SnackbarManager
                        let snackbar = MockSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                        var dismissActionCalled = false
                        snackbar.action = AndesSnackbarAction(text: "Dismiss") {
                            dismissActionCalled = true
                        }

                        let manager = MockAndesSnackbarManager()
                        snackbar.snackbarManager = { return manager }

                        // When showing a snackbar
                        manager.show(snackbar: snackbar)

                        // And tapping the button
                        snackbar.actionButtonTapped()

                        expect(dismissActionCalled).to(beTrue())
                        expect(snackbar.dismissAnimatedCalled).to(beTrue())
                    }
                }
            }
        }
    }
}
