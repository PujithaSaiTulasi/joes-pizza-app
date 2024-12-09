import UIKit

class OrderDetailsTableView: UITableViewCell {

    var itemName: UILabel!
    var itemPrice: UILabel!
    var addLabel: UILabel!
    var pleaseServeLabel: UILabel!
    var deleteButton: UIButton!
    var editButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupItemNameLabel()
        setupItemPriceLabel()
        setupAddLabel()
        setupPleaseServeLabel()
        setupDeleteButton()
        setupEditButton()
        
        initConstraints()
    }
    
    func setupItemNameLabel() {
        itemName = UILabel()
        itemName.font = UIFont.boldSystemFont(ofSize: 18)
        itemName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemName)
    }
    
    func setupItemPriceLabel() {
        itemPrice = UILabel()
        itemPrice.font = UIFont.boldSystemFont(ofSize: 18)
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemPrice)
    }
    
    func setupAddLabel() {
        addLabel = UILabel()
        addLabel.font = UIFont.systemFont(ofSize: 16)
        addLabel.numberOfLines = 0
        addLabel.lineBreakMode = .byWordWrapping
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addLabel)
    }
    
    func setupPleaseServeLabel() {
        pleaseServeLabel = UILabel()
        pleaseServeLabel.font = UIFont.systemFont(ofSize: 16)
        pleaseServeLabel.numberOfLines = 0
        pleaseServeLabel.lineBreakMode = .byWordWrapping
        pleaseServeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pleaseServeLabel)
    }
    
    func setupDeleteButton() {
        deleteButton = UIButton(type: .system)
        deleteButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        deleteButton.setTitle("DELETE", for: .normal)
        deleteButton.setTitleColor(.gray, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteButton)
    }

    func setupEditButton() {
        editButton = UIButton(type: .system)
        editButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        editButton.setTitle("EDIT", for: .normal)
        editButton.backgroundColor = .systemRed
        editButton.setTitleColor(.white, for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([

            itemName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            itemName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            itemPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            itemPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            addLabel.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 10),
            addLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            pleaseServeLabel.topAnchor.constraint(equalTo: addLabel.bottomAnchor, constant: 10),
            pleaseServeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            deleteButton.topAnchor.constraint(equalTo: pleaseServeLabel.bottomAnchor, constant: 15),
            deleteButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -25),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            deleteButton.widthAnchor.constraint(equalToConstant:80),
            
            editButton.topAnchor.constraint(equalTo: pleaseServeLabel.bottomAnchor, constant: 15),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            editButton.widthAnchor.constraint(equalToConstant:80),
            
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
