//
//  Item.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class Item {
    private(set) var statusItem: NSStatusItem
    
    private(set) var popover: NSPopover
    
    private(set) var trackingAreaView: TrackingAreaView
    
    lazy private(set) var viewController: ViewController = preferredViewController()
    
    var isShown: Bool {
        return popover.isShown
    }
    
    var isTask: Bool {
        return hideTask != nil
    }
    
    var title: String? {
        get {
            return statusItem.button?.title
        }
        set {
            statusItem.button?.title = newValue ?? ""
            updateTrackingAreaView()
        }
    }
    
    var image: NSImage? {
        get {
            return statusItem.button?.image
        }
        set {
            statusItem.button?.image = newValue
            updateTrackingAreaView()
        }
    }
    
    private var hideTask: DispatchWorkItem?
    
    // MARK: - Init
    
    init() {
        self.statusItem = NSStatusItem.statusItem(title: nil, imageName: nil, target: nil, action: nil)
        self.popover = NSPopover()
        self.trackingAreaView = TrackingAreaView()
        self.setup()
    }
    
    // MARK: - Preferred
    
    func preferredViewController() -> ViewController {
        return ViewController()
    }
    
    // MARK: - Public
    
    func setup() {
        trackingAreaView.item = self
        viewController.item = self
        statusItem.button?.action = nil
        statusItem.button?.imagePosition = .imageOnly
        statusItem.button?.addSubview(trackingAreaView)
        popover.contentViewController = viewController
    }
    
    func executeHideTask(_ countdown: Int = 0, animated: Bool) {
        executeHideTask(Double(countdown), animated: animated)
    }
    
    func executeHideTask(_ countdown: Double = 0.0, animated: Bool) {
        hideTask = nil
        hideTask = DispatchWorkItem { [weak self] in
            self?.hide(animated: animated)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + countdown, execute: hideTask!)
    }
    
    func cancelHideTask() {
        hideTask?.cancel()
    }
    
    func toggle(animated: Bool = false) {
        if isShown {
            hide(animated: animated)
        } else {
            show(animated: animated)
        }
    }
    
    func show(animated: Bool = false) {
        if isShown {
            return
        }
        guard let button = statusItem.button else {
            return
        }
        popover.animates = animated
        popover.show(relativeTo: button.frame, of: button, preferredEdge: .minY)
        viewController.popoverDidShow(animated: animated)
    }
    
    func hide(animated: Bool = false) {
        if !isShown {
            return
        }
        popover.animates = animated
        popover.performClose(nil)
        viewController.popoverDidHide(animated: animated)
    }
    
    // MARK: - Abstract
    
    func trackingAreaDidMouseEntered(with event: NSEvent) {
        /* Abstract; */
    }
    
    func trackingAreaDidMouseExited(with event: NSEvent) {
        /* Abstract; */
    }
    
    func trackingAreaDidLeftMouseDown(with event: NSEvent) {
        /* Abstract; */
    }
    
    func trackingAreaDidLeftMouseUp(with event: NSEvent) {
        /* Abstract; */
    }
    
    func trackingAreaDidRightMouseDown(with event: NSEvent) {
        /* Abstract; */
    }
    
    func trackingAreaDidRightMouseUp(with event: NSEvent) {
        /* Abstract; */
    }
    
    func viewControllerDidMouseEntered(with event: NSEvent) {
        /* Abstract; */
    }
    
    func viewControllerDidMouseExited(with event: NSEvent) {
        /* Abstract; */
    }
    
    // MARK: - Private
    
    private func updateTrackingAreaView() {
        trackingAreaView.frame = statusItem.button?.bounds ?? .zero
    }
    
    // MARK: - Deinit
    
    deinit {
        statusItem.removeFromStatusBar()
    }
}
