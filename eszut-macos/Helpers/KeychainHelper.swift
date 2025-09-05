//
//  KeychainHelper.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 05/09/2025.
//


import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    func saveToken(_ token: String, account: String, expirationDays: Int = 30) -> Bool {
        guard let data = token.data(using: .utf8) else { return false }

        let expirationDate = Date().addingTimeInterval(TimeInterval(expirationDays * 24 * 60 * 60))
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrDescription as String: "Expires at \(expirationDate)"
        ]
        
        SecItemDelete(attributes as CFDictionary) // nadpisanie jeśli istnieje
        let status = SecItemAdd(attributes as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func getToken(account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        }
        return nil
    }
    
    func deleteToken(account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
