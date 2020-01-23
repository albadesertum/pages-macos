//
//  ProgressIndicator.swift
//  pages
//
//  Created by Vladimir Psyukalov on 12.02.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class ProgressIndicator: NSProgressIndicator {
    override func awakeFromNib() {
        super.awakeFromNib()
        let aqua = NSAppearance(named: .aqua)
        if #available(OSX 10.14, *) {
            let darkAqua = NSAppearance(named: .darkAqua)
            UserDefaults.standard.addObserver(self, forKeyPath: "AppleInterfaceStyle", options: .new, context: nil)
            appearance = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark" ? darkAqua : aqua
        } else {
            appearance = aqua
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if #available(OSX 10.14, *) {
            let aqua = NSAppearance(named: .aqua)
            let darkAqua = NSAppearance(named: .darkAqua)
            if keyPath == "AppleInterfaceStyle" {
                let value = change?[.newKey] as? String
                appearance = value == "Dark" ? darkAqua : aqua
            }
        }
    }
    
    deinit {
        if #available(OSX 10.14, *) {
            UserDefaults.standard.removeObserver(self, forKeyPath: "AppleInterfaceStyle")
        }
    }
}
