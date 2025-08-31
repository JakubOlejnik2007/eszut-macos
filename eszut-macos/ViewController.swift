import Cocoa
import MSAL

class ViewController: NSViewController {

    let kClientID = "e4c482a1-9923-4462-bf05-b70d64942c19"
    let kRedirectUri = "msauth.jo.eszut-macos://auth"
    let kAuthority = "https://login.microsoftonline.com/84867874-5f7d-4b12-b070-d6cea5a3265e"
    let kGraphEndpoint = "https://graph.microsoft.com/"
    let kScopes = ["User.Read"]

    var applicationContext: MSALPublicClientApplication!
    var webViewParams: MSALWebviewParameters!

    @IBOutlet weak var loginButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initMSAL()
    }

    @IBAction func loginButtonClicked(_ sender: NSButton) {
        acquireToken()
    }

    func initMSAL() {
        guard let authorityURL = URL(string: kAuthority) else { return }
        do {
            let authority = try MSALAADAuthority(url: authorityURL)
            let config = MSALPublicClientApplicationConfig(clientId: kClientID,
                                                           redirectUri: kRedirectUri,
                                                           authority: authority)
            applicationContext = try MSALPublicClientApplication(configuration: config)
            webViewParams = MSALWebviewParameters(authPresentationViewController: self)
        } catch {
            print("MSAL init error: \(error)")
        }
    }

    func acquireToken() {
        let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webViewParams)
        applicationContext.acquireToken(with: parameters) { result, error in
            if let error = error {
                print("Token error: \(error)")
                return
            }
            guard let result = result else { return }
            print("Access token: \(result.accessToken)")
            print("Account: \(result.account.username ?? "")")
        }
    }
}
