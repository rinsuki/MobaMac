//
//  WindowController.swift
//  MobaMac
//
//  Created by user on 2019/11/28.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Cocoa
import Ikemen

class WindowController: NSWindowController {
    
    private lazy var toolbar = NSToolbar(identifier: "NavigationToolbar") ※ { v in
        v.autosavesConfiguration = true
        v.allowsUserCustomization = true
    }
    private lazy var navigationButtons = NSSegmentedControl(
        labels: ["<", ">"], trackingMode: .momentary,
        target: self, action: #selector(navigationButtonClicked)
    )
    private lazy var openMyStudioButton = NSButton(title: "🏠", target: self, action: #selector(self.openMyStudio)) ※ { b in
        b.bezelStyle = .texturedRounded
    }
    lazy var urlBar = NSTextField(string: "") ※ { v in
        v.bezelStyle = .roundedBezel
        v.isEditable = true
    }
    private lazy var captureButton = NSButton(title: "📸", target: self, action: #selector(self.captureScreenshot)) ※ { b in
        b.bezelStyle = .texturedRounded
    }
    
    init() {
        super.init(window: .init(.init(contentViewController: ViewController())))
        window!.center()
        window!.setFrameAutosaveName("Main Window")
        toolbar.delegate = self
        window!.toolbar = toolbar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    @objc func navigationButtonClicked() {
    }
    
    @objc func openMyStudio() {
    }
    
    @objc func captureScreenshot() {
    }
}

fileprivate extension NSToolbarItem.Identifier {
    static let navigationButton = NSToolbarItem.Identifier(rawValue: "navigationButton")
    static let openMyStudioButton = NSToolbarItem.Identifier(rawValue: "openMyStudioButton")
    static let addressBar = NSToolbarItem.Identifier(rawValue: "addressBar")
    static let captureButton = NSToolbarItem.Identifier(rawValue: "captureButton")
}

extension WindowController: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .navigationButton,
            .openMyStudioButton,
            .addressBar,
            .captureButton,
        ]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        print(itemIdentifier)
        let item = NSToolbarItem(itemIdentifier: itemIdentifier)
        switch itemIdentifier {
        case .navigationButton:
            item.view = navigationButtons
            item.label = "戻る/進む"
        case .openMyStudioButton:
            item.view = openMyStudioButton
            item.label = "マイスタジオ"
        case .addressBar:
            item.view = urlBar
            item.label = "アドレス"
        case .captureButton:
            item.view = captureButton
            item.label = "キャプチャ"
        default:
            return nil
        }
        return item
    }
}
