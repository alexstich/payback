import Foundation
import UIKit
import RxSwift

class BaseCoordinator: CoordinatorProtocol
{
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    required init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func clearAll()
    {
        childCoordinators.forEach({ coordinator in
            coordinator.clearAll()
        })
        
        self.childCoordinators.removeAll()
        self.navigationController.viewControllers.removeAll()
    }
}
