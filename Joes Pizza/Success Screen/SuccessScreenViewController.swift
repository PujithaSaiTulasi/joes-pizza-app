import UIKit

class SuccessScreenViewController: UIViewController {

    let successScreen = SuccessScreenView()

    override func loadView() {
        view = successScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationItem.hidesBackButton = true
        successScreen.viewOrderDetailsButton.addTarget(self, action: #selector(viewOrderDetails), for: .touchUpInside)
    }
    
    @objc func viewOrderDetails() {
        let orderVC = MyOrdersViewController()
        self.navigationController?.pushViewController(orderVC, animated: true)
    }

}
