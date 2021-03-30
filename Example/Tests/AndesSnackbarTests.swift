//
//  AndesSnackbarTests.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 6/26/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesSnackbarTests: QuickSpec {

    override func spec() {

        describe("When setting the type") {
            context("If the type is success") {
                it("Configures the view correctly") {

                    // Given a Snackbar with success type
                    let snackbar = AndesSnackbar(text: "Snackbar message", duration: .normal, type: .success)

                    // When creating the config
                    let config = AndesSnackbarViewConfigFactory.provideInternalConfig(from: snackbar)

                    // The snackbar should be configured with a green background color
                    expect(config.backgroundColor).to(equal(UIColor.Andes.green500))
                }
            }

            context("If the type is error") {
                it("Configures the view correctly") {

                    // Given a Snackbar with error type
                    let snackbar = AndesSnackbar(text: "Snackbar message", duration: .normal, type: .error)

                    // When creating the config
                    let config = AndesSnackbarViewConfigFactory.provideInternalConfig(from: snackbar)

                    // The snackbar should be configured with a red background color
                    expect(config.backgroundColor).to(equal(UIColor.Andes.red500))
                }
            }

            context("If the type is neutral") {
                it("Configures the view correctly") {

                    // Given a Snackbar with neutral type
                    let snackbar = AndesSnackbar(text: "Snackbar message", duration: .normal, type: .neutral)

                    // When creating the config
                    let config = AndesSnackbarViewConfigFactory.provideInternalConfig(from: snackbar)

                    // The snackbar should be configured with a gray solid background color
                    expect(config.backgroundColor).to(equal(UIColor.Andes.graySolid800))
                }
            }
        }

        describe("When setting the text") {
            it("Configures the view correctly") {
                // Given a Snackbar with some text
                let snackbar = AndesSnackbar(text: "Snackbar message", duration: .normal, type: .success)

                // When creating the config
                let config = AndesSnackbarViewConfigFactory.provideInternalConfig(from: snackbar)

                // The snackbar should be configured with a gray solid background color
                expect(config.text).to(equal("Snackbar message"))
            }
        }

        describe("When setting the action") {
            context("If an action is set") {
                it("Configures the view with the right text") {
                    // Given a Snackbar with an action set
                    let snackbar = AndesSnackbar(text: "Snackbar message", duration: .normal, type: .success)
                    let action = AndesSnackbarAction(text: "Action text")
                    snackbar.action = action

                    // When creating the config
                    let config = AndesSnackbarViewConfigFactory.provideInternalConfig(from: snackbar)

                    // The snackbar should be configured with a gray solid background color
                    expect(config.actionConfig).toNot(beNil())
                    expect(config.actionConfig?.text).to(equal(action.text))
                }
            }

            context("If an action isn't set") {
                it("Configures the view with no action at all") {
                    // Given a Snackbar with an action set
                    let snackbar = AndesSnackbar(text: "Snackbar message", duration: .normal, type: .success)

                    // When creating the config
                    let config = AndesSnackbarViewConfigFactory.provideInternalConfig(from: snackbar)

                    // The snackbar should be configured with a gray solid background color
                    expect(config.actionConfig).to(beNil())
                }
            }
        }
    }
}
