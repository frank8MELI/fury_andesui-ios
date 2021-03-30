//
//  WhatsNewViewController.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 2/6/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import WebKit

class WhatsNewViewController: UIViewController {
    var webView: WKWebView!

    fileprivate func setupWebview() {
        webView = WKWebView(frame: self.view.frame)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "whatsnew.title".localized
        setupWebview()
        let url = Bundle.main.url(forResource: "whats_new", withExtension: "html")!

        webView.loadFileURL(url, allowingReadAccessTo: url)
    }
}
