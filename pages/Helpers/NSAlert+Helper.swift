//
//  NSAlert+Helper.swift
//  pages
//
//  Created by Vladimir Psyukalov on 31.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

extension NSAlert {
    static func info() -> NSAlert {
        return NSAlert.alert(title: "l_info_title".localized, message: "l_info_message".localized, buttons: ["l_close".localized], style: .informational)
    }
}
