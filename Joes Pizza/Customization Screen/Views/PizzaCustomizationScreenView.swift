import UIKit

class PizzaCustomizationScreenView: UIView {

    var contentWrapper:UIScrollView!
    var itemImage:UIImageView!
    var itemName:UILabel!
    var itemDescription:UILabel!
    var itemPrice:UILabel!
    
    var quantityLabel:UILabel!
    var minusButton:UIButton!
    var itemCount:UILabel!
    var plusButton:UIButton!
   
    var toppingsLabel:LabelPadding!
    var maxChoiceLabel:UILabel!
    var toppingsTableView:UITableView!
    var cheeseSauceOptionsLabel:LabelPadding!
    var cheeseSauceOptionsTableView:UITableView!
    var pizzaOptionsLabel:LabelPadding!
    var pizzaOptionsTableView:UITableView!
    
    var specialInstructionsLabel:LabelPadding!
    var specialInstructionsTextView:UITextView!
    var placeholderLabel:UILabel!
    var bottomBorder:UIView!
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
        
        setupToppingsLabel()
        setupMaxChoiceLabel()
        setupToppingsTable()
        setupCheeseSauceOptionsLabel()
        setupCheeseSauceOptionsTable()
        setupPizzaOptionsLabel()
        setupPizzaOptionsTable()
        
        setupSpecialInstructionsLabel()
        setupSpecialInstructionsTextView()
        setupPlaceholderLabel()
        setupBottomBorder()
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
//        itemName.font = UIFont(name: "AvenirNext-Bold", size: 20)
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
    
    func setupToppingsLabel(){
        toppingsLabel = LabelPadding()
        toppingsLabel.text = "TOPPINGS"
        toppingsLabel.textColor = .white
        toppingsLabel.backgroundColor = .systemRed
        toppingsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        toppingsLabel.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        toppingsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(toppingsLabel)
    }
    
    func setupMaxChoiceLabel(){
        maxChoiceLabel = UILabel()
        maxChoiceLabel.font = UIFont.italicSystemFont(ofSize: 15)
        maxChoiceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(maxChoiceLabel)
    }
    
    func setupToppingsTable(){
        toppingsTableView = UITableView()
        toppingsTableView.register(ToppingsTableView.self, forCellReuseIdentifier: "toppingsCell")
        toppingsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(toppingsTableView)
    }
    
    func setupPizzaOptionsLabel(){
        pizzaOptionsLabel = LabelPadding()
        pizzaOptionsLabel.text = "PIZZA  OPTIONS"
        pizzaOptionsLabel.textColor = .white
        pizzaOptionsLabel.backgroundColor = .systemRed
        pizzaOptionsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        pizzaOptionsLabel.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        pizzaOptionsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(pizzaOptionsLabel)
    }
    
    func setupPizzaOptionsTable(){
        pizzaOptionsTableView = UITableView()
        pizzaOptionsTableView.register(PizzaOptionsTableView.self, forCellReuseIdentifier: "pizzaOptionsCell")
        pizzaOptionsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(pizzaOptionsTableView)
    }
    
    func setupCheeseSauceOptionsLabel(){
        cheeseSauceOptionsLabel = LabelPadding()
        cheeseSauceOptionsLabel.text = "CHEESE / SAUCE  OPTIONS"
        cheeseSauceOptionsLabel.textColor = .white
        cheeseSauceOptionsLabel.backgroundColor = .systemRed
        cheeseSauceOptionsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        cheeseSauceOptionsLabel.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        cheeseSauceOptionsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(cheeseSauceOptionsLabel)
    }
    
    func setupCheeseSauceOptionsTable(){
        cheeseSauceOptionsTableView = UITableView()
        cheeseSauceOptionsTableView.register(CheeseSauceOptionsTableView.self, forCellReuseIdentifier: "cheeseSauceOptionsCell")
        cheeseSauceOptionsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(cheeseSauceOptionsTableView)
    }
    
    func setupSpecialInstructionsLabel(){
        specialInstructionsLabel = LabelPadding()
        specialInstructionsLabel.text = "SPECIAL INSTRUCTIONS"
        specialInstructionsLabel.textColor = .white
        specialInstructionsLabel.backgroundColor = .systemRed
        specialInstructionsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        specialInstructionsLabel.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        specialInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(specialInstructionsLabel)
    }
    
    func setupSpecialInstructionsTextView(){
        specialInstructionsTextView = UITextView()
        specialInstructionsTextView.font = UIFont.systemFont(ofSize: 16)
        specialInstructionsTextView.textColor = UIColor.black
        specialInstructionsTextView.backgroundColor = UIColor.white
        specialInstructionsTextView.isEditable = true
        specialInstructionsTextView.isScrollEnabled = true
        specialInstructionsTextView.clipsToBounds = false
        specialInstructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(specialInstructionsTextView)
    }
    
    func setupPlaceholderLabel(){
        placeholderLabel = UILabel()
        placeholderLabel.text = "Leave a note for the kitchen like any allergy, dietary restriction or any special request!"
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = UIColor.gray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.lineBreakMode = .byWordWrapping
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        specialInstructionsTextView.addSubview(placeholderLabel)
    }
    
    func setupBottomBorder(){
        bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(bottomBorder)
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
            
            toppingsLabel.topAnchor.constraint(equalTo: itemCount.bottomAnchor, constant: 40),
            toppingsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            toppingsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            toppingsLabel.heightAnchor.constraint(equalToConstant: 35),
            
            maxChoiceLabel.topAnchor.constraint(equalTo: toppingsLabel.bottomAnchor, constant: 20),
            maxChoiceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            toppingsTableView.topAnchor.constraint(equalTo: maxChoiceLabel.bottomAnchor, constant: 20),
            toppingsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            toppingsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            toppingsTableView.heightAnchor.constraint(equalToConstant: 610),
            
            cheeseSauceOptionsLabel.topAnchor.constraint(equalTo: toppingsTableView.bottomAnchor, constant: 20),
            cheeseSauceOptionsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            cheeseSauceOptionsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            cheeseSauceOptionsLabel.heightAnchor.constraint(equalToConstant: 35),
            
            cheeseSauceOptionsTableView.topAnchor.constraint(equalTo: cheeseSauceOptionsLabel.bottomAnchor, constant: 15),
            cheeseSauceOptionsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            cheeseSauceOptionsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            cheeseSauceOptionsTableView.heightAnchor.constraint(equalToConstant: 170),
            
            pizzaOptionsLabel.topAnchor.constraint(equalTo: cheeseSauceOptionsTableView.bottomAnchor, constant: 20),
            pizzaOptionsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            pizzaOptionsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            pizzaOptionsLabel.heightAnchor.constraint(equalToConstant: 35),
            
            pizzaOptionsTableView.topAnchor.constraint(equalTo: pizzaOptionsLabel.bottomAnchor, constant: 15),
            pizzaOptionsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            pizzaOptionsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            pizzaOptionsTableView.heightAnchor.constraint(equalToConstant: 210),
            
            specialInstructionsLabel.topAnchor.constraint(equalTo: pizzaOptionsTableView.bottomAnchor, constant: 20),
            specialInstructionsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            specialInstructionsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            specialInstructionsLabel.heightAnchor.constraint(equalToConstant: 35),
            
            specialInstructionsTextView.topAnchor.constraint(equalTo: specialInstructionsLabel.bottomAnchor, constant: 20),
            specialInstructionsTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            specialInstructionsTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            specialInstructionsTextView.heightAnchor.constraint(equalToConstant: 50),
            
            placeholderLabel.topAnchor.constraint(equalTo: specialInstructionsTextView.topAnchor, constant: 5),
            placeholderLabel.leadingAnchor.constraint(equalTo: specialInstructionsTextView.leadingAnchor, constant: 10),
            placeholderLabel.trailingAnchor.constraint(equalTo: specialInstructionsTextView.trailingAnchor, constant: -10),
            placeholderLabel.widthAnchor.constraint(equalToConstant: 400),
            
            bottomBorder.topAnchor.constraint(equalTo: specialInstructionsTextView.bottomAnchor, constant: 20),
            bottomBorder.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bottomBorder.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottomBorder.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -80),
            bottomBorder.heightAnchor.constraint(equalToConstant: 2),
            
            addToCartButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            addToCartButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            addToCartButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40),
                     
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


