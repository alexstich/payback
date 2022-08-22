import Foundation
import RxSwift

class CoordinatorFeed : BaseCoordinator
{
    
    override func start()
    {
        toFeed()
    }
    
    public func toFeed()
    {
        let vc = FeedViewController()
        
        navigationController.pushViewController(vc, animated: true)
        
        vc.ps_clicked_shoping_tile
            .subscribe(onNext: { [weak self] in
                self?.toaddItemToShoppingList()
            })
            .disposed(by: disposeBag)
    }
    
    public func toaddItemToShoppingList()
    {
        let vc = AddItemToShoppingListViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
}
