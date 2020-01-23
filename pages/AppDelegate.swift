//
//  AppDelegate.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let mainService = MainService.shared
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        terminateIfNeeded()
        mainService.setup()
    }
    
    private func terminateIfNeeded() {
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == Identifiers.autorun }.isEmpty
        if isRunning {
            DistributedNotificationCenter.default().post(name: .terminateNotificationName, object: Identifiers.main)
        }
    }
}
