//
//  NSStatusItem+Instance.swift
//  NSStatusItem+Instance
//
//  Created by Vladimir Psyukalov on 24.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

extension NSStatusItem {
    static func statusItem(title: String?, imageName: String?, target: AnyObject?, action: Selector?) -> NSStatusItem {
        let result = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let button = result.button
        button?.font = NSFont.monospacedDigitSystemFont(ofSize: 14.0, weight: .regular)
        button?.image = NSImage(named: imageName ?? "")
        button?.title = title ?? ""
        button?.target = target
        button?.action = action
        return result
    }
    
    func removeFromStatusBar() {
        NSStatusBar.system.removeStatusItem(self)
    }
}
