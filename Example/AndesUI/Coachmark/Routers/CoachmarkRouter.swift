//
//  CoachmarkRouter.swift
//  AndesUI-demoapp
//
//  Created by JONATHAN DANIEL BANDONI on 06/08/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class CoachmarkRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [CoachmarkViewController(), CoachmarkObjCViewController()])
        viewController.title = Commons.ComponentsTitle.andesCoachmark
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
