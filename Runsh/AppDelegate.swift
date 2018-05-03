//
//  AppDelegate.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Foundation
import Cocoa
import Darwin

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var mainViewController: MainViewController!
    
    let pid = getpid()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        HotKeyManager.shared.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

