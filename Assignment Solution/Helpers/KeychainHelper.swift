//
//  KeychainHelper.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import Security
import CryptoKit
import SwiftUI

struct KeychainHelper {
    static let keyTag = "com.yourapp.encryptionKey"

    static func saveKey(_ key: SymmetricKey) {
        let keyData = key.withUnsafeBytes { Data(Array($0)) }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyTag,
            kSecValueData as String: keyData
        ]

        SecItemDelete(query as CFDictionary) // Delete any existing item
        let status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
    }

    static func loadKey() -> SymmetricKey? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyTag,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let keyData = item as? Data else {
            return nil
        }

        return SymmetricKey(data: keyData)
    }

    static func generateKey() -> SymmetricKey {
        let key = SymmetricKey(size: .bits256)
        saveKey(key)
        return key
    }
}
