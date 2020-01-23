//
//  Copyable.swift
//  pages
//
//  Created by Vladimir Psyukalov on 28.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Foundation

protocol Copyable {
    init(origin: Self)
}

extension Copyable {
    func copy() -> Self {
        return Self.init(origin: self)
    }
}
