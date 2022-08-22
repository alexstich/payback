import UIKit

protocol CoordinatorProtocol: AnyObject
{
    var childCoordinators:          [CoordinatorProtocol]{ get set }
    var navigationController:       UINavigationController! { get set }
    
    func start()
    func clearAll()
}
