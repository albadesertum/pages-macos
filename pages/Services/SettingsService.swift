//
//  SettingsService.swift
//  pages
//
//  Created by Vladimir Psyukalov on 23.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Foundation
import ServiceManagement

class SettingsService {
    static let countdown = Bundle.main.object(forInfoDictionaryKey: "Countdown") as? Int ?? 0
    static let height = Bundle.main.object(forInfoDictionaryKey: "Height") as? CGFloat ?? 0.0
    
    var settings: Settings
    
    init() {
        self.settings = SettingsService.createDefautltsSettings()
    }
    
    func load() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "settings") {
            if let settings = try? JSONDecoder().decode(Settings.self, from: data) {
                self.settings = settings
            }
        }
        applyAutorun()
    }
    
    func save() {
        let data = try? JSONEncoder().encode(settings)
        if let data = data {
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "settings")
            userDefaults.synchronize()
        }
        applyAutorun()
    }
    
    func reset() {
        settings = SettingsService.createDefautltsSettings()
    }
    
    // MARK: - Private
    
    private func applyAutorun() {
        SMLoginItemSetEnabled(Identifiers.autorun as CFString, settings.isAutorun)
    }
    
    // MARK: - Static
    
    static func createDefautltsSettings() -> Settings {
        let dictionary = Bundle.main.object(forInfoDictionaryKey: "DefaultSettings") as? [String : AnyObject?]
        let isAutorun = dictionary?["IsAutorun"] as? Bool ?? false
        return Settings(isAutorun: isAutorun)
    }
}
