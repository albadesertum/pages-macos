//
//  PagesService.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Foundation

class PagesService {
    var pages: [Page]
    
    init() {
        self.pages = []
    }
    
    func load() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "pages") {
            if let pages = try? JSONDecoder().decode([Page].self, from: data) {
                self.pages = pages
            }
        }
    }
    
    func save() {
        let data = try? JSONEncoder().encode(pages)
        if let data = data {
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "pages")
            userDefaults.synchronize()
        }
    }
    
    func appendEmpty() {
        append(PagesService.createEmptyPage())
    }
    
    func append(_ page: Page?) {
        if let page = page {
            pages.append(page)
        }
    }
    
    func removeLast() {
        remove(pages.last)
    }
    
    func remove(_ page: Page?) {
        if let page = page, let index = pages.firstIndex(of: page) {
            remove(at: index)
        }
    }
    
    func remove(at index: Int) {
        if pages.count > index && index > -1 {
            pages.remove(at: index)
        }
    }
    
    func removeAll() {
        pages = []
    }
    
    // MARK: - Static
    
    static func createEmptyPage() -> Page {
        let dictionary = Bundle.main.object(forInfoDictionaryKey: "EmptyPage") as? [String : AnyObject?]
        let url = dictionary?["Url"] as? String ?? ""
        let isFixated = dictionary?["IsFixated"] as? Bool ?? false
        let countdown = dictionary?["Countdown"] as? Int ?? 0
        let width = dictionary?["Width"] as? Int ?? 0
        let height = dictionary?["Height"] as? Int ?? 0
        return Page(id: NSUUID().uuidString, url: url, name: "l_empty".localized, isFixated: isFixated, countdown: countdown, width: width, height: height)
    }
}
