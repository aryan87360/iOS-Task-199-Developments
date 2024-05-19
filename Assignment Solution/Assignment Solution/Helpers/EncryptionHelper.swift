//
//  EncryptionHelper.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import Foundation
import CryptoKit

struct EncryptionHelper {
    private static var key: SymmetricKey {
        if let savedKey = KeychainHelper.loadKey() {
            return savedKey
        } else {
            return KeychainHelper.generateKey()
        }
    }
    
    static func encrypt(_ string: String) -> Data? {
        let data = Data(string.utf8)
        if let sealedBox = try? AES.GCM.seal(data, using: key) {
            return sealedBox.combined
        }
        return nil
    }
    
    static func decrypt(_ data: Data) -> String? {
        if let sealedBox = try? AES.GCM.SealedBox(combined: data),
           let decryptedData = try? AES.GCM.open(sealedBox, using: key) {
            return String(data: decryptedData, encoding: .utf8)
        }
        return nil
    }
}
