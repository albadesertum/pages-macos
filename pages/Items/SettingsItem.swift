//
//  SettingsItem.swift
//  pages
//
//  Created by Vladimir Psyukalov on 27.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class SettingsItem: HighlightedItem {
    
    // MARK: - Preferred
    
    override func preferredViewController() -> ViewController {
        return SettingsViewController()
    }
    
    override func preferredCountdown() -> Int {
        return SettingsService.countdown
    }
    
    // MARK: - Override
    
    override func setup() {
        super.setup()
        image = NSImage(named: "settings_button")
    }
    
    override func trackingAreaDidLeftMouseUp(with event: NSEvent) {
        super.trackingAreaDidLeftMouseUp(with: event)
        toggle()
    }
}
