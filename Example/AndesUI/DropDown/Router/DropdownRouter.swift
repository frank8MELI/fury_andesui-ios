//
//  DropdownRouter.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class DropdownRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [DropdownViewController(), DropDownObjcViewController()])
        viewController.title = Commons.ComponentsTitle.andesDropdown
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
