//
//  TextFieldsCodeRouter.swift
//  AndesUI-demoapp
//
//  Created by Esteban Adrian Boffa on 16/09/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//
import Foundation

class TextFieldsCodeRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [TextFieldsCodeViewController(), TextFieldsCodeObjCViewController()])
        viewController.title = Commons.ComponentsTitle.andesTextField
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
