import UIKit

class PizzaOptionsTableView: UITableViewCell {

    var checkboxButton: UIButton!
    var itemName: UILabel!
    var isChecked: Bool = false {
        didSet {
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupCheckboxButton()
        setupLabelItemName()
        initConstraints()
    }

    func setupCheckboxButton() {
        checkboxButton = UIButton(type: .system)
        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkboxButton.tintColor = .systemRed
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkboxButton)
    }

    func setupLabelItemName() {
        itemName = UILabel()
        itemName.font = UIFont.systemFont(ofSize: 16)
        itemName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemName)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 30),
            checkboxButton.heightAnchor.constraint(equalToConstant: 30),

            itemName.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 10),
            itemName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            itemName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
