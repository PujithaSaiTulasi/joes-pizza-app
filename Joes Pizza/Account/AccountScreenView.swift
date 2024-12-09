import UIKit

class AccountScreenView: UIView {

    var contentWrapper: UIScrollView!
    var name: UILabel!
    var email: UILabel!
    var phoneNumber: UILabel!
    var address: UILabel!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupNameLabel()
        setupEmailLabel()
        setupPhoneLabel()
        setupAddressLabel()
        setupLogoutButton()

        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupNameLabel(){
        name = UILabel()
        name.textColor = .systemRed
        name.font = UIFont.boldSystemFont(ofSize: 30)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(name)
    }
  
    func setupEmailLabel(){
        email = UILabel()
        email.font = UIFont.systemFont(ofSize: 20)
        email.textColor = .systemGray
        email.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(email)
    }
    
    func setupPhoneLabel(){
        phoneNumber = UILabel()
        phoneNumber.font = UIFont.systemFont(ofSize: 20)
        phoneNumber.textColor = .black
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(phoneNumber)
    }
    
    func setupAddressLabel(){
        address = UILabel()
        address.font = UIFont.systemFont(ofSize: 20)
        address.textColor = .black
        address.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(address)
    }
    
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 20
        logoutButton.clipsToBounds = true
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(logoutButton)
    }
    
    func initConstraints(){
        
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            name.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 100),
            name.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            email.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            phoneNumber.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            phoneNumber.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            address.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 20),
            address.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 50),
            logoutButton.widthAnchor.constraint(equalToConstant: 150),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            logoutButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
