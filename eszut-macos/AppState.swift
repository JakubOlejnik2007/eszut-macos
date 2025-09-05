//
//  AppState.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 02/09/2025.
//

import Foundation

class AppState {
    static let shared = AppState()
    
    private init(){
    }
    
    var username: String?
    var userEmail: String?
    
    var isUserLogged: Bool = false
    var isLoginWindowOpen: Bool = false
    
    
    func logout() {
        username = nil
        userEmail = nil
        isUserLogged = false
    }
}
