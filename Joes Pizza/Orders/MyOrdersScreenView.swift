import UIKit

class MyOrdersScreenView: UIView {

    var ordersTableView:UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupOrdersTableView()
        
        initConstraints()
    }
    
    func setupOrdersTableView(){
        ordersTableView = UITableView()
        ordersTableView.register(MyOrdersTableView.self, forCellReuseIdentifier: "orderCell")
        ordersTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ordersTableView)
    }
    
    func initConstraints(){
        
        NSLayoutConstraint.activate([
            
            ordersTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            ordersTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ordersTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            ordersTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
