//
//  PasteboardWatcher.swift
//  Runsh
//
//  Created by tokibi on 2018/05/01.
//

import Cocoa

protocol PasteboardWatcherDelegate: class {
    func newlyStringObtained(copiedString: String?)
}

class PasteboardWatcher: NSObject {
    private let pasteboard = NSPasteboard.general
    
    private var changeCount: Int?
    private var timer: Timer?
    
    weak var delegate: PasteboardWatcherDelegate?
    
    func startPolling() {
        changeCount = pasteboard.changeCount
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(observePasteboard), userInfo: nil, repeats: true)
        
        // Stop timer after 1 second (Avoid infinite loop when text is not selected)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (Timer) in
            self.timer?.invalidate()
        })
    }
    
    @objc private func observePasteboard() {
        if let copiedString = pasteboard.string(forType: .string), pasteboard.changeCount != changeCount {
            self.delegate?.newlyStringObtained(copiedString: copiedString)
            // Stop timer
            timer?.invalidate()
        }
    }
}
