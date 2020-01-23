//
//  SettingsViewController.swift
//  pages
//
//  Created by Vladimir Psyukalov on 12.02.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class SettingsViewController: ViewController, MainServiceProtocol {
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var autorunButton: NSButton!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePage(_:)), name: .didChangePage, object: nil)
        localize()
        applyIsAutorun()
    }
    
    // MARK: - Private
    
    private func localize() {
        autorunButton.title = "l_autorun".localized
        var i = 0
        for title in ["l_name", "l_url", "l_width", "l_height", "l_is_fixated", "l_countdown"] {
            tableView.tableColumns[i].title = title.localized
            i = i + 1
        }
    }
    
    private func applyIsAutorun() {
        autorunButton.state = settings.isAutorun ? .on : .off
    }
    
    private func page(for row: Int) -> Page? {
        if pages.count > row && row > -1 {
            return pages.reversed()[row]
        }
        return nil
    }
    
    private func number(of tableColumn: NSTableColumn?) -> Int? {
        if let tableColumn = tableColumn {
            return tableView.tableColumns.firstIndex(of: tableColumn)
        }
        return nil
    }
    
    // MARK: - Action
    
    @IBAction func terminateAppButtonAction(_ sender: NSButton) {
        NSApp.terminate(nil)
    }
    
    @IBAction func helpButtonAction(_ sender: NSButton) {
        NSAlert.info().runModal()
    }
    
    @IBAction func appendButtonAction(_ sender: Any) {
        pagesService.appendEmpty()
        pagesService.save()
        tableView.reloadData()
    }
    
    @IBAction func deleteButtonAction(_ sender: NSButton) {
        if let page = page(for: tableView.selectedRow) {
            pagesService.remove(page)
        } else {
            pagesService.removeLast()
        }
        pagesService.save()
        tableView.reloadData()
    }
    
    @IBAction func autorunButton(_ sender: NSButton) {
        settings.isAutorun = !settings.isAutorun
        settingsService.save()
        applyIsAutorun()
    }
    
    @objc private func didChangePage(_ sender: AnyObject?) {
        tableView.reloadData()
    }
}

extension SettingsViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        guard let page = page(for: row), let number = number(of: tableColumn) else {
            return nil
        }
        switch number {
        case 0:
            return page.name
        case 1:
            return page.url
        case 2:
            return page.width
        case 3:
            return page.height
        case 4:
            return page.isFixated
        case 5:
            return page.countdown
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        guard let page = page(for: row), let number = number(of: tableColumn) else {
            return
        }
        var key: String?
        switch number {
        case 0:
            page.name = object as? String ?? page.name
            key = "name"
        case 1:
            page.url = object as? String ?? page.url
            key = "url"
        case 2:
            let value = Int(object as? String ?? "") ?? -1
            page.width = value > -1 ? value : page.width
            key = "size"
        case 3:
            let value = Int(object as? String ?? "") ?? -1
            page.height = value > -1 ? value : page.height
            key = "size"
        case 4:
            page.isFixated = object as? Bool ?? page.isFixated
            key = "isFixated"
        case 5:
            let value = Int(object as? String ?? "") ?? -1
            page.countdown = value > -1 ? value : page.countdown
            key = "countdown"
        default:
            break
        }
        pagesService.save()
        let userInfo = key == nil ? nil : ["key" : key!]
        NotificationCenter.default.post(name: .didChangePage, object: page, userInfo: userInfo)
    }
}
