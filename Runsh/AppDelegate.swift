//
//  AppDelegate.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Foundation
import Cocoa
import Darwin
import RxSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var windowController: WindowController?
    var mainViewController: MainViewController?
    var copiedString: String?
    
    let bag = DisposeBag()
    let hotKeyManager = HotKeyManager.shared
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        hotKeyManager.delegate = self
        hotKeyManager.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        hotKeyManager.unregister()
    }
    
    func activeApplication() -> NSRunningApplication? {
        if let activeApp = NSWorkspace.shared.runningApplications.first(where: { $0.isActive }) {
            return activeApp
        }
        return nil
    }
    
    func pasteResult(result: String) {
        guard let activeApp = activeApplication() else { return }
        UserCommandEmulator.general.paste(to: activeApp.processIdentifier, pasteString: result)
        windowController?.hide()
    }
}

extension AppDelegate: HotKeyManagerDelegate {
    func hotKeyTapped(type: HotKeyType) {
        guard let activeApp = activeApplication() else { return }
        if activeApp.processIdentifier == getpid() { return }

        switch type {
        case .Run:
            self.copiedString = nil
        case .CopyAndRun:
            UserCommandEmulator.general.copy(from: activeApp.processIdentifier)
                .subscribe(onNext: { [weak self] value in
                    self?.copiedString = value
                })
                .disposed(by: bag)
        }
        
        windowController?.showAsKeyWindow()
    }
}
