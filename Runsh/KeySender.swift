//
//  KeySender.swift
//  Runsh
//
//  Created by tokibi on 2018/04/30.
//

import Foundation

protocol KeySender {
    var keyCode: CGKeyCode { get }
    var flags: CGEventFlags { get }
    func send()
}

extension KeySender {
    func send() {
        // Ignore user keystrokes
        let eventSource = CGEventSource(stateID: CGEventSourceStateID.privateState)
        
        let downEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: keyCode, keyDown: true)
        let upEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: keyCode, keyDown: false)
        
        downEvent?.flags = flags
        downEvent?.post(tap: .cghidEventTap)
        upEvent?.post(tap: .cghidEventTap)
    }
}

struct CopyKeySender: KeySender {
    let keyCode: CGKeyCode = 8
    let flags: CGEventFlags = .maskCommand
}

struct PasteKeySender: KeySender {
    let keyCode: CGKeyCode = 9
    let flags: CGEventFlags = .maskCommand
}
