//
//  LandingPageView.swift
//  Joes Pizza
//
//  Created by Prudhvi Vuda on 12/8/24.
//

import UIKit

class LandingPageView: UIView {

    var contentWrapper:UIScrollView!
    var joesImage:UIImageView!
    var loginButton:UIButton!
    var registerButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupJoesImage()
        setupLoginButton()
        setupRegisterButton()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupJoesImage(){
        joesImage = UIImageView()
        joesImage.contentMode = .scaleAspectFit
        joesImage.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(joesImage)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemRed
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginButton)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemRed
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(registerButton)
    }
    
    func initConstraints(){
        
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            joesImage.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 100),
            joesImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            joesImage.widthAnchor.constraint(equalToConstant: 300),
            joesImage.heightAnchor.constraint(equalToConstant: 300),
            
            registerButton.topAnchor.constraint(equalTo: joesImage.bottomAnchor, constant: 50),
            registerButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            registerButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            registerButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
         
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            loginButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
                     
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
