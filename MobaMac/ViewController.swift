//
//  ViewController.swift
//  MobaMac
//
//  Created by user on 2019/11/28.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Cocoa
import WebKit
import SnapKit

class ViewController: NSViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let css = WKUserScript(source: """
(() => {
const css = `
html {
    -webkit-font-smoothing: antialiased;
    overflow-y: ${location.href.includes("smart_phone_flash") ? "hidden": "scroll"};
}
body {
    font-family: Helvetica, HiraKakuPro-W3, sans-serif !important;
}
`
const dom = document.createElement("style")
dom.innerHTML=css
document.head.appendChild(dom)
})()
""", injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        let config = WKWebViewConfiguration()

        let contentController = WKUserContentController()
        contentController.addUserScript(css)
        config.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: config)
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.width.equalTo((320 * 1.25) + 16)
        }

        let req = URLRequest(url: URL(string: "http://sp.pf.mbga.jp/12008305")!)
        webView.load(req)
        webView.allowsMagnification = true
        webView.magnification = 2
        webView.allowsBackForwardNavigationGestures = true
        webView._pageZoomFactor = 1.25
        webView._allowsRemoteInspection = true
        webView._overrideDeviceScaleFactor = 2
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

