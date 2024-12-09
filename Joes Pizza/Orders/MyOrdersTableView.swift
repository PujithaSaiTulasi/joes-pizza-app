import UIKit

class MyOrdersTableView: UITableViewCell {

    var wrapperCellView: UIView!
    var orderLabel: UILabel!
    var orderPrice: UILabel!
    var orderDate: UILabel!
    var orderItems: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupWrapperCellView()
        setupOrderLabel()
        setuporderPrice()
        setuporderDate()
        setuporderItems()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UIView()
        wrapperCellView.layer.borderColor = UIColor.systemGray6.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 6.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupOrderLabel(){
        orderLabel = UILabel()
        orderLabel.textColor = .systemRed
        orderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(orderLabel)
    }
  
    func setuporderPrice(){
        orderPrice = UILabel()
        orderPrice.font = UIFont.boldSystemFont(ofSize: 18)
        orderPrice.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(orderPrice)
    }
    
    func setuporderDate(){
        orderDate = UILabel()
        orderDate.font = UIFont.boldSystemFont(ofSize: 16)
        orderDate.textColor = .systemGray
        orderDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(orderDate)
    }
    
    func setuporderItems(){
        orderItems = UILabel()
        orderItems.font = UIFont.systemFont(ofSize: 16)
        orderItems.textColor = .black
        orderItems.numberOfLines = 0
        orderItems.lineBreakMode = .byWordWrapping
        orderItems.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(orderItems)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            wrapperCellView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            orderLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 20),
            orderLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
            
            orderPrice.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 20),
            orderPrice.leadingAnchor.constraint(equalTo: orderLabel.trailingAnchor, constant: 20),
            orderPrice.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -20),
            
            orderDate.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 10),
            orderDate.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
            
            orderItems.topAnchor.constraint(equalTo: orderDate.bottomAnchor, constant: 10),
            orderItems.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
            orderItems.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -20),
            orderItems.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -20),
            orderItems.heightAnchor.constraint(equalToConstant: 50),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
