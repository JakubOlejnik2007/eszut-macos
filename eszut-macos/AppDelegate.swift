//
//  AppDelegate.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 31/08/2025.
//

import Cocoa
import MSAL

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let token = KeychainHelper.shared.getToken(account: "eszut-macos") ?? ""
        do {
            let userdata = try JWTHelper.shared.decodeAccessToken(token)
            
            AppState.shared.userData = userdata
            
            NotificationCenter.default.post(name: .userHadToken, object: nil)
        }
        catch {
            print("Error during decoding!")
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

