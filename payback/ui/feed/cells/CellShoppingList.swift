
import UIKit
import Kingfisher
import SnapKit

class CellShoppingList: CellFeature
{
    let lbl: UILabel =
    {
        let label = UILabel()
        label.text = "Add item"
        label.textColor = MyColors.text.getUIColor()
        label.font = MyFonts.getInstance.bold_m
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews()
    {
        super.setupViews()
        
        btn.addSubview(lbl)
        
        lbl.snp.makeConstraints({ make in
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(subline.snp.top)
            make.left.right.equalToSuperview()
        })
    }
}
