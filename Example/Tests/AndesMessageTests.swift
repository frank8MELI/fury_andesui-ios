//
//  AndesMessageTests.swift
//  AndesUI_Example
//
//  Created by Nicolas Rostan Talasimov on 1/17/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesMessageTests: QuickSpec {
    override func spec() {
        describe("AndesMessage should draw its view depending on type, type, and variation") {
            context("AndesMessage dismissable with title and description inits") {
                it("Andes message by default should be neutral, loud and of defaultView") {
                    // Given
                    let defaultHierarchy = AndesMessageHierarchy.loud
                    let defaultType = AndesMessageType.neutral

                    // When
                    let message = AndesMessage(frame: .zero)

                    // Then
                    expect({return message.hierarchy == defaultHierarchy ? .succeeded : .failed(reason: "wrong default hierarchy")}).to(succeed())
                    expect({return message.type == defaultType ? .succeeded : .failed(reason: "wrong default type")}).to(succeed())
                    expect(message.contentView.isKind(of: AndesMessageDefaultView.self)).to(beTrue())
                    }

                it("Andes message with custom hierarchy, type, title, and description") {
                    // Given
                    let title = "Msg Title"
                    let body = "Msg Description"
                    let hierarchy: AndesMessageHierarchy = .quiet
                    let type: AndesMessageType = .success

                    // When
                    let message = AndesMessage(hierarchy: hierarchy, type: type, title: title, body: body)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageDefaultView.self)).to(beTrue())
                    expect((message.contentView as! AndesMessageDefaultView).titleLabel.text).to(match(title))
                    expect((message.contentView as! AndesMessageDefaultView).bodyTextView.text).to(match(body))
                    expect((message.contentView as! AndesMessageDefaultView).leftPipeView.backgroundColor) == AndesMessageTypeSuccess().primaryColor
                    expect((message.contentView as! AndesMessageDefaultView).backgroundColor) == AndesMessageHierarchyQuiet(type: AndesMessageTypeSuccess()).backgroundColor
                    }
                }
            }
        describe("AndesMessage should be able to change its ui dinamically") {
            context("AndesMessage default view changes attributes") {
                it("changes andes message hierarchy dinamycally") {
                    // Given
                    let hierarchyToChange: AndesMessageHierarchy = .quiet
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.hierarchy = hierarchyToChange

                    // Then
                    expect((message.contentView as! AndesMessageDefaultView).backgroundColor) == AndesMessageHierarchyQuiet(type: AndesMessageTypeHightlight()).backgroundColor
                    expect((message.contentView as! AndesMessageDefaultView).leftPipeView.backgroundColor) == AndesMessageTypeHightlight().primaryColor
                }
                it("changes andes message type dinamycally") {
                      // Given
                      let typeToChange: AndesMessageType = .error
                      let message = AndesMessage(frame: .zero)

                      // When
                      message.type = typeToChange

                      // Then
                      expect((message.contentView as! AndesMessageDefaultView).backgroundColor) == AndesMessageHierarchyLoud(type: AndesMessageTypeError()).backgroundColor
                      expect((message.contentView as! AndesMessageDefaultView).leftPipeView.backgroundColor) == AndesMessageTypeError().primaryColor
                  }
                it("changes andes message title dinamycally") {
                      // Given
                      let titleToChange: String = "new title"
                      let message = AndesMessage(frame: .zero)

                      // When
                      message.title = titleToChange

                      // Then
                      expect((message.contentView as! AndesMessageDefaultView).titleLabel.text).to(match(titleToChange))
                  }
                it("changes andes message description dinamycally") {
                      // Given
                      let descToChange: String = "new message"
                      let message = AndesMessage(frame: .zero)

                      // When
                      message.body = descToChange

                      // Then
                      expect((message.contentView as! AndesMessageDefaultView).bodyTextView.text).to(match(descToChange))
                  }
                it("changes andes message view dinamycally to actionsView") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.setPrimaryAction("Primary", handler: nil)
                    message.setSecondaryAction("Secondary", handler: nil)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageWithActionsView.self)).to(beTrue())
                }
                it("changes andes message view dinamycally to actionsView") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.setLinkAction("Link", handler: nil)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageWithActionsView.self)).to(beTrue())
                }
                it("changes andes message view dinamycally back to defaultView") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.setPrimaryAction("Primary", handler: nil)
                    message.setPrimaryAction("", handler: nil)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageDefaultView.self)).to(beTrue())
                }
                it("changes andes message view dinamycally back to defaultView") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.setLinkAction("Primary", handler: nil)
                    message.setLinkAction("", handler: nil)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageDefaultView.self)).to(beTrue())
                }
                it("when title is empty or nil, title is hidden") {
                    // Given
                    let message = AndesMessage(frame: .zero)
                    let messageEmpty = AndesMessage(frame: .zero)

                    // When
                    message.title = nil
                    messageEmpty.title = ""

                    // Then
                    expect((message.contentView as! AndesMessageDefaultView).titleLabel.isHidden).to(beTrue())
                    expect((messageEmpty.contentView as! AndesMessageDefaultView).titleLabel.isHidden).to(beTrue())
                }
                it("when title is not empty, title label is not hidden") {
                   // Given
                   let message = AndesMessage(frame: .zero)

                   // When
                   message.title = "title"

                   // Then
                   expect((message.contentView as! AndesMessageDefaultView).titleLabel.isHidden).to(beFalse())
               }
                it("When 2 bullets added, the bullet stack has two items") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    let bullet1 = AndesBullet(text: "Test 1")
                    let bullet2 = AndesBullet(text: "Test 2")

                    // When
                    message.bullets = [bullet1, bullet2]

                    // Then
                    expect((message.contentView as! AndesMessageDefaultView).bulletStackView.arrangedSubviews.count).to(equal(2))
                }

                it("When 2 bullets are removed, the bullet stack has to be empty") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    let bullet1 = AndesBullet(text: "Test 1")
                    let bullet2 = AndesBullet(text: "Test 2")
                    message.bullets = [bullet1, bullet2]

                    // When
                    message.bullets = []

                    // Then
                    expect((message.contentView as! AndesMessageDefaultView).bulletStackView.arrangedSubviews.isEmpty).to(beTrue())
                }

                it("dont show actions if only secondary setted") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.setSecondaryAction("Secondary", handler: nil)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageDefaultView.self)).to(beTrue())
                }
                it("dont show actions if primary and link actions are setted") {
                    // Given
                    let message = AndesMessage(frame: .zero)

                    // When
                    message.setPrimaryAction("Primary", handler: nil)
                    message.setLinkAction("Link", handler: nil)

                    // Then
                    expect(message.contentView.isKind(of: AndesMessageDefaultView.self)).to(beTrue())
                }
            }
        }
        describe("AndesMessage should trigger callbacks on specific events") {
            context("AndesMessage default callbacks") {
                it("calls dismiss") {
                    // Given
                    let message = AndesMessage(frame: .zero)
                    var called = false
                    message.onDismiss { _ in called = true}

                    // When
                    (message.contentView as! AndesMessageDefaultView).dismissPressed(self)

                    // Then
                    expect(called).toEventually(beTrue())
                }
            }
            context("AndesMessage primary action") {
                it("calls primary button handler") {
                    // Given
                    let message = AndesMessage(frame: .zero)
                    var called = false
                    message.setPrimaryAction("Primary") { _ in called = true}

                    // When
                    (message.contentView as! AndesMessageWithActionsView).primaryButtonTapped(self)

                    // Then
                    expect(called).toEventually(beTrue())
                }
            }
            context("AndesMessage default callbacks") {
                it("calls secondary button handler") {
                    // Given
                    let message = AndesMessage(frame: .zero)
                    var called = false
                    message.setPrimaryAction("Primary", handler: nil)
                    message.setSecondaryAction("Secondary") { _ in called = true}

                    // When
                    (message.contentView as! AndesMessageWithActionsView).secondaryButtonTapped(self)

                    // Then
                    expect(called).toEventually(beTrue())
                }
            }
            context("AndesMessage Link Action") {
                it("calls link button handler") {
                    // Given
                    let message = AndesMessage(frame: .zero)
                    var called = false
                    message.setLinkAction("Link") { _ in called = true}

                    // When
                    (message.contentView as! AndesMessageWithActionsView).primaryButtonTapped(self)

                    // Then
                    expect(called).toEventually(beTrue())
                }
            }

            context("AndesMessage Body Links") {
                it("calls body link handler") {
                    // Given
                    let message = AndesMessage(frame: .zero)
                    var tappedIndex: Int?

                    message.body = "This is body message"

                    let links = [
                        AndesBodyLink(startIndex: 0, endIndex: 4),
                        AndesBodyLink(startIndex: 5, endIndex: 10)
                    ]
                    let bodyLinks = AndesBodyLinks(links: links, listener: { index in
                        tappedIndex = index
                    })
                    message.setBodyLinks(bodyLinks)

                    // When
                    _ = (message.contentView as! AndesMessageDefaultView).bodyTextView.delegate?.textView?(UITextView(), shouldInteractWith: URL(string: "1")!, in: NSRange(location: 0, length: 10), interaction: UITextItemInteraction(rawValue: 0)!)

                    // Then
                    expect(tappedIndex).toEventually(equal(1))
                }
            }

            context("AndesMessage with thumbnail") {
                it("should show thumbnail variant") {

                    let message = AndesMessage(frame: .zero)
                    message.thumbnail = UIImage()

                    expect(message.contentView.isKind(of: AndesMessageWithThumbnailView.self)).to(beTrue())
                }

                it("should show thumbnail with actions variant") {

                    let message = AndesMessage(frame: .zero)
                    message.thumbnail = UIImage()
                    message.setPrimaryAction("title", handler: {_ in })

                    expect(message.contentView.isKind(of: AndesMessageWithThumbnailAndActionsView.self)).to(beTrue())
                }
            }
        }
    }
}
