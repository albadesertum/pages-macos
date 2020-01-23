//
//  Page.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa

class Page: Codable {
    enum Keys: String, CodingKey {
        case id, url, name
        case isFixated
        case countdown, width, height
    }
    
    var id: String
    var url: String
    var name: String
    
    var isFixated: Bool
    
    var countdown: Int
    var width: Int
    var height: Int
        
    private lazy var pageItem: PageItem = {
        return PageItem(page: self)
    }()
    
    init(id: String, url: String, name: String, isFixated: Bool, countdown: Int, width: Int, height: Int) {
        self.id = id
        self.url = url
        self.name = name
        self.isFixated = isFixated
        self.countdown = countdown
        self.width = width
        self.height = height
        _ = self.pageItem
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
        self.name = try container.decode(String.self, forKey: .name)
        self.isFixated = try container.decode(Bool.self, forKey: .isFixated)
        self.countdown = try container.decode(Int.self, forKey: .countdown)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        _ = self.pageItem
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(name, forKey: .name)
        try container.encode(isFixated, forKey: .isFixated)
        try container.encode(countdown, forKey: .countdown)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
}

extension Page: Equatable {
    static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.id == rhs.id
    }
}
