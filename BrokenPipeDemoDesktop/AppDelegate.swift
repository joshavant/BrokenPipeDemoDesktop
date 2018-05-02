//
//  AppDelegate.swift
//  BrokenPipeDemoDesktop
//
//  Created by Josh Avant on 5/2/18.
//  Copyright © 2018 Josh Avant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let server = DemoServer()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        try! self.server.run()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

