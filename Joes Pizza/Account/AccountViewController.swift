import UIKit
import FirebaseFirestore
import FirebaseAuth

class AccountViewController: UIViewController {

    let accountScreen = AccountScreenView()
    let db = Firestore.firestore()
    
    override func loadView() {
        view = accountScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchUserDetails()
        accountScreen.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc func logout() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: { _ in
            do {
                try Auth.auth().signOut()
                let loginViewController = ViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = navController
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            } catch {
                print("Error occurred: \(error.localizedDescription)")
            }
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(logoutAlert, animated: true)
    }
    
    func fetchUserDetails() {
        guard let userId = Auth.auth().currentUser?.email else {
            print("No user is logged in")
            return
        }
        
        let userRef = db.collection("users").document(userId)
        userRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user details: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data() else {
                print("User data does not exist.")
                return
            }
            
            let name = data["name"] as? String ?? "No name"
            let email = data["email"] as? String ?? "No email"
            let phoneNumber = data["PhoneNumber"] as? String ?? "No phone number"
            let address = data["Address"] as? String ?? "No address"
            
            DispatchQueue.main.async {
                self?.accountScreen.name.text = name
                self?.accountScreen.email.text = email
                self?.accountScreen.phoneNumber.text = phoneNumber
                self?.accountScreen.address.text = address
            }
        }
    }
}
