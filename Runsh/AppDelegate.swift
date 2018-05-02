//
//  AppDelegate.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Foundation
import Cocoa
import Magnet

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var mainViewController: MainViewController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        HotKeyManager.shared.register(keyCombo: KeyCombo(keyCode: 3, cocoaModifiers: .control)!) // Control + F
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

