//
//  UITabBarItemAndesBadgeExtension.swift
//  AndesUI_Tests
//
//  Created by Julián Lima on 03/02/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import AndesUI

final class UITabBarItemAndesBadgeExtension: QuickSpec {
    override func spec() {
        describe("UITabBarItemAndes+BadgeExtension") {
            context("tabBarItem is empty") {
                it("The badgeValue should be nil") {
                    let tabBar = createTabBar()
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(beNil())
                }
            }

            context("tabBarItem received a value lower than 0") {
                it("The badgeValue should be nil") {
                    let tabBar = createTabBar()
                    tabBar.tabBar.items?.first?.setAndesBadge(with: -1)
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(beNil())
                }
            }

            context("tabBarItem received a value equal to 0") {
                it("The badgeValue should be 0") {
                    let tabBar = createTabBar()
                    tabBar.tabBar.items?.first?.setAndesBadge(with: 0)
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(beNil())
                }
            }

            context("tabBarItem received a value higher than 1 and then 0") {
                it("The badgeValue should be empty") {
                    let tabBar = createTabBar()
                    tabBar.tabBar.items?.first?.setAndesBadge(with: 1)
                    tabBar.tabBar.items?.first?.setAndesBadge(with: 0)
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(equal(""))
                }
            }

            context("tabBarItem received a value equal to 99") {
                it("The badgeValue should be 99") {
                    let tabBar = createTabBar()
                    tabBar.tabBar.items?.first?.setAndesBadge(with: 99)
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(equal("99"))
                }
            }

            context("tabBarItem received a value higher than 99") {
                it("The badgeValue should be 99+") {
                    let tabBar = createTabBar()
                    tabBar.tabBar.items?.first?.setAndesBadge(with: 100)
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(equal("99+"))
                }
            }

            context("tabBarItem has received a value different of 0 and then is removed") {
                it("The badgeValue should be empty") {
                    let tabBar = createTabBar()
                    tabBar.tabBar.items?.first?.setAndesBadge(with: 1)
                    tabBar.tabBar.items?.first?.removeAndesBadge()
                    expect(tabBar.tabBar.items?.first?.badgeValue).to(equal(""))
                }
            }
        }
    }
}

func createTabBar() -> UITabBarController {
    let tabController = UITabBarController(nibName: nil, bundle: nil)
    let itemViewController = UIViewController(nibName: nil, bundle: nil)
    tabController.viewControllers = [itemViewController]
    return tabController
}
