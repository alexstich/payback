import UIKit

class AppCoordinator: BaseCoordinator
{
    var window :            UIWindow!
    var launch_options:     [UIApplication.LaunchOptionsKey: Any]?
    
    convenience init(window: UIWindow, launch_options: [UIApplication.LaunchOptionsKey: Any]?)
    {
        self.init(navigationController: UINavigationController())
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = MyColors.text.getUIColor()
        navigationController?.navigationBar.backgroundColor = MyColors.white.getUIColor()
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: MyFonts.getInstance.reg_m,
            NSAttributedString.Key.foregroundColor: MyColors.text.getUIColor(),
        ]
        
        self.window = window
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        
        self.launch_options = launch_options
    }
    
    override func start()
    {
        let coordinatorFeed = CoordinatorFeed(navigationController: navigationController)
        childCoordinators.append(coordinatorFeed)
        
        coordinatorFeed.start()
    }
}
