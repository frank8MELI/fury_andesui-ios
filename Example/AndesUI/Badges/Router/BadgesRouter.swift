//
//  BadgesRouter.swift
//  AndesUI-demoapp
//

import Foundation

class BadgesRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [BadgeViewController(), BadgeObjCViewController()])
        viewController.title = Commons.ComponentsTitle.andesBadge
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
