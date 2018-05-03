//
//  ViewController.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Cocoa

class MainViewController: NSViewController {
    var appDeligate: AppDelegate = NSApplication.shared.delegate as! AppDelegate
    
    private let pasteboardWatcher = PasteboardWatcher()
    private let hotKeyManager = HotKeyManager.shared
    private var deactivatedApp: NSRunningApplication?
    private var copiedString: String?
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDeligate.mainViewController = self
        pasteboardWatcher.delegate = self
        hotKeyManager.delegate = self
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func textFieldAction(_ sender: NSTextField) {
        
    }
}

extension MainViewController: HotKeyManagerDelegate {
    func hotKeyTapped(type: HotKeyType) {
        let activeApp = NSWorkspace.shared.runningApplications.first(where: { $0.isActive })
        if activeApp?.processIdentifier == appDeligate.pid { return }
        
        switch type {
        case .Run:
            self.copiedString = nil
        case .CopyAndRun:
            pasteboardWatcher.startPolling()
            CopyKeySender().send()
        }
        
        self.deactivatedApp = activeApp
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}

extension MainViewController: PasteboardWatcherDelegate {
    func newlyStringObtained(copiedString: String?) {
        guard let unwrappedString = copiedString else {
            self.copiedString = nil
            return
        }
        self.copiedString = unwrappedString
    }
}
