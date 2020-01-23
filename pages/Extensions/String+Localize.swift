//
//  String+Localize.swift
//  String+Localize
//
//  Created by Vladimir Psyukalov on 11.12.2019.
//  Copyright © 2019 ZUZEX LLC. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }    
}
