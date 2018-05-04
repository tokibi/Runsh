//
//  WindowController.swift
//  Runsh
//
//  Created by tokibi on 2018/05/01.
//

import Cocoa

class WindowController: NSWindowController {
    var appDelegate: AppDelegate = NSApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var modelessWindow: NSPanel!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        appDelegate.windowController = self

//        window?.titlebarAppearsTransparent = true
//        window?.titleVisibility = .hidden
//        window?.styleMask = .fullSizeContentView
    }
    
    func showAsKeyWindow() {
        // makeKeyAndOrderFront makes the key window, but it is not displayed.
        // So, afterwards it is forced to display at the forefront with orderFrontRegardless.
        modelessWindow.makeKeyAndOrderFront(nil)
        modelessWindow.orderFrontRegardless()
    }
    
    func hide() {
        modelessWindow.orderOut(nil)
    }
}
