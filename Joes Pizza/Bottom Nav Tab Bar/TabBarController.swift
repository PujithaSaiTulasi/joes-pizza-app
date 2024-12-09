import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let placeOrderVC = PlaceAnOrderScreenViewController()
        placeOrderVC.tabBarItem = UITabBarItem(title: "Place Order", image: UIImage(named: "slice.png"), tag: 0)

        let myOrdersVC = MyOrdersViewController()
        myOrdersVC.tabBarItem = UITabBarItem(title: "My Orders", image: UIImage(named: "orders.png"), tag: 1)

        let accountVC = AccountViewController()
        accountVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.fill"), tag: 2)
        
        self.viewControllers = [placeOrderVC, myOrdersVC, accountVC]
        
        tabBar.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.darkGray
        tabBar.tintColor = UIColor.systemRed
    }
    
}
