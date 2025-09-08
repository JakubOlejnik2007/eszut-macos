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
        NotificationCenter.default.addObserver(self, selector: #selector(logout(_:)), name: .userDidLogout, object: nil)
    }
    
    var userData: UserData?
    
    var isLoginWindowOpen: Bool = false
    
    
    @objc func logout(_ notification: Notification) {
        userData = nil
    }
}
