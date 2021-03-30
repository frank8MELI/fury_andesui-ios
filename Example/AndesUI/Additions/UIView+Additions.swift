//
//  UIView+Additions.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 2/7/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

extension UIView {

    /// Must be views in the same hierarchy, else this will throw an exception
    ///
    /// - Parameter view: view in the same view hierarchy
    func pinTo(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
