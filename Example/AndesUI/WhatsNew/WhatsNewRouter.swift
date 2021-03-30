//
//  WhatsNewRouter.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 2/6/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//
import Foundation

class WhatsNewRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        from.navigationController?.pushViewController(WhatsNewViewController(), animated: true)
    }
}
