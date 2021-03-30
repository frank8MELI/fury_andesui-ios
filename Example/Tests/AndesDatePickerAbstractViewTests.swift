//
//  AndesDatePickerAbstractViewTests.swift
//  AndesUI_Tests
//
//  Created by Ândriu Felipe Coelho on 17/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble

@testable import AndesUI

class AndesDatePickerAbstractViewTests: QuickSpec {

    var internalView: AndesDatePickerAbstractView!

    override func spec() {

        beforeEach {
            self.internalView = AndesDatePickerDefaultView()
            self.internalView.setDates(maxDate: nil)
        }

        afterEach {
            self.internalView = nil
        }

        describe("Test: checks that when instantiating the class, it is configured correctly") {
            context("Verify base date") {
                it("Initial properties correctly setted") {
                    expect(self.internalView.buttonPrimary.isEnabled).to(equal(true))
                }

                it("CollectionView data source should not be nil") {
                    expect(self.internalView.datePickerCollectionView.dataSource).toNot(beNil())
                }

                it("CollectionView delegate should not be nil") {
                    expect(self.internalView.datePickerCollectionView.delegate).toNot(beNil())
                }

                it("Button next month should add a month to the current date") {
                    var currentDate = self.internalView.baseDate
                    expect(currentDate).toNot(beNil())

                    currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? Date()
                    self.internalView.didTouchNextMonth()

                    expect(self.internalView.baseDate).to(equal(currentDate))
                }

                it("Button previous month should decrease a month to the current date") {
                    var currentDate = self.internalView.baseDate
                    expect(currentDate).toNot(beNil())

                    currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
                    self.internalView.didTouchPreviousMonth()

                    expect(self.internalView.baseDate).to(equal(currentDate))
                }
            }
        }
    }
}
