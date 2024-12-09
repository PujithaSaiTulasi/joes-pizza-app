import UIKit
import FirebaseAuth
import FirebaseFirestore

class CustomizationScreenViewController: UIViewController {

    let db = Firestore.firestore()
    var menuItem: MenuItem?
    var index: Int?
    var existingcartItem: [String: Any]?
    var isEditingItem: Bool = false
    var selectedToppingsIndices: Set<Int> = []
    var selectedPizzaOptionsIndices: Set<Int> = []
    var selectedCheeseSauceIndices: Set<Int> = []
    var itemQuantity: Int = 1
    
    let toppings = ["Pepperoni", "Sausage", "Meatball", "Anchovy", "Artichoke", "Basil", "Broccoli", "Garlic", "Green Peppers", "Mushrooms", "Olives (Black)", "Red Onion", "Spinach w/Garlic", "Tomato"]
    let cheeseOrSauce: [[String: Any]] = [
        ["name": "Extra Cheese", "price": 4],
        ["name": "Add Fresh Mozz", "price": 5],
        ["name": "Add Ricotta", "price": 4],
        ["name": "Extra Sauce", "price": 1]
    ]
    let pizzaOptions = ["Well Done", "Light Sauce" , "Light Cheese", "No Cheese", "Clean Clutter"]
    
    let pizzaCustomizationScreen = PizzaCustomizationScreenView()
    let drinkCustomizationScreen = DrinkCustomizationScreenView()
    let saladCustomizationScreen = SaladCustomizationScreenView()

    override func loadView() {
        super.loadView()
        
        if menuItem?.category == "Pizza" {
            view = pizzaCustomizationScreen
        }else if menuItem?.category == "Drinks" {
            view = drinkCustomizationScreen
        }else if menuItem?.category == "Salads" {
            view = saladCustomizationScreen
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Customize"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ]
        
        navigationItem.hidesBackButton = true
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(onCloseTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        pizzaCustomizationScreen.toppingsTableView.separatorStyle = .none
        pizzaCustomizationScreen.pizzaOptionsTableView.separatorStyle = .none
        pizzaCustomizationScreen.cheeseSauceOptionsTableView.separatorStyle = .none
        pizzaCustomizationScreen.toppingsTableView.delegate = self
        pizzaCustomizationScreen.toppingsTableView.dataSource = self
        pizzaCustomizationScreen.pizzaOptionsTableView.delegate = self
        pizzaCustomizationScreen.pizzaOptionsTableView.dataSource = self
        pizzaCustomizationScreen.cheeseSauceOptionsTableView.delegate = self
        pizzaCustomizationScreen.cheeseSauceOptionsTableView.dataSource = self
        pizzaCustomizationScreen.specialInstructionsTextView.delegate = self
        
        pizzaCustomizationScreen.minusButton.addTarget(self, action: #selector(handleMinusButtonTapped), for: .touchUpInside)
        pizzaCustomizationScreen.plusButton.addTarget(self, action: #selector(handlePlusButtonTapped), for: .touchUpInside)
        pizzaCustomizationScreen.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        loadItemDetails()
    }
    
    func loadItemDetails() {
        pizzaCustomizationScreen.itemImage.image = UIImage(named: menuItem?.image ?? "")
        pizzaCustomizationScreen.itemName.text = menuItem?.name
        pizzaCustomizationScreen.itemDescription.text = menuItem?.description
        pizzaCustomizationScreen.itemPrice.text = String(format: "$%.2f", menuItem?.basePrice ?? 0.00)
        pizzaCustomizationScreen.maxChoiceLabel.text = "Please select upto \(menuItem?.maxToppings ?? 0) toppings"
        
        saladCustomizationScreen.itemImage.image = UIImage(named: menuItem?.image ?? "")
        saladCustomizationScreen.itemName.text = menuItem?.name
        saladCustomizationScreen.itemDescription.text = menuItem?.description
        saladCustomizationScreen.itemPrice.text = String(format: "$%.2f", menuItem?.basePrice ?? 0.00)
        
        drinkCustomizationScreen.itemImage.image = UIImage(named: menuItem?.image ?? "")
        drinkCustomizationScreen.itemName.text = menuItem?.name
        drinkCustomizationScreen.itemDescription.text = menuItem?.description
        drinkCustomizationScreen.itemPrice.text = String(format: "$%.2f", menuItem?.basePrice ?? 0.00)
        
        if isEditingItem, let existingcartItem = existingcartItem {
            itemQuantity = existingcartItem["quantity"] as? Int ?? 1
            selectedToppingsIndices = Set((existingcartItem["selectedToppings"] as? [String] ?? []).compactMap { toppings.firstIndex(of: $0) })
            selectedPizzaOptionsIndices = Set((existingcartItem["selectedPizzaOptions"] as? [String] ?? []).compactMap { pizzaOptions.firstIndex(of: $0) })
            selectedCheeseSauceIndices = Set((existingcartItem["selectedCheeseSauceOptions"] as? [String] ?? []).compactMap { optionName in
                cheeseOrSauce.firstIndex { $0["name"] as? String == optionName }
            })
            pizzaCustomizationScreen.specialInstructionsTextView.text = existingcartItem["specialInstructions"] as? String ?? ""
        }
        
        pizzaCustomizationScreen.itemCount.text = "\(itemQuantity)"
        updateAddToCartButtonTitle()
    }
    
    @objc func onCloseTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleMinusButtonTapped() {
        if itemQuantity > 1 {
            itemQuantity -= 1
        }
        pizzaCustomizationScreen.itemCount.text = "\(itemQuantity)"
        updateAddToCartButtonTitle()
    }

    @objc func handlePlusButtonTapped() {
        itemQuantity += 1
        pizzaCustomizationScreen.itemCount.text = "\(itemQuantity)"
        updateAddToCartButtonTitle()
    }

    @objc func addToCart() {
        guard let menuItem = menuItem else { return }
        
        let selectedToppings = selectedToppingsIndices.map { toppings[$0] }
        let selectedPizzaOptions = selectedPizzaOptionsIndices.map { pizzaOptions[$0] }
        let selectedCheeseSauceOptions = selectedCheeseSauceIndices.map { cheeseOrSauce[$0]["name"] as? String ?? "" }
        let specialInstructions = pizzaCustomizationScreen.specialInstructionsTextView.text ?? ""
        
        let cartItem: [String: Any] = [
            "menuItemId": menuItem.id ?? "",
            "name": menuItem.name ?? "",
            "category": menuItem.category ?? "",
            "quantity": itemQuantity,
            "selectedToppings": selectedToppings,
            "selectedPizzaOptions": selectedPizzaOptions,
            "selectedCheeseSauceOptions": selectedCheeseSauceOptions,
            "specialInstructions": specialInstructions,
            "totalPrice": calculateTotalPrice()
        ]
        
        guard let userId = Auth.auth().currentUser?.email else {
            print("User not authenticated")
            return
        }
        
        let cartRef = db.collection("carts").document(userId)
        cartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var existingItems = document.data()?["items"] as? [[String: Any]] ?? []
                var existingTotalAmount = document.data()?["totalAmount"] as? Double ?? 0.0

                if self.isEditingItem, let existingIndex = self.index {
                    if let previousPrice = existingItems[existingIndex]["totalPrice"] as? Double {
                        existingTotalAmount -= previousPrice
                    }
                    existingItems[existingIndex] = cartItem
                    
                } else {
                    existingItems.append(cartItem)
                }
               
                if let cartTotalPrice = cartItem["totalPrice"] as? Double {
                    existingTotalAmount += cartTotalPrice
                }
                cartRef.updateData([
                    "items": existingItems,
                    "totalAmount": existingTotalAmount
                ]) { error in
                    if let error = error {
                        print("Error updating cart: \(error)")
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name("EditCartUpdated"), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                let newCartData: [String: Any] = [
                    "items": [cartItem],
                    "totalAmount": cartItem["totalPrice"] as! Double
                ]
                cartRef.setData(newCartData) { error in
                    if let error = error {
                        print("Error creating cart: \(error)")
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name("CartUpdated"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func calculateTotalPrice() -> Double {
        let basePrice = menuItem?.basePrice ?? 0.00
        let toppingPrices = menuItem?.pricePerTopping ?? []
        let sortedToppingPrices = toppingPrices.sorted(by: >)
        let selectedToppingCount = selectedToppingsIndices.count
        let toppingPriceSum = sortedToppingPrices.prefix(selectedToppingCount).reduce(0) { $0 + Double($1)}
        
        let cheeseSaucePriceSum = selectedCheeseSauceIndices.reduce(0) { partialSum, index in
            let price = cheeseOrSauce[index]["price"] as? Int ?? 0
            return partialSum + Double(price)
        }
        let totalPrice = (basePrice + toppingPriceSum + cheeseSaucePriceSum) * Double(itemQuantity)
        return totalPrice
    }

    func updateAddToCartButtonTitle() {
        let totalPrice = calculateTotalPrice()
        var buttonTitle = ""
        if isEditingItem{
            buttonTitle = String(format: "Update Cart          $%.2f", totalPrice)
        }else{
            buttonTitle = String(format: "Add to Cart          $%.2f", totalPrice)
        }
        pizzaCustomizationScreen.addToCartButton.setTitle(buttonTitle, for: .normal)
    }

    @objc func handleCheckboxToggle(_ sender: UIButton) {
       let index = sender.tag

       if selectedToppingsIndices.contains(index) {
           selectedToppingsIndices.remove(index)
       } else if selectedToppingsIndices.count < (menuItem?.maxToppings ?? 0) {
           selectedToppingsIndices.insert(index)
       }
        
        pizzaCustomizationScreen.toppingsTableView.reloadData()
       updateAddToCartButtonTitle()
    }
    
    @objc func handlePizzaOptionToggle(_ sender: UIButton) {
        let index = sender.tag

        if selectedPizzaOptionsIndices.contains(index) {
            selectedPizzaOptionsIndices.remove(index)
        } else {
            selectedPizzaOptionsIndices.insert(index)
        }

        pizzaCustomizationScreen.pizzaOptionsTableView.reloadData()
        
    }
    
    @objc func handleCheeseSauceToggle(_ sender: UIButton) {
        let index = sender.tag

        if selectedCheeseSauceIndices.contains(index) {
            selectedCheeseSauceIndices.remove(index)
        } else {
            selectedCheeseSauceIndices.insert(index)
        }

        pizzaCustomizationScreen.cheeseSauceOptionsTableView.reloadData()
        updateAddToCartButtonTitle()
    }

}

extension CustomizationScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pizzaCustomizationScreen.toppingsTableView {
            return toppings.count
        } else if tableView == pizzaCustomizationScreen.pizzaOptionsTableView {
            return pizzaOptions.count
        }else if tableView == pizzaCustomizationScreen.cheeseSauceOptionsTableView {
            return cheeseOrSauce.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == pizzaCustomizationScreen.toppingsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "toppingsCell", for: indexPath) as! ToppingsTableView
            cell.itemName.text = toppings[indexPath.row]
            
            cell.isChecked = selectedToppingsIndices.contains(indexPath.row)
            let maxToppings = menuItem?.maxToppings ?? 0
            cell.checkboxButton.isEnabled = selectedToppingsIndices.count < maxToppings || cell.isChecked
            cell.checkboxButton.addTarget(self, action: #selector(handleCheckboxToggle(_:)), for: .touchUpInside)
            cell.checkboxButton.tag = indexPath.row
            
            return cell
            
        } else if tableView == pizzaCustomizationScreen.pizzaOptionsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pizzaOptionsCell", for: indexPath) as! PizzaOptionsTableView
            cell.itemName.text = pizzaOptions[indexPath.row]
            cell.isChecked = selectedPizzaOptionsIndices.contains(indexPath.row)
            cell.checkboxButton.addTarget(self, action: #selector(handlePizzaOptionToggle(_:)), for: .touchUpInside)
            cell.checkboxButton.tag = indexPath.row
            return cell
            
        } else if tableView == pizzaCustomizationScreen.cheeseSauceOptionsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cheeseSauceOptionsCell", for: indexPath) as! CheeseSauceOptionsTableView
            let option = cheeseOrSauce[indexPath.row]
            cell.itemName.text = option["name"] as? String ?? ""
            if let price = option["price"] as? Int {
                cell.itemPrice.text = String(format: "+$%.2f", Double(price))
            }
            cell.isChecked = selectedCheeseSauceIndices.contains(indexPath.row)
            cell.checkboxButton.addTarget(self, action: #selector(handleCheeseSauceToggle(_:)), for: .touchUpInside)
            cell.checkboxButton.tag = indexPath.row
            return cell

        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension CustomizationScreenViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        pizzaCustomizationScreen.placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        pizzaCustomizationScreen.placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        pizzaCustomizationScreen.placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
