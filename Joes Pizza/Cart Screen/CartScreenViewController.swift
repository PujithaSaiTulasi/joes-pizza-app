import UIKit
import FirebaseAuth
import FirebaseFirestore

class CartScreenViewController: UIViewController {

    var cartItems: [[String: Any]] = []
    let cartScreen = CartScreenView()
    let db = Firestore.firestore()
    
    override func loadView() {
        view = cartScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        title = "Your Cart"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ]
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        navigationItem.hidesBackButton = true
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(onCloseTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        cartScreen.orderDetailsTableView.delegate = self
        cartScreen.orderDetailsTableView.dataSource = self
        
        fetchCartItems()
        cartScreen.checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        updateCheckoutButtonTitle()
        NotificationCenter.default.addObserver(self, selector: #selector(editCartUpdated), name: NSNotification.Name("EditCartUpdated"), object: nil)
    }
    
    @objc func onCloseTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editCartUpdated() {
        fetchCartItems()
        updateCheckoutButtonTitle()
    }
    
    @objc func checkoutButtonTapped() {
        let checkoutVC = CheckoutScreenViewController()
        navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
    func updateCheckoutButtonTitle() {
        let totalAmount = cartItems.reduce(0.0) { $0 + ($1["totalPrice"] as? Double ?? 0.0) }
        if cartItems.isEmpty {
            cartScreen.emptyCartLabel.isHidden = false
            cartScreen.checkoutButton.setTitle("Checkout", for: .normal)
        } else {
            cartScreen.checkoutButton.setTitle("Checkout       $\(String(format: "%.2f", totalAmount))", for: .normal)
            cartScreen.emptyCartLabel.isHidden = true
        }
    }
    
    func fetchCartItems() {
        guard let userId = Auth.auth().currentUser?.email else {
            print("User not authenticated")
            return
        }
        
        let cartRef = db.collection("carts").document(userId)
        cartRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching cart document: \(error)")
                return
            }
            if let document = document, document.exists {
                if let items = document.data()?["items"] as? [[String: Any]] {
                    self?.cartItems = items
                    self?.cartScreen.orderDetailsTableView.reloadData()
                    self?.updateCheckoutButtonTitle()
                } else {
                    print("Items not found in the cart document.")
                }
            } else {
                print("Cart document does not exist.")
            }
        }
    }
    
    @objc func deleteItem(sender: UIButton) {
        let index = sender.tag
        cartItems.remove(at: index)
        let updatedTotalAmount = cartItems.reduce(0.0) { $0 + ($1["totalPrice"] as? Double ?? 0.0) }
        
        guard let userId = Auth.auth().currentUser?.email else {
            print("User not authenticated")
            return
        }
            
        let cartRef = db.collection("carts").document(userId)
        cartRef.updateData([
            "items": cartItems,
            "totalAmount": updatedTotalAmount
        ]) { error in
            if let error = error {
                print("Error updating cart: \(error)")
            } else {
                self.cartScreen.orderDetailsTableView.reloadData()
                self.updateCheckoutButtonTitle()
                NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
                print("Item successfully deleted and total amount updated")
            }
        }
    }

    @objc func editItem(sender: UIButton) {
        let index = sender.tag
        let cartItem = cartItems[index]
        if let menuItemId = cartItem["menuItemId"] as? Int {
            getMenuItemById(menuItemId: menuItemId) { menuItem in
                if let menuItem = menuItem {
                    let customizationVC = CustomizationScreenViewController()
                    customizationVC.menuItem = menuItem
                    customizationVC.existingcartItem = cartItem
                    customizationVC.index = index
                    customizationVC.isEditingItem = true
                    self.navigationController?.pushViewController(customizationVC, animated: true)
                } else {
                    print("Error: Menu item not found")
                }
            }
        }
    }

    func getMenuItemById(menuItemId: Int, completion: @escaping (MenuItem?) -> Void) {
        let menuCollectionRef = db.collection("menu")
        menuCollectionRef.whereField("id", isEqualTo: menuItemId).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let document = snapshot?.documents.first {
                let data = document.data()
                let menuItem = MenuItem(
                    id: data["id"] as? Int ?? 0,
                    name: data["name"] as? String ?? "",
                    basePrice: data["basePrice"] as? Double ?? 0.0,
                    category: data["category"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    availability: data["availability"] as? Bool ?? false,
                    image: data["image"] as? String ?? "",
                    pricePerTopping: data["pricePerTopping"] as? [Int],
                    maxToppings: data["maxToppings"] as? Int
                )
                completion(menuItem)
            } else {
                print("Menu item not found")
                completion(nil)
            }
        }
    }


}

extension CartScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? OrderDetailsTableView else {
            return UITableViewCell()
        }
        
        let item = cartItems[indexPath.row]
        
        let selectedToppings = item["selectedToppings"] as? [String] ?? []
        if selectedToppings.isEmpty {
            cell.addLabel.isHidden = true
        } else {
            cell.addLabel.isHidden = false
            cell.addLabel.text = "Add:\n\(selectedToppings.joined(separator: "\n"))"
        }
        
        let selectedCheeseSauce = item["selectedCheeseSauceOptions"] as? [String] ?? []
        let selectedPizzaOptions = item["selectedPizzaOptions"] as? [String] ?? []
        let specialInstructions = item["specialInstructions"] as? String ?? ""
        
        var allOptions = selectedCheeseSauce + selectedPizzaOptions
        if !specialInstructions.isEmpty {
            allOptions.append("\nSpecial Instructions: \(specialInstructions)")
        }
        
        if allOptions.isEmpty {
            cell.pleaseServeLabel.isHidden = true
        } else {
            cell.pleaseServeLabel.isHidden = false
            cell.pleaseServeLabel.text = "Please Serve:\n\(allOptions.joined(separator: "\n"))"
        }
        
        cell.itemName.text = "\(item["name"] as? String ?? "")"
        let price = item["totalPrice"] as? Double ?? 0.0
        cell.itemPrice.text = String(format: "$%.2f", price)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editItem), for: .touchUpInside)
        
        return cell
    }

}
