//
//  HomePresenter.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

class HomePresenter {
    private let router = HomeAppRouter()
    unowned var viewController: UIViewController?

    func present(view: TestappViews) {
        if let vc = self.viewController {
            self.router.doRoute(fromVC: vc, newRouter: view)
        }
    }
}
