import UIKit

class SuccessScreenView: UIView {

    var contentWrapper: UIScrollView!
    var greenCheckmarkImageView: UIImageView!
    var orderPlacedLabel: UILabel!
    var viewOrderDetailsButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupGreenCheckMarkImage()
        setupOrderPlacedLabel()
        setupViewOrderDetailsButton()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupGreenCheckMarkImage(){
        greenCheckmarkImageView = UIImageView()
        greenCheckmarkImageView.image = UIImage(named: "success.png")
        greenCheckmarkImageView.contentMode = .scaleAspectFill
        greenCheckmarkImageView.clipsToBounds = true
        greenCheckmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(greenCheckmarkImageView)
        
    }
    
    func setupOrderPlacedLabel(){
        orderPlacedLabel = UILabel()
        orderPlacedLabel.text = "Order Placed!"
        orderPlacedLabel.font = UIFont.boldSystemFont(ofSize: 22)
        orderPlacedLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(orderPlacedLabel)
    }
    
    func setupViewOrderDetailsButton(){
        viewOrderDetailsButton = UIButton(type: .system)
        viewOrderDetailsButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        viewOrderDetailsButton.setTitle("View Order Details", for: .normal)
        viewOrderDetailsButton.backgroundColor = .systemRed
        viewOrderDetailsButton.setTitleColor(.white, for: .normal)
        viewOrderDetailsButton.layer.cornerRadius = 20
        viewOrderDetailsButton.clipsToBounds = true
        viewOrderDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewOrderDetailsButton)
    }
    
    
    func initConstraints(){
        
        NSLayoutConstraint.activate([
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            greenCheckmarkImageView.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 200),
            greenCheckmarkImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            greenCheckmarkImageView.heightAnchor.constraint(equalToConstant: 100),
            greenCheckmarkImageView.widthAnchor.constraint(equalToConstant: 100),
            
            orderPlacedLabel.topAnchor.constraint(equalTo: greenCheckmarkImageView.bottomAnchor, constant: 50),
            orderPlacedLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            orderPlacedLabel.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -60),
            
            viewOrderDetailsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            viewOrderDetailsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            viewOrderDetailsButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            viewOrderDetailsButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            viewOrderDetailsButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
