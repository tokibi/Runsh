//
//  ViewController.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Cocoa

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
        
    }
}
