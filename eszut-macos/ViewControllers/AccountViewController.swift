import Cocoa


class AccountViewController: NSViewController {
    
    var loginViewController: NSWindowController?
    
    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var emailLabel: NSTextField!
    
    @IBOutlet weak var logoutButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.stringValue = AppState.shared.userData?.username ?? "Brak nazwy użytkownika"
        emailLabel.stringValue = AppState.shared.userData?.email ?? "Brak adresu e-mail"
        
        logoutButton.isEnabled = AppState.shared.userData != nil
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .userDidLogout, object: nil)
        
        DispatchQueue.main.async {
            if self.loginViewController == nil {
                let storyboard = NSStoryboard(name: "Main", bundle: nil)
                self.loginViewController = storyboard.instantiateController(withIdentifier: "LoginWindow") as? NSWindowController
            }
            if let window = self.loginViewController?.window {
                if window.isVisible {
                    window.makeKeyAndOrderFront(self)
                } else {
                    self.loginViewController?.showWindow(self)
                }
            }
            
        }
        
        self.view.window?.close()
    }
}
