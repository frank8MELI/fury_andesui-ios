//
//  AndesDropdownTests.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 1/12/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI

class AndesDropdownTests: QuickSpec {

    var andesDropdown: AndesDropdown = AndesDropdown()
    var cell: [AndesDropDownMenuCell] = []
    private var contentView: AndesDropdownView!

    override func spec() {
        describe("AndesDropdown should draw it's view based trigger type and menu type") {
            context("AndesDropdown Implementation") {
                beforeEach {
                    let icon = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size80, state: .enabled, image: UIImage(named: "mastercard") ?? UIImage(), accentColor: UIColor.systemBlue)
                    self.cell = [AndesDropDownMenuCell(title: "Dinero en cuenta", thumbnail: icon)]
                }
                it("FormDropdownTrigger implementation") {
                    //Given
                    self.andesDropdown.triggerType = FormDropdownTrigger(title: "Title", placeholder: "Placeholder")
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When

                    //Then
                    expect((self.andesDropdown.triggerType as! FormDropdownTrigger).title).to(equal("Title"))
                }
                it("StandaloneDropdownTrigger implementation") {
                    //Given
                    self.andesDropdown.triggerType = StandaloneDropdownTrigger(size: .small)
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When

                    //Then
                    expect((self.andesDropdown.triggerType as! StandaloneDropdownTrigger).size).to(equal(AndesStandaloneSize.small))
                }
                it("DropdownBottomSheetMenu implementation") {
                    //Given
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When

                    //Then
                    expect((self.andesDropdown.menuType as! DropdownBottomSheetMenu).rows.count).to(equal(1))
                    expect((self.andesDropdown.menuType as! DropdownBottomSheetMenu).separatorStyle).to(equal(.singleLine))
                    expect((self.andesDropdown.menuType as! DropdownBottomSheetMenu).numberOfLines).to(equal(0))
                    expect((self.andesDropdown.menuType as! DropdownBottomSheetMenu).selectionStyle).to(equal(.defaultStyle))
                }
                it("Get rootViewController") {
                    //Given
                    let navigationController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
                    self.andesDropdown.delegate = self
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When
                    self.andesDropdown.didSelectTrigger()

                    //Then
                    expect((self.andesDropdown.menuType as! DropdownBottomSheetMenu).type).to(equal(.bottomSheet))
                    expect(navigationController.visibleViewController).to(beAnInstanceOf(AndesBottomSheetViewController.self))
                }
                it("Call delegate") {
                    //Given
                    let mock = AndesDropdownDelegateMock()
                    self.andesDropdown.delegate = mock
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When
                    self.andesDropdown.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0))

                    //Then
                    expect(mock.didSelect).to(beTrue())
                }

                it("Get small size Standalone Dropdown") {
                    //Given
                    self.andesDropdown.triggerType = StandaloneDropdownTrigger(size: .small)
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When
                    let config = AndesDropdownViewConfigFactory.provide(from: self.andesDropdown, isSelected: false)
                    let trigger = AndesStandaloneSizeFactory.provideSize(withSize: .small)

                    //Then
                    expect(trigger.widthChevron).to(beIdenticalTo(config.heightChevron))
                }

                it("Get medium size Standalone Dropdown") {
                    //Given
                    self.andesDropdown.triggerType = StandaloneDropdownTrigger(size: .medium)
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When
                    let config = AndesDropdownViewConfigFactory.provide(from: self.andesDropdown, isSelected: false)
                    let trigger = AndesStandaloneSizeFactory.provideSize(withSize: .medium)

                    //Then
                    expect(trigger.widthChevron).to(beIdenticalTo(config.heightChevron))
                }

                it("Get large size Standalone Dropdown") {
                    //Given
                    self.andesDropdown.triggerType = StandaloneDropdownTrigger(size: .large)
                    self.andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .singleLine,
                                                                          numberOfLines: 0,
                                                                          rows: self.cell,
                                                                          selectionStyle: .defaultStyle)

                    //When
                    let config = AndesDropdownViewConfigFactory.provide(from: self.andesDropdown, isSelected: false)
                    let trigger = AndesStandaloneSizeFactory.provideSize(withSize: .large)

                    //Then
                    expect(trigger.widthChevron).to(beIdenticalTo(config.heightChevron))
                }

            }
        }
    }
}

extension AndesDropdownTests: AndesDropdownDelegate {
    func didSelectRowAt(indexPath: IndexPath) { }
}

class AndesDropdownDelegateMock: AndesDropdownDelegate {

    var didSelect: Bool = false

    func didSelectRowAt(indexPath: IndexPath) {
        didSelect = true
    }
}
