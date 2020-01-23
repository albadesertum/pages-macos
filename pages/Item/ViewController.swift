//
//  ViewController.swift
//  pages
//
//  Created by Vladimir Psyukalov on 05.02.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    weak var item: Item?
    
    private var area: NSTrackingArea?
    
    // MARK: - Override
    
    override func viewDidLayout() {
        super.viewDidLayout()
        updateTrackingArea()
    }
    
    override func mouseEntered(with event: NSEvent) {
        item?.viewControllerDidMouseEntered(with: event)
    }
    
    override func mouseExited(with event: NSEvent) {
        item?.viewControllerDidMouseExited(with: event)
    }
    
    // MARK: - Abstract
    
    func popoverDidShow(animated: Bool) {
        /* Abstract; */
    }
    
    func popoverDidHide(animated: Bool) {
        /* Abstract; */
    }
    
    // MARK: - Private
    
    private func updateTrackingArea() {
        if let area = area {
            view.removeTrackingArea(area)
        }
        area = NSTrackingArea(rect: view.bounds, options: [.activeAlways, .mouseEnteredAndExited, .mouseMoved], owner: self, userInfo: nil)
        view.addTrackingArea(area!)
    }
}
