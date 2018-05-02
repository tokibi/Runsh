//
//  ViewController.swift
//  Runsh
//
//  Created by tokibi on 2018/04/28.
//

import Cocoa
import Magnet

class MainViewController: NSViewController {
    var appDeligate: AppDelegate = NSApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDeligate.mainViewController = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

