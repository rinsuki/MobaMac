//
//  AppDelegate.swift
//  MobaMac
//
//  Created by user on 2019/11/28.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let windowController = WindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("!")
        windowController.showWindow(self)
        windowController.window?.orderFront(self)
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            windowController.showWindow(self)
            windowController.window?.orderFront(self)
        }
        return false
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

