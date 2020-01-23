//
//  HighlightedItem.swift
//  pages
//
//  Created by Vladimir Psyukalov on 12.02.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class HighlightedItem: Item {
    var isHightlighted: Bool {
        get {
            return statusItem.button?.isHighlighted ?? false
        }
        set {
            statusItem.button?.isHighlighted = newValue
        }
    }
    
    // MARK: - Preferred
    
    func preferredIsFixated() -> Bool {
        return false
    }
    
    func preferredCountdown() -> Int {
        return 0
    }
    
    // MARK: - Override
    
    override func trackingAreaDidMouseEntered(with event: NSEvent) {
        super.trackingAreaDidMouseEntered(with: event)
        didEntered()
    }
    
    override func trackingAreaDidMouseExited(with event: NSEvent) {
        super.trackingAreaDidMouseExited(with: event)
        didExited(0.2)
    }
    
    override func viewControllerDidMouseEntered(with event: NSEvent) {
        super.viewControllerDidMouseEntered(with: event)
        didEntered()
    }
    
    override func viewControllerDidMouseExited(with event: NSEvent) {
        super.viewControllerDidMouseExited(with: event)
        didExited(preferredCountdown())
    }
    
    // MARK: - Private
    
    private func didEntered() {
        isHightlighted = true
        cancelHideTask()
        show()
        if isShown {
            orderFront()
        }
    }
    
    private func didExited(_ countdown: Int) {
        didExited(Double(countdown))
    }
    
    private func didExited(_ countdown: Double) {
        isHightlighted = false
        cancelHideTask()
        if !preferredIsFixated() {
            executeHideTask(countdown, animated: false)
        }
    }
    
    private func orderFront() {
        viewController.view.window?.makeKeyAndOrderFront(nil)
    }
}
