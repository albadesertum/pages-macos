//
//  NSAlert+Instance.swift
//  NSAlert+Instance
//
//  Created by Vladimir Psyukalov on 31.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

extension NSAlert {
    static func alert(title: String, message: String, buttons: [String], style: NSAlert.Style = .critical) -> NSAlert {
        let result = NSAlert()
        result.messageText = title
        result.informativeText = message
        result.alertStyle = style
        for button in buttons {
            result.addButton(withTitle: button)
        }
        return result
    }
}
