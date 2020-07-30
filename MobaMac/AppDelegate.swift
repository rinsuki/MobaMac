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
    lazy var windowController = WindowController()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("!")
        windowController = WindowController()
        windowController.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

