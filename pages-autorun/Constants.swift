//
//  Constants.swift
//  pages
//
//  Created by Vladimir Psyukalov on 27.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let terminateNotificationName = Notification.Name("terminateNotificationName")
}

struct Identifiers {
    private static let bundleIdentifier = "com.zuzex.pages"
    
    static let main = Identifiers.bundleIdentifier
    static let autorun = Identifiers.bundleIdentifier + "-autorun"
    
    static let appName = "zPages"
}
