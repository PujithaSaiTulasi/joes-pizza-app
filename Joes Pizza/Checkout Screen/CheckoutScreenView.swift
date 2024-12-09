import UIKit

class CheckoutScreenView: UIView {

    var contentWrapper:UIScrollView!
    var bottomBorder: UIView!
    var detailsLabel: UILabel!
    var deliverPickupLabel: UILabel!
    var plusButton: UIButton!
    var contactInfoLabel: UILabel!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var mobileNumberTextField: UITextField!
    var paymentLabel: UILabel!
    var googlePayButton: UIButton!
    var placeOrderButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupBottomBorder()
        setupDetailsLabel()
        setupDeliverPickupLabel()
        setupPlusButton()
        setupContactInfoLabel()
        setupFirstNameTextField()
        setupLastNameTextField()
        setupMobileNumberTextField()
        setupPaymentLabel()
        setupGooglePayButton()
        setupPlaceOrderButton()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupBottomBorder(){
        bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(bottomBorder)
    }
    
    func setupDetailsLabel(){
        detailsLabel = UILabel()
        detailsLabel.text = "Details"
        detailsLabel.textColor = .red
        detailsLabel.font = UIFont.boldSystemFont(ofSize: 22)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(detailsLabel)
    }
    
    func setupDeliverPickupLabel(){
        deliverPickupLabel = UILabel()
        deliverPickupLabel.text = "Dough! You forgot to select Delivery or Pickup"
        deliverPickupLabel.font = UIFont.systemFont(ofSize: 17)
        deliverPickupLabel.textColor = .black
        deliverPickupLabel.numberOfLines = 0
        deliverPickupLabel.lineBreakMode = .byWordWrapping
        deliverPickupLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(deliverPickupLabel)
    }
    
    func setupPlusButton() {
        plusButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        plusButton.setImage(image, for: .normal)
        plusButton.tintColor = .systemRed
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(plusButton)
    }
    
    func setupContactInfoLabel(){
        contactInfoLabel = UILabel()
        contactInfoLabel.text = "Contact Information"
        contactInfoLabel.textColor = .red
        contactInfoLabel.font = UIFont.boldSystemFont(ofSize: 22)
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(contactInfoLabel)
    }
    
    func setupFirstNameTextField(){
        firstNameTextField = UITextField()
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.layer.borderWidth = 2.0
        firstNameTextField.layer.borderColor = UIColor.gray.cgColor
        firstNameTextField.layer.cornerRadius = 5.0
        
        let placeholderText = "First Name"
        let placeholderColor = UIColor.gray
        firstNameTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        )
    
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: firstNameTextField.frame.height))
        firstNameTextField.leftView = paddingView
        firstNameTextField.leftViewMode = .always
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(firstNameTextField)
    }
    
    func setupLastNameTextField(){
        lastNameTextField = UITextField()
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.layer.borderWidth = 2.0
        lastNameTextField.layer.borderColor = UIColor.gray.cgColor
        lastNameTextField.layer.cornerRadius = 5.0
        let placeholderText = "Last Name"
        let placeholderColor = UIColor.gray
        lastNameTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: firstNameTextField.frame.height))
        lastNameTextField.leftView = paddingView
        lastNameTextField.leftViewMode = .always
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(lastNameTextField)
    }
    
    func setupMobileNumberTextField(){
        mobileNumberTextField = UITextField()
        mobileNumberTextField.placeholder = "Mobile Phone Number"
        mobileNumberTextField.layer.borderWidth = 2.0
        mobileNumberTextField.layer.borderColor = UIColor.gray.cgColor
        mobileNumberTextField.layer.cornerRadius = 5.0
        let placeholderText = "Mobile Phone Number"
        let placeholderColor = UIColor.gray
        mobileNumberTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: firstNameTextField.frame.height))
        mobileNumberTextField.leftView = paddingView
        mobileNumberTextField.leftViewMode = .always
        
        mobileNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(mobileNumberTextField)
    }
    
    func setupPaymentLabel(){
        paymentLabel = UILabel()
        paymentLabel.text = "Payment Method"
        paymentLabel.textColor = .red
        paymentLabel.font = UIFont.boldSystemFont(ofSize: 22)
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(paymentLabel)
    }
    
    func setupGooglePayButton(){
        googlePayButton = UIButton(type: .system)
        googlePayButton.setImage(UIImage(named: "gpay.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        googlePayButton.imageView?.contentMode = .scaleToFill
        googlePayButton.clipsToBounds = true
        googlePayButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(googlePayButton)
    }
    
    func setupPlaceOrderButton() {
        placeOrderButton = UIButton(type: .system)
        placeOrderButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        placeOrderButton.setTitle("Place Order", for: .normal)
        placeOrderButton.backgroundColor = .systemRed
        placeOrderButton.setTitleColor(.white, for: .normal)
        placeOrderButton.layer.cornerRadius = 20
        placeOrderButton.clipsToBounds = true
        placeOrderButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeOrderButton)
    }
    
    func initConstraints(){
        
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            deliverPickupLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 15),
            deliverPickupLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            deliverPickupLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -5),
            deliverPickupLabel.heightAnchor.constraint(equalToConstant: 40),
            
            plusButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 15),
            plusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
            
            contactInfoLabel.topAnchor.constraint(equalTo: deliverPickupLabel.bottomAnchor, constant: 40),
            contactInfoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            firstNameTextField.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 25),
            firstNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            mobileNumberTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            mobileNumberTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mobileNumberTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mobileNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            paymentLabel.topAnchor.constraint(equalTo: mobileNumberTextField.bottomAnchor, constant: 40),
            paymentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            googlePayButton.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 20),
            googlePayButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            googlePayButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20),
            googlePayButton.heightAnchor.constraint(equalToConstant: 30),
            googlePayButton.widthAnchor.constraint(equalToConstant: 60),
            
            placeOrderButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            placeOrderButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            placeOrderButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            placeOrderButton.heightAnchor.constraint(equalToConstant: 40),
                     
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
