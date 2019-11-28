//
//  WindowController.swift
//  MobaMac
//
//  Created by user on 2019/11/28.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet weak var navigationButtons: NSSegmentedControl!
    @IBOutlet weak var urlBar: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func navigationButtonClicked(_ sender: NSSegmentedControl) {
    }
    
    @IBAction func captureScreenshot(_ sender: NSButton) {
    }
}
