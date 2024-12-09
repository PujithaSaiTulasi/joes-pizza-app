import UIKit

class DrinkCustomizationScreenView: UIView {

    var contentWrapper:UIScrollView!
    var itemImage:UIImageView!
    var itemName:UILabel!
    var itemDescription:UILabel!
    var itemPrice:UILabel!
    
    var quantityLabel:UILabel!
    var minusButton:UIButton!
    var itemCount:UILabel!
    var plusButton:UIButton!
    var addToCartButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupItemImage()
        setupItemName()
        setupItemDescription()
        setupItemPrice()
        
        setupQuantityLabel()
        setupMinusButton()
        setupItemCount()
        setupPlusButton()
        setupAddToCartButton()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupItemImage(){
        itemImage = UIImageView()
        itemImage.contentMode = .scaleAspectFit
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemImage)
    }
    
    func setupItemName(){
        itemName = UILabel()
        itemName.font = UIFont.boldSystemFont(ofSize: 20)
        itemName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemName)
    }
    
    func setupItemDescription(){
        itemDescription = UILabel()
        itemDescription.font = UIFont.italicSystemFont(ofSize: 15)
        itemDescription.textColor = .darkGray
        itemDescription.numberOfLines = 0
        itemDescription.lineBreakMode = .byWordWrapping
        itemDescription.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemDescription)
    }
    
    func setupItemPrice(){
        itemPrice = UILabel()
        itemPrice.font = UIFont.boldSystemFont(ofSize: 18)
        itemPrice.textColor = .systemPurple
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemPrice)
    }
    
    func setupQuantityLabel(){
        quantityLabel = UILabel()
        quantityLabel.text = "Quantity"
        quantityLabel.font = UIFont.boldSystemFont(ofSize: 18)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(quantityLabel)
    }
    
    func setupMinusButton() {
        minusButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        let image = UIImage(systemName: "minus.circle.fill", withConfiguration: config)
        minusButton.setImage(image, for: .normal)
        minusButton.tintColor = .gray
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(minusButton)
    }
    
    func setupItemCount(){
        itemCount = UILabel()
        itemCount.text = "1"
        itemCount.textAlignment = .center
        itemCount.font = UIFont.boldSystemFont(ofSize: 25)
        itemCount.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemCount)
    }
    
    func setupPlusButton() {
        plusButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        plusButton.setImage(image, for: .normal)
        plusButton.tintColor = .black
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(plusButton)
    }
    
    func setupAddToCartButton() {
        addToCartButton = UIButton(type: .system)
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.backgroundColor = .systemRed
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 20
        addToCartButton.clipsToBounds = true
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addToCartButton)
    }
    
    func initConstraints(){
        
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            itemImage.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            itemImage.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 300),
            
            itemName.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            itemName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            itemPrice.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            itemPrice.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            itemDescription.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 10),
            itemDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            itemDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            itemDescription.heightAnchor.constraint(equalToConstant: 40),
           
            quantityLabel.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 30),
            quantityLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            minusButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 20),
            minusButton.trailingAnchor.constraint(equalTo: itemCount.leadingAnchor, constant: -20),
            
            itemCount.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 20),
            itemCount.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            itemCount.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -20),
            
            plusButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 20),
            plusButton.leadingAnchor.constraint(equalTo: itemCount.trailingAnchor, constant: 20),
         
            addToCartButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            addToCartButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            addToCartButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40),
                     
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


