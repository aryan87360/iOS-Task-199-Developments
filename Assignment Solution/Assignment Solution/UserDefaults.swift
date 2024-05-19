//
//  UserDefaults.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case savedUser
        case notes
    }
    
    var savedUser: User? {
        get {
            if let data = data(forKey: UserDefaultsKeys.savedUser.rawValue) {
                return try? JSONDecoder().decode(User.self, from: data)
            }
            return nil
        }
        set {
            if let newValue = newValue {
                if let data = try? JSONEncoder().encode(newValue) {
                    set(data, forKey: UserDefaultsKeys.savedUser.rawValue)
                }
            } else {
                removeObject(forKey: UserDefaultsKeys.savedUser.rawValue)
            }
        }
    }
    
    func notes(for user: User) -> [Note] {
        if let data = data(forKey: "\(UserDefaultsKeys.notes.rawValue)_\(user.email)"),
           let notes = try? JSONDecoder().decode([Note].self, from: data) {
            return notes
        }
        return []
    }
    
    func save(notes: [Note], for user: User) {
        if let data = try? JSONEncoder().encode(notes) {
            set(data, forKey: "\(UserDefaultsKeys.notes.rawValue)_\(user.email)")
        }
    }
}
