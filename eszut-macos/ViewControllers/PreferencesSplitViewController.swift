//
//  PreferencesSplitViewController.swift
//  eszut-macos
//
//  Created by Jakub Olejnik on 08/09/2025.
//

import Foundation
import Cocoa

class PreferencesSplitViewController: NSSplitViewController {

    
    
    func showAccount() {
        guard splitViewItems.count > 1 else { return }
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let accountVC = storyboard.instantiateController(withIdentifier: "AccountView") as! NSViewController

        let oldItem = splitViewItems[1]
        removeSplitViewItem(oldItem)

        let newItem = NSSplitViewItem(viewController: accountVC)
        addSplitViewItem(newItem)
    }

        func showSettings() {
            guard splitViewItems.count > 1 else { return }
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            let settingsVC = storyboard.instantiateController(withIdentifier: "SettingsView") as! NSViewController
            let oldItem = splitViewItems[1]
            removeSplitViewItem(oldItem)

            let newItem = NSSplitViewItem(viewController: settingsVC)
            addSplitViewItem(newItem)
        }

}
