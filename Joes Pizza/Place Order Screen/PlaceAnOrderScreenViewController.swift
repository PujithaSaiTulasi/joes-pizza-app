import UIKit
import FirebaseAuth
import FirebaseFirestore

class PlaceAnOrderScreenViewController: UIViewController {

    let mainScreenView = PlaceAnOrderScreenView()
    let db = Firestore.firestore()
    var groupedMenuItems: [String: [MenuItem]] = [:]
    var categories: [String] = []
    
    override func loadView() {
        view = mainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainScreenView.menuTableView.separatorStyle = .none
        mainScreenView.menuTableView.delegate = self
        mainScreenView.menuTableView.dataSource = self
        
        fetchMenuItems()
        updateCartButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: NSNotification.Name("CartUpdated"), object: nil)
        mainScreenView.viewCartButton.addTarget(self, action: #selector(viewCartButtonTapped), for: .touchUpInside)
    }
    
    @objc func cartUpdated() {
        updateCartButton()
    }
    
    func fetchMenuItems() {
        
        db.collection("menu").getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching menu items: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            var allMenuItems: [MenuItem] = []
            for doc in documents {
                let data = doc.data()
                if let name = data["name"] as? String,
                   let id = data["id"] as?  Int,
                   let basePrice = data["basePrice"] as? Double,
                   let category = data["category"] as? String,
                   let description = data["description"] as? String,
                   let availability = data["availability"] as? Bool,
                   let image = data["image"] as? String {
                    
                    let maxToppings = data["maxToppings"] as? Int
                    let pricePerTopping = data["pricePerTopping"] as? [Int]
                        
                    let menuItem = MenuItem(id: id,name: name, basePrice: basePrice, category: category, description: description, availability: availability, image: image, pricePerTopping: pricePerTopping, maxToppings: maxToppings)
                    allMenuItems.append(menuItem)
                }
            }
            self.groupedMenuItems = Dictionary(grouping: allMenuItems, by: { $0.category })
            for (key, items) in self.groupedMenuItems {
                self.groupedMenuItems[key] = items.sorted(by: { $0.id < $1.id })
            }
            let predefinedOrder = ["Pizza", "Salads", "Drinks"]
            self.categories = predefinedOrder.filter { self.groupedMenuItems.keys.contains($0) }
            DispatchQueue.main.async {
                self.mainScreenView.configureCategories(categories: self.categories, target: self, action: #selector(self.categoryButtonTapped(_:)))
                self.mainScreenView.menuTableView.reloadData()
            }
        }
    }
    
    func updateCartButton() {
        guard let userId = Auth.auth().currentUser?.email else {
            print("User not authenticated")
            return
        }
        
        let cartRef = db.collection("carts").document(userId)
        cartRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching cart document: \(error)")
                return
            }
            if let document = document, document.exists {
                if let items = document.data()?["items"] as? [[String: Any]] {
                    let itemCount = items.count
                    if itemCount > 0 {
                        self.mainScreenView.viewCartButton.isHidden = false
                        self.mainScreenView.viewCartButton.setTitle("View Cart  (\(itemCount))", for: .normal)
                    } else {
                        self.mainScreenView.viewCartButton.isHidden = true
                    }
                } else {
                    print("Items not found in the cart document.")
                    self.mainScreenView.viewCartButton.isHidden = true
                }
            } else {
                print("Cart document does not exist.")
            }
        }
    }

    
    @objc private func viewCartButtonTapped() {
        let cartVC = CartScreenViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }

    @objc func categoryButtonTapped(_ sender: UIButton) {
        let sectionIndex = sender.tag
        let indexPath = IndexPath(row: 0, section: sectionIndex)
        mainScreenView.updateCategorySelection(selectedIndex: sender.tag)
        mainScreenView.menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension PlaceAnOrderScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        return groupedMenuItems[category]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.text = categories[section]
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)  as! MenuTableView
        let category = categories[indexPath.section]
        if let menuItem = groupedMenuItems[category]?[indexPath.row] {
            cell.labelItemName?.text = menuItem.name
            cell.labelItemPrice?.text = String(format: "$%.2f", menuItem.basePrice)
            cell.labelItemDescription?.text = menuItem.description
            cell.imageViewItem?.image = UIImage(named: menuItem.image!)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.section]
        if let menuItem = groupedMenuItems[category]?[indexPath.row] {
            let customizationViewController = CustomizationScreenViewController()
            customizationViewController.menuItem = menuItem
            navigationController?.pushViewController(customizationViewController, animated: true)
        }
        
    }

}
