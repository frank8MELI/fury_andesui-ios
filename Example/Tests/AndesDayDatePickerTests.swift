//
//  AndesDayDatePickerTests.swift
//  AndesUI_Tests
//
//  Created by Ândriu Felipe Coelho on 17/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble

@testable import AndesUI

class AndesDayDatePickerTests: QuickSpec {

    var internalView: AndesDatePickerAbstractView!

    override func spec() {

        beforeEach {
            self.internalView = AndesDatePickerDefaultView()
        }

        afterEach {
            self.internalView = AndesDatePickerDefaultView()
        }

        describe("Test: checks if the class correctly constructs the days of the month") {
            context("verify class") {

                it("base date should not be nil") {
                    expect(self.internalView.daysToRender).toNot(beNil())
                }

                it("verify days to render in calendar") {
                    guard let currentDate = Calendar.current.date(from: DateComponents(year: 2020, month: 11, day: 17)) else {
                        fatalError("error to create date")
                    }

                    let daysToRender = self.internalView.dayCalendar.getDaysInMonth(currentDate, Date())

                    expect(daysToRender.count).to(equal(42))

                    let firstDayInCalendar = daysToRender[0]
                    expect(firstDayInCalendar.number).to(equal("26"))

                    let lastDayInCalendar = daysToRender[daysToRender.count-1]
                    expect(lastDayInCalendar.number).to(equal("6"))
                }
            }
        }
    }

}
