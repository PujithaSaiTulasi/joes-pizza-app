import UIKit
import FirebaseAuth

class LoginScreenViewController: UITabBarController, UITabBarControllerDelegate {

    let loginScreen = LoginScreenView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.navigateToPlaceOrderScreen()
            } else {
                self.loginScreen.joesLogo.image = UIImage(named: "joes-logo.png")
                
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnTap))
                tapRecognizer.cancelsTouchesInView = false
                self.view.addGestureRecognizer(tapRecognizer)
                
                self.loginScreen.buttonRegister.addTarget(self, action: #selector(self.onButtonRegisterTapped), for: .touchUpInside)
                self.loginScreen.buttonLogin.addTarget(self, action: #selector(self.onButtonLoginTapped), for: .touchUpInside)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func onButtonRegisterTapped() {
        let registerScreenController = RegisterScreenViewController()
        navigationController?.pushViewController(registerScreenController, animated: true)
    }
    
    @objc func onButtonLoginTapped() {
        
        guard let email = loginScreen.textFieldEmail.text, !email.isEmpty,
            let password = loginScreen.textFieldPassword.text, !password.isEmpty else {
            showAlert("Missing Fields","Please enter both email and password.")
            return
        }
        
        if !isValidEmail(email) {
           showAlert("Invalid Email", "Please enter a valid email address.")
           return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert("Login failed", "\(error.localizedDescription)")
            } else {
                self.navigateToPlaceOrderScreen()
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToPlaceOrderScreen() {
        let tabBarVC = TabBarController()
        let navigationController = UINavigationController(rootViewController: tabBarVC)
                
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            guard let window = scene.windows.first else { return }
            window.rootViewController = navigationController
            
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }

}
