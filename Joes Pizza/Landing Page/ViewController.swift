import UIKit
import FirebaseAuth

class ViewController: UITabBarController, UITabBarControllerDelegate {

    let landingScreen = LandingPageView()

    override func loadView() {
        view = landingScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        
        landingScreen.joesImage.image = UIImage(named: "joes-pizza.png")
        landingScreen.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        landingScreen.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    @objc func login() {
       let loginVC = LoginScreenViewController()
       self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @objc func register() {
        let registerVC = RegisterScreenViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
