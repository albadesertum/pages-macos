//
//  MainService.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let didChangePage = Notification.Name(rawValue: "didChangePage")
}

protocol MainServiceProtocol {
    var pagesService: PagesService { get }
    
    var settingsService: SettingsService { get }
    
    var pages: [Page] { get }
    
    var settings: Settings { get }
}

extension MainServiceProtocol {
    var pagesService: PagesService {
        return MainService.shared.pagesService
    }
    
    var settingsService: SettingsService {
        return MainService.shared.settingsService
    }
    
    var pages: [Page] {
        return pagesService.pages
    }
    
    var settings: Settings {
        return settingsService.settings
    }
}

class MainService {
    static let shared = MainService()
    
    let pagesService: PagesService
    
    let settingsService: SettingsService
    
    let settingsItem: SettingsItem
    
    init() {
        self.pagesService = PagesService()
        self.settingsService = SettingsService()
        self.settingsItem = SettingsItem()
    }
    
    // MARK: - Public
    
    func setup() {
        pagesService.load()
        settingsService.load()
    }
}
