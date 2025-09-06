//
//  TokenResponseData.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 06/09/2025.
//
import Foundation

struct TokenResponseData: Codable {
    let accessToken: String
    let user: UserData
}
