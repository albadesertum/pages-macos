//
//  Settings.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Foundation

class Settings: Codable {
    enum Keys: String, CodingKey {
        case isAutorun
    }
    
    var isAutorun: Bool
    
    init(isAutorun: Bool) {
        self.isAutorun = isAutorun
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.isAutorun = try container.decode(Bool.self, forKey: .isAutorun)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(isAutorun, forKey: .isAutorun)
    }
}
