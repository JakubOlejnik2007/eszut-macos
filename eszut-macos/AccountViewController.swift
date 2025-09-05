import Cocoa


class AccountViewController: NSViewController {
    
    var loginViewController: NSWindowController?
    
    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var emailLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.stringValue = AppState.shared.username ?? "Brak nazwy użytkownika"
        emailLabel.stringValue = AppState.shared.userEmail ?? "Brak adresu e-mail"
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        AppState.shared.logout()
        
        if !AppState.shared.isLoginWindowOpen {
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
                AppState.shared.isLoginWindowOpen = true
            }
        }
        
        self.view.window?.close()
    }
}
