//
//  PasteboardWatcher.swift
//  Runsh
//
//  Created by tokibi on 2018/05/01.
//

import Cocoa
import RxSwift

class PasteboardWatcher {
    private var eventSubject = PublishSubject<String?>()
    private var changeCount: Int?
    private var timer: Timer?
    private let pasteboard = NSPasteboard.general
    
    func startPolling() -> Observable<String?> {
        eventSubject = PublishSubject()
        changeCount = pasteboard.changeCount
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(observePasteboard), userInfo: nil, repeats: true)
        
        // Stop timer after 1 second (Avoid infinite loop when text is not selected)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.timer?.invalidate()
            self.eventSubject.onNext(nil)
            self.eventSubject.onCompleted()
        }
        
        return eventSubject
    }
    
    @objc private func observePasteboard() {
        if let copiedString = pasteboard.string(forType: .string), pasteboard.changeCount != changeCount {
            // Stop timer
            self.timer?.invalidate()
            self.eventSubject.onNext(copiedString)
            self.eventSubject.onCompleted()
        }
    }
}
