//
//  HotKeyManager.swift
//  Runsh
//
//  Created by tokibi on 2018/05/01.
//

import Foundation
import Cocoa
import Magnet

protocol HotKeyManagerDelegate: class {
    func hotKeyTapped(type: HotKeyType)
}

enum HotKeyType {
    case Run
    case CopyAndRun
}

final class HotKeyManager: NSObject {
    static let shared = HotKeyManager()
    
    weak var delegate: HotKeyManagerDelegate?
    
    private override init() {
        super.init()
    }
    
    func register() {
        // TODO: Load from preferences.
        let runKeyCombo = KeyCombo(keyCode: 3, cocoaModifiers: [.control, .command])!
        let runAndCopyKeyCombo = KeyCombo(keyCode: 3, cocoaModifiers: .control)!
        
        HotKey(identifier: "run", keyCombo: runKeyCombo, target: self, action: #selector(HotKeyManager.run)).register()
        HotKey(identifier: "copyAndRun", keyCombo: runAndCopyKeyCombo, target: self, action: #selector(HotKeyManager.copyAndRun)).register()
    }
    
    func unregister() {
        HotKeyCenter.shared.unregisterAll()
    }
    
    @objc private func run() {
        delegate?.hotKeyTapped(type: .Run)
    }
    
    @objc private func copyAndRun() {
        delegate?.hotKeyTapped(type: .CopyAndRun)
    }
}
