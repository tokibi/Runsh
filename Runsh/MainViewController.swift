//
//  ViewController.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Foundation
import Cocoa
import SwiftShell

class MainViewController: NSViewController {
    var appDelegate: AppDelegate = NSApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.mainViewController = self
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func textFieldAction(_ sender: NSTextField) {
        if textField.stringValue.isEmpty { return }
        guard let result = runCommand(command: textField.stringValue) else { return }
        appDelegate.pasteResult(result: result)
    }
    
    func runCommand(command: String) -> String? {
        var context = CustomContext(main)
        context.env["PATH"] = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        
        let prefix = appDelegate.copiedString == nil ? "" : "pbpaste | "
        return context.run(bash: prefix + command).stdout
    }
}
