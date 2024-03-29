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
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let css: WKUserScript
        let cssString = """
        addEventListener("DOMContentLoaded", () => {
        document.querySelector("body > div:first-child").classList.add("docs-homescreen-freeze-el-full")
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
        })
        """
        if #available(OSX 11.0, *) {
            css = WKUserScript(source: cssString, injectionTime: .atDocumentStart, forMainFrameOnly: false, in: .page)
        } else {
            // Fallback on earlier versions
            css = WKUserScript(source:cssString, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        }
        
        let config = WKWebViewConfiguration()
        config.preferences._developerExtrasEnabled = true

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
        webView.allowsBackForwardNavigationGestures = true
        webView._pageZoomFactor = 1.25
        webView._overrideDeviceScaleFactor = 2
        webView.navigationDelegate = self
    }
    
    @objc func captureScreenshot() {
        let config = WKSnapshotConfiguration()
        webView.takeSnapshot(with: config) { (image, err) in
            guard let data = image?.tiffRepresentation else {
                return
            }
            guard let pngData = NSBitmapImageRep(data: data)?.representation(using: .png, properties: [:]) else {
                return
            }
            let formatter = DateFormatter()
            formatter.locale = .init(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyyMMdd_HHmmss"
            let fileName = formatter.string(from: .init()) + ".png"
            guard let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
            }
            let url = documentsDir.appendingPathComponent(fileName)
            do {
                try pngData.write(to: url)
                NSWorkspace.shared.open(url)
            } catch {
                let alert = NSAlert(error: error)
                alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
                return
            }
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        changeUrlBar()
        changeTitle()
    }
    
    private func changeUrlBar() {
        guard let windowController = view.window?.windowController as? WindowController else { return }
        guard var url = webView.url else { return }
//        if  let urlComponents = URLComponents(string: url.absoluteString.replacingOccurrences(of: "&amp;", with: "&")),
//            let urlQueryItems = urlComponents.queryItems,
//            let backendUrl = urlQueryItems.first(where: { $0.name == "url" })?.value {
//            url = URL(string: "mobamas://\(backendUrl.replacingOccurrences(of: "http://125.6.169.35/idolmaster/", with: ""))")!
//        }
        windowController.urlBar.stringValue = url.absoluteString
    }
    
    func changeTitle() {
        webView.evaluateJavaScript("""
(() => {
    const c=document.querySelector('#jsCommentTop')
    if(c) return c.textContent
    const d=document.querySelector('.area_menu_header h1')
    if(d) return d.textContent
})()
""") { res, err in
            if let res = res as? String {
                self.view.window?.title = res
            }
        }
    }
}
