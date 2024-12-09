import UIKit
import FirebaseFirestore
import FirebaseAuth

class CheckoutScreenViewController: UIViewController {
    
    let checkoutScreen = CheckoutScreenView()
    let db = Firestore.firestore()

    override func loadView() {
        view = checkoutScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        checkoutScreen.plusButton.addTarget(self, action: #selector(selectDeliveryOrPickup), for: .touchUpInside)
        checkoutScreen.placeOrderButton.addTarget(self, action: #selector(handlePlaceOrder), for: .touchUpInside)
        
    }
    
    @objc func selectDeliveryOrPickup() {
        let addressVC = ConfirmAddressViewController()
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
    @objc func handlePlaceOrder() {
        let firstName = checkoutScreen.firstNameTextField.text ?? ""
        let lastName = checkoutScreen.lastNameTextField.text ?? ""
        let receiversName = firstName + " " + lastName
        let phoneNumber = checkoutScreen.mobileNumberTextField.text ?? ""
        
        guard let userId = Auth.auth().currentUser?.email else {
            print("User not logged in")
            return
        }
        
        db.collection("users").document(userId).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Data fetch failed", error)
                return
            }
            
            if let document = documentSnapshot, document.exists {
                if document.get("PhoneNumber") != nil {
                    self.db.collection("users").document(userId).updateData([
                        "ReceiversName": receiversName,
                        "PhoneNumber": phoneNumber
                    ]) { error in
                        if let error = error {
                            print("Update failed", error)
                        } else {
                            print("Update successful")
                        }
                    }
                } else {
                    self.db.collection("users").document(userId).setData([
                        "ReceiversName": receiversName,
                        "PhoneNumber": phoneNumber
                    ], merge: true) { error in
                        if let error = error {
                            print("Update failed", error)
                        } else {
                            print("Update successful")
                        }
                    }
                }
            }
        }
        
        createOrderAndClearCart()
        
    }
    
    func createOrderAndClearCart() {
       
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User not logged in")
            return
        }
        
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("Error: User not logged in")
            return
        }

        let cartRef = db.collection("carts").document(userEmail)
        cartRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching cart: \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot, document.exists,
                  let cartData = document.data(),
                  let items = cartData["items"] as? [[String: Any]] else {
                print("Cart is empty or unavailable.")
                return
            }

            let ordersRef = self.db.collection("orders")
            let orderId = ordersRef.document().documentID
            let orderData: [String: Any] = [
                "userId": userId,
                "userEmail": userEmail,
                "items": items,
                "totalAmount": cartData["totalAmount"] ?? 0,
                "createdAt": Timestamp(date: Date())
            ]

            ordersRef.document(orderId).setData(orderData) { error in
                if let error = error {
                    print("Error creating order: \(error.localizedDescription)")
                    return
                }

                cartRef.updateData(["items": FieldValue.delete(), "totalAmount": FieldValue.delete()]) { error in
                    if let error = error {
                        print("Error clearing cart: \(error.localizedDescription)")
                    } else {
                        print("Order placed successfully with ID: \(orderId) and cart cleared.")
                        NotificationCenter.default.post(name: NSNotification.Name("EditCartUpdated"), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
                        self.navigateToSuccessScreen()
                    }
                }
            }
        }

    }
    
    func navigateToSuccessScreen() {
        let successVC = SuccessScreenViewController()
        self.navigationController?.pushViewController(successVC, animated: true)
    }
        
}
