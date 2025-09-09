//
//  PreferencesMenuViewController.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 08/09/2025.
//

import Foundation
import Cocoa

class PreferencesMenuViewController: NSViewController {
    
    @IBAction func settingsClicked(_ sender: Any) {
        (parent as? PreferencesSplitViewController)?.showSettings()
    }
    @IBAction func accountClicked(_ sender: Any) {
        (parent as? PreferencesSplitViewController)?.showAccount()
    }
}
