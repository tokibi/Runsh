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
    var windowController: WindowController?
    var mainViewController: MainViewController?
    var copiedString: String?
    
    let pasteboardWatcher = PasteboardWatcher()
    let hotKeyManager = HotKeyManager.shared
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        pasteboardWatcher.delegate = self
        hotKeyManager.delegate = self
        hotKeyManager.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        hotKeyManager.unregister()
    }
}

extension AppDelegate: HotKeyManagerDelegate {
    func hotKeyTapped(type: HotKeyType) {
        guard let activeApp = NSWorkspace.shared.runningApplications.first(where: { $0.isActive }) else {
            return
        }
        if activeApp.processIdentifier == getpid() { return }

        switch type {
        case .Run:
            self.copiedString = nil
        case .CopyAndRun:
            pasteboardWatcher.startPolling()
            CopyKeySender().send()
        }
        
        windowController?.showAsKeyWindow()
    }
}

extension AppDelegate: PasteboardWatcherDelegate {
    func newlyStringObtained(copiedString: String?) {
        guard let unwrappedString = copiedString else {
            self.copiedString = nil
            return
        }
        self.copiedString = unwrappedString
    }
}

