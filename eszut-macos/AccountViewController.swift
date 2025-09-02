import Cocoa


class AccountViewController: NSViewController {
    
    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var emailLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.stringValue = AppState.shared.username ?? "Brak nazwy użytkownika"
        emailLabel.stringValue = AppState.shared.userEmail ?? "Brak adresu e-mail"
    }
}
