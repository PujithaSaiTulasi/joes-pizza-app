import UIKit
import Spatial
import FirebaseFirestore
import FirebaseAuth

class MyOrdersViewController: UIViewController {

    let db = Firestore.firestore()
    let ordersScreenView = MyOrdersScreenView()
    var orders = [Order]()
    
    override func loadView() {
        view = ordersScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "My Orders"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ]
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        navigationItem.hidesBackButton = true
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(onCloseTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        ordersScreenView.ordersTableView.separatorStyle = .none
        ordersScreenView.ordersTableView.delegate = self
        ordersScreenView.ordersTableView.dataSource = self
        
        fetchOrderDetails()
    }
    
    @objc func onCloseTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func fetchOrderDetails() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("orders")
            .whereField("userId", isEqualTo: currentUserID)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error fetching orders: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else { return }
                
                self?.orders.removeAll()
                
                for document in snapshot.documents {
                    let data = document.data()
                    
                    if let totalAmount = data["totalAmount"] as? Double,
                       let userEmail = data["userEmail"] as? String,
                       let createdAt = data["createdAt"] as? Timestamp,
                       let items = data["items"] as? [[String: Any]] {
                        
                        let orderDate = createdAt.dateValue()
                        let orderItems = self?.getItemsFromOrder(items: items)
                        
                        let order = Order(
                            totalAmount: totalAmount,
                            userEmail: userEmail,
                            createdAt: orderDate,
                            orderItems: orderItems ?? "",
                            orderId: document.documentID
                        )
                        self?.orders.append(order)
                    }
                }
                self?.orders.sort { $0.createdAt > $1.createdAt }
                self?.ordersScreenView.ordersTableView.reloadData()
            }
    }

    func getItemsFromOrder(items: [[String: Any]]) -> String {
        var itemNames = [String]()
        
        for item in items {
            if let name = item["name"] as? String {
                itemNames.append(name)
            }
        }
        
        return itemNames.joined(separator: " | ")
    }
}

extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! MyOrdersTableView
        
        let order = orders[indexPath.row]
        
        let orderNumber = indexPath.row + 1
        cell.orderLabel.text = "Order #\(orderNumber)"
        cell.orderPrice.text = String(format: "$%.2f", order.totalAmount)
        cell.orderDate.text = formatDate(order.createdAt)
        cell.orderItems.text = order.orderItems
        
        return cell
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy    h:mma"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection if needed (navigate to order details, for example)
    }
    
}
