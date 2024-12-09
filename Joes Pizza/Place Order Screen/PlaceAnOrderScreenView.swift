import UIKit

class PlaceAnOrderScreenView: UIView {
    
    var contentWrapper:UIScrollView!
    var topImageView:UIImageView!
    var searchBar:UISearchBar!
    var categoryScrollView:UIScrollView!
    var categoryStackView:UIStackView!
    var menuTableView:UITableView!
    var viewCartButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupTopImageView()
        setupSearchBar()
        setupCategoryScrollView()
        setupCategoryStackView()
        setupMenuTableView()
        setupViewCartButton()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupTopImageView(){
        topImageView = UIImageView()
        topImageView.image = UIImage(named: "pizza.png")
        topImageView.contentMode = .scaleAspectFill
        topImageView.clipsToBounds = true
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(topImageView)
    }
    
    func setupSearchBar(){
        searchBar = UISearchBar()
        searchBar.placeholder = "Search Joe's Pizza"
        searchBar.backgroundColor = .white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.borderColor = UIColor.gray.cgColor
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(searchBar)
    }
   
    func setupCategoryScrollView(){
        categoryScrollView = UIScrollView()
        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(categoryScrollView)
    }
 
    func setupCategoryStackView(){
        categoryStackView = UIStackView()
        categoryStackView.axis = .horizontal
        categoryStackView.spacing = 16
        categoryStackView.distribution = .fillEqually
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryScrollView.addSubview(categoryStackView)
    }

    func setupMenuTableView(){
        menuTableView = UITableView()
        menuTableView.register(MenuTableView.self, forCellReuseIdentifier: "menuCell")
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(menuTableView)
    }
    
    func setupViewCartButton(){
        viewCartButton = UIButton(type: .system)
        viewCartButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        viewCartButton.setTitle("View Cart", for: .normal)
        viewCartButton.backgroundColor = .systemRed
        viewCartButton.setTitleColor(.white, for: .normal)
        viewCartButton.layer.cornerRadius = 20
        viewCartButton.clipsToBounds = true
        viewCartButton.isHidden = true
        viewCartButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewCartButton)
    }

    func initConstraints(){
        
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            topImageView.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            topImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            topImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            topImageView.heightAnchor.constraint(equalToConstant: 250),

            searchBar.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
             
            categoryScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            categoryScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 8 ),
            categoryScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -8),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 30),
             
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor),
            categoryStackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor),

            menuTableView.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -45),
            menuTableView.heightAnchor.constraint(equalTo: contentWrapper.heightAnchor),
            
            viewCartButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            viewCartButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            viewCartButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            viewCartButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            viewCartButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    func configureCategories(categories: [String], target: Any, action: Selector) {
        for (index, category) in categories.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.tag = index
            button.addTarget(target, action: action, for: .touchUpInside)
            categoryStackView.addArrangedSubview(button)
        }
    }
    
    func updateCategorySelection(selectedIndex: Int) {
        for (index, view) in categoryStackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                if index == selectedIndex {
                    button.setTitleColor(.systemRed, for: .normal)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    addBottomBorder(to: button, color: .systemRed, height: 2)
            
                } else {
                    button.setTitleColor(.black, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    removeBottomBorder(from: button)
                }
            }
        }
    }
    
    func addBottomBorder(to button: UIButton, color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: button.frame.size.height - height, width: button.frame.size.width, height: height)
        border.backgroundColor = color.cgColor
        button.layer.addSublayer(border)
    }

    func removeBottomBorder(from button: UIButton) {
        if let layers = button.layer.sublayers {
            for layer in layers {
                if layer.backgroundColor == UIColor.systemRed.cgColor {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

