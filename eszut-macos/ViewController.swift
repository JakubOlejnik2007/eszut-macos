import Cocoa
import MSAL


struct UserData: Codable {
    let userId: String
    let username: String
    let email: String
    let role: Int
}

struct TokenResponseData: Codable {
    let accessToken: String
    let user: UserData
}

class ViewController: NSViewController {

    let kClientID = "e4c482a1-9923-4462-bf05-b70d64942c19"
    let kRedirectUri = "msauth.jo.eszut-macos://auth"
    let kAuthority = "https://login.microsoftonline.com/84867874-5f7d-4b12-b070-d6cea5a3265e"
    let kGraphEndpoint = "https://graph.microsoft.com/"
    let kScopes = ["api://e4c482a1-9923-4462-bf05-b70d64942c19/App"]

    var applicationContext: MSALPublicClientApplication!
    var webViewParams: MSALWebviewParameters!
    var mainWindowController: NSWindowController?
    
    @IBOutlet weak var loginButton: NSButton!

    @IBOutlet weak var accountLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initMSAL()
    }

    //Configure the touchbar
    @IBOutlet var myTouchBar: NSTouchBar!
    override func makeTouchBar() -> NSTouchBar? {
        return myTouchBar
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.makeFirstResponder(self)
    }
    //touchbar configured.
    @IBAction func TouchLoginButtonTouched(_ sender: Any) {
        acquireToken()
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

    func getAPITokens(MSAL_TOKEN: String) {
        var components = URLComponents(string: "https://eszut-api.tenco.waw.pl/set-tokens")!
        
        components.queryItems = [
            URLQueryItem(name: "MSAL_TOKEN", value: MSAL_TOKEN)
        ]
        
        let url = components.url!
        
        print(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print("Błąd:", error)
                return
            }
            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("Response:", body)
                do {
                    let parsedData = try JSONDecoder().decode(TokenResponseData.self, from: data)
                    DispatchQueue.main.async {
                        AppState.shared.userEmail = parsedData.user.email
                        AppState.shared.username = parsedData.user.username
                    }
                } catch {
                    print("Decode error:", error)
                }
            }
        }
        
        task.resume()
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
            self.accountLabel.stringValue = result.account.username ?? ""
            
            self.getAPITokens(MSAL_TOKEN: result.accessToken)
            
            DispatchQueue.main.async {
                if self.mainWindowController == nil {
                    let storyboard = NSStoryboard(name: "Main", bundle: nil)
                    self.mainWindowController = storyboard.instantiateController(withIdentifier: "MainWindow") as? NSWindowController
                }
                self.mainWindowController?.showWindow(self)
                self.mainWindowController?.window?.makeKeyAndOrderFront(self)
            }
            self.view.window?.close()
        }
        
        
    }
}
