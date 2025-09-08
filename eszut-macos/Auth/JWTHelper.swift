//
//  JWTHelper.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 06/09/2025.
//

import Foundation
import JWTDecode

enum JWTHelperError: Error {
    case missingClaim(String)
}

class JWTHelper {
    static let shared = JWTHelper()
    
    func decodeAccessToken(_ token: String) throws -> UserData {
        let jwt = try decode(jwt: token)
        
        let userId = jwt.claim(name: "userId").string ?? ""
        let username = jwt.claim(name: "username").string ?? ""
        let email = jwt.claim(name: "email").string ?? ""
        let role = jwt.claim(name: "role").integer ?? -1
        
        if userId.isEmpty { throw JWTHelperError.missingClaim("userId") }
        if username.isEmpty { throw JWTHelperError.missingClaim("username") }
        if email.isEmpty { throw JWTHelperError.missingClaim("email") }
        
        if role == -1 {
            throw JWTHelperError.missingClaim("role")
        }
        return UserData(userId: userId, username: username, email: email, role: role)
        
    }
}

