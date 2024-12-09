import UIKit

class CartScreenView: UIView {

    var contentWrapper: UIScrollView!
    var emptyCartLabel: UILabel!
    var orderDetailsTableView: UITableView!
    var checkoutButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupEmptyCartLabel()
        setupOrderDetailsTableView()
        setupCheckoutButton()

        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupEmptyCartLabel(){
        emptyCartLabel = UILabel()
        emptyCartLabel.font = UIFont.systemFont(ofSize: 18)
        emptyCartLabel.text = "Add items to start your order."
        emptyCartLabel.textColor = .gray
        emptyCartLabel.isHidden = true
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(emptyCartLabel)
    }
    
    func setupOrderDetailsTableView(){
        orderDetailsTableView = UITableView()
        orderDetailsTableView.register(OrderDetailsTableView.self, forCellReuseIdentifier: "CartItemCell")
        orderDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(orderDetailsTableView)
    }
    
    func setupCheckoutButton() {
        checkoutButton = UIButton(type: .system)
        checkoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.backgroundColor = .systemRed
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 20
        checkoutButton.clipsToBounds = true
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(checkoutButton)
    }

    
    func initConstraints(){
        
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            emptyCartLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 30),
            emptyCartLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            orderDetailsTableView.topAnchor.constraint(equalTo: emptyCartLabel.bottomAnchor, constant: 5),
            orderDetailsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            orderDetailsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            orderDetailsTableView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20),
            orderDetailsTableView.heightAnchor.constraint(equalTo: contentWrapper.heightAnchor),
            
            checkoutButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            checkoutButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            checkoutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            checkoutButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
