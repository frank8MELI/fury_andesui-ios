//
//  ListRouter.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 16/10/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class ListRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [ListViewController(), ListObjcViewController()])
        viewController.title = Commons.ComponentsTitle.andesList
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
