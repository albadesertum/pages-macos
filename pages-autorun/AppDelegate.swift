//
//  AppDelegate.swift
//  pages-autorun
//
//  Created by Vladimir Psyukalov on 27.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let identifier = Identifiers.main
        let workspace = NSWorkspace.shared
        let runningApps = workspace.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == identifier }.isEmpty
        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(terminate(_:)), name: .terminateNotificationName, object: identifier)
            var components = NSString(string: Bundle.main.bundlePath).pathComponents
            components.removeLast(3)
            components.append("MacOS")
            components.append(Identifiers.appName)
            workspace.launchApplication(NSString.path(withComponents: components))
        } else {
            terminate(nil)
        }
    }
    
    @objc private func terminate(_ sender: AnyObject?) {
        NSApp.terminate(nil)
    }
}
