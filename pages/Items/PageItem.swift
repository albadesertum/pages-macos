//
//  PageItem.swift
//  pages
//
//  Created by Vladimir Psyukalov on 27.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class PageItem: HighlightedItem, MainServiceProtocol {
    weak var page: Page?
    
    private var isFixated: Bool {
        get {
            return page?.isFixated ?? false
        }
        set {
            page?.isFixated = newValue
        }
    }
    
    init(page: Page?) {
        self.page = page
    }
    
    // MARK: - Preferred
    
    override func preferredViewController() -> ViewController {
        return PageViewController()
    }
    
    override func preferredIsFixated() -> Bool {
        return isFixated
    }
    
    override func preferredCountdown() -> Int {
        return page?.countdown ?? super.preferredCountdown()
    }
    
    // MARK: - Override
    
    override func setup() {
        super.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePage(_:)), name: .didChangePage, object: page)
        statusItem.button?.imagePosition = .imageLeft
        applyPage()
        showIfNeeded()
    }
    
    override func trackingAreaDidLeftMouseUp(with event: NSEvent) {
        super.trackingAreaDidLeftMouseUp(with: event)
        isFixated = !isFixated
        pagesService.save()
        applyImage()
        NotificationCenter.default.post(name: .didChangePage, object: nil)
    }
    
    // MARK: - Private
    
    private func applyPage() {
        applyTitle()
        applyImage()
        applyCountdown()
        applyUrl()
        applySize()
    }
    
    private func applyTitle() {
        title = page?.name
    }
    
    private func applyImage() {
        image = NSImage(named: (isFixated ? "true" : "false") + "_is_fixated_icon")
    }
    
    private func applyUrl() {
        (viewController as? PageViewController)?.load(url: page?.url)
    }
    
    private func applyCountdown() {
        if isTask {
            cancelHideTask()
            executeHideTask(preferredCountdown(), animated: false)
        }
    }
    
    private func applySize() {
        if let page = page {
            viewController.preferredContentSize = NSSize(width: page.width, height: page.height)
        }
    }
    
    private func showIfNeeded() {
        if isFixated {
            show()
        } else {
            hide()
        }
    }
    
    // MARK: - Action
    
    @objc private func didChangePage(_ notification: Notification) {
        guard let key = notification.userInfo?["key"] as? String else {
            return
        }
        switch key {
        case "name":
            applyTitle()
        case "url":
            applyUrl()
        case "isFixated":
            applyImage()
            showIfNeeded()
        case "countdown":
            if !isFixated {
                applyCountdown()
            }
        case "size":
            applySize()
        default:
            break
        }
    }
}
