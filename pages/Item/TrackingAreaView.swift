//
//  TrackingAreaView.swift
//  pages
//
//  Created by Vladimir Psyukalov on 10.02.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class TrackingAreaView: NSView {
    weak var item: Item?
    
    private var area: NSTrackingArea?
    
    override var frame: NSRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            updateTrackingArea()
        }
    }
    
    // MARK: - Override
    
    override func mouseEntered(with event: NSEvent) {
        item?.trackingAreaDidMouseEntered(with: event)
    }
    
    override func mouseExited(with event: NSEvent) {
        item?.trackingAreaDidMouseExited(with: event)
    }
    
    override func mouseDown(with event: NSEvent) {
        item?.trackingAreaDidLeftMouseDown(with: event)
    }
    
    override func mouseUp(with event: NSEvent) {
        item?.trackingAreaDidLeftMouseUp(with: event)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        item?.trackingAreaDidRightMouseDown(with: event)
    }
    
    override func rightMouseUp(with event: NSEvent) {
        item?.trackingAreaDidRightMouseUp(with: event)
    }
    
    // MARK: - Private
    
    private func updateTrackingArea() {
        if let area = area {
            removeTrackingArea(area)
        }
        area = NSTrackingArea(rect: frame, options: [.activeAlways, .mouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(area!)
    }
}
