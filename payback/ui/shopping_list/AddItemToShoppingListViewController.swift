
import UIKit
import SnapKit
import RxSwift

class AddItemToShoppingListViewController: UIViewController
{
    var list:  AddItemToShoppingList!
    
    var selected_items: [String] = []
    {
        didSet{
            list.selected_items = selected_items
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        list = AddItemToShoppingList()
        
        setupViews()
        
        title = "Shopping list"
        
        selected_items = LocalData.getShoppingList() ?? []
    }
    
    private func setupViews()
    {
        self.view.backgroundColor = MyColors.gray_light.getUIColor()
        
        self.view.addSubview(list)

        list.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
}


