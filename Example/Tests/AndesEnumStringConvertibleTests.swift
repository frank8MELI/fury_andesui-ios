//
//  AndesEnumStringConvertibleTests.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 4/22/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Quick
import Nimble
@testable import AndesUI
class AndesEnumStringConvertibleTests: QuickSpec {
    enum TestEnum: Int, AndesEnumStringConvertible, CaseIterable {
        static func keyFor(_ value: AndesEnumStringConvertibleTests.TestEnum) -> String {
            switch value {
            case .caseOne: return "ONE"
            case .caseTwo: return "TWO"
            case .caseThree: return "THREE"
            }
        }

        case caseOne
        case caseTwo
        case caseThree
    }

    override func spec() {
        describe("Tests AndesEnumStringConvertible") {
            context("We want all enums to fail in conversion from interface builder, but we want the init to return nil on other cases") {
                it("init fails when no key found") {
                    // given
                    let wrongKey = "fail"

                    // When
                    let test = TestEnum.init(from: wrongKey)

                    //expect
                    expect(test).to(beNil())
                }

                it("fails check when wrong key passed") {
                    // given
                    let wrongKey = "fail"

                    //When check called expect
                    expect(expression: {
                        TestEnum.checkValidEnum(property: "IBProperty", key: wrongKey)
                    }).to(throwAssertion())
                }
            }

            context("String conversion") {
                it("can be inited from str") {
                    // given
                    let key = "ONE"

                    // When
                    let test = TestEnum.init(from: key)

                    //expect
                    expect(test).to(equal(.caseOne))
                }

                it("case shouldn't matter") {
                    // given
                    let awfulButValidKey = "ThReE"

                    //When
                    let test = TestEnum.init(from: awfulButValidKey)

                    //Expect
                    expect(test).to(equal(.caseThree))
                }

                it("converts back to uppercased") {
                    // given
                   let awfulButValidKey = "ThReE"

                   //When
                    let test = TestEnum.init(from: awfulButValidKey)?.toString()

                   //Expect
                   expect(test).to(equal("THREE"))
                }
            }
        }
    }
}
