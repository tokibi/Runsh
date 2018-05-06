//
//  CopyEmulator.swift
//  Runsh
//
//  Created by tokibi on 2018/05/06.
//

import Foundation
import Cocoa
import RxSwift
import RxCocoa

class UserCommandEmulator {
    static let general = UserCommandEmulator()
    
    private init() {
    }
    
    func copy(from pid: pid_t) -> Observable<String?> {
        let pasteboardWatcher = PasteboardWatcher()
        let observable = pasteboardWatcher.startPolling()
        CopyKeySender().send(to: pid)
        return observable // relay events
    }
    
    func paste(to pid: pid_t, pasteString: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(pasteString, forType: .string)
        PasteKeySender().send(to: pid)
    }
}

