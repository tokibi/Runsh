//
//  HotKeyManager.swift
//  Runsh
//
//  Created by tokibi on 2018/05/01.
//

import Foundation
import Cocoa
import Magnet

final class HotKeyManager: NSObject, PasteboardWatcherDelegate {
    static let shared = HotKeyManager()
    
    public var deactivatedApp: NSRunningApplication?
    public var copiedString: String?
    fileprivate let pasteboardWatcher = PasteboardWatcher()
    
    private override init() {
        super.init()
        self.pasteboardWatcher.delegate = self
    }
    
    func register(keyCombo: KeyCombo) {
        HotKey(identifier: "hotkey", keyCombo: keyCombo, target: self, action: #selector(HotKeyManager.tapped)).register()
    }
    
    func unregister() {
        HotKeyCenter.shared.unregisterAll()
    }
    
    @objc private func tapped() {
        deactivatedApp = NSWorkspace.shared.runningApplications.first(where: { $0.isActive })
        CopyKeySender().send()
        pasteboardWatcher.startPolling()
    }
    
    // Delegate method
    func newlyStringObtained(copiedString: String?) {
        guard let unwrappedStr = copiedString else { return }
        self.copiedString = unwrappedStr
        
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}
