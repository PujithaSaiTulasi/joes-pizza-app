import UIKit

class MenuTableView: UITableViewCell {

    var wrapperCellView: UIView!
    var imageViewItem: UIImageView!
    var labelItemDescription: UILabel!
    var labelItemName: UILabel!
    var labelItemPrice: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupWrapperCellView()
        setupimageItem()
        setupLabelItemName()
        setupItemDescription()
        setupLabelItemPrice()
        
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
    
    func setupimageItem(){
        imageViewItem = UIImageView()
        imageViewItem.image = UIImage(systemName: "")
        imageViewItem.contentMode = .scaleAspectFill
        imageViewItem.clipsToBounds = true
        imageViewItem.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageViewItem)
    }
  
    func setupLabelItemName(){
        labelItemName = UILabel()
        labelItemName.font = UIFont.boldSystemFont(ofSize: 16)
        labelItemName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelItemName)
    }
    
    func setupItemDescription(){
        labelItemDescription = UILabel()
        labelItemDescription.font = UIFont.boldSystemFont(ofSize: 12)
        labelItemDescription.textColor = .gray
        labelItemDescription.numberOfLines = 0
        labelItemDescription.lineBreakMode = .byWordWrapping
        labelItemDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelItemDescription)
    }
    
    func setupLabelItemPrice(){
        labelItemPrice = UILabel()
        labelItemPrice.font = UIFont.boldSystemFont(ofSize: 16)
        labelItemPrice.textColor = .systemPurple
        labelItemPrice.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelItemPrice)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            wrapperCellView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            imageViewItem.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 3),
            imageViewItem.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -3),
            imageViewItem.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -3),
            imageViewItem.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            imageViewItem.heightAnchor.constraint(equalToConstant: 80),
            imageViewItem.widthAnchor.constraint(equalToConstant: 120),
            
            labelItemName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 20),
            labelItemName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
            labelItemName.heightAnchor.constraint(equalToConstant: 20),
            
            labelItemDescription.topAnchor.constraint(equalTo: labelItemName.bottomAnchor, constant: 5),
            labelItemDescription.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
            labelItemDescription.trailingAnchor.constraint(equalTo: imageViewItem.leadingAnchor, constant: -20),
            labelItemDescription.heightAnchor.constraint(equalToConstant: 50),
            
            labelItemPrice.topAnchor.constraint(equalTo: labelItemDescription.bottomAnchor, constant: 10),
            labelItemPrice.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
            labelItemPrice.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -20),
            labelItemPrice.heightAnchor.constraint(equalToConstant: 15),
            
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
