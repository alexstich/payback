import UIKit
import SnapKit

class CellItem: UITableViewCell
{
    static let reuse_id = "CellItem"
        
    let itemDefaultHeight: CGFloat = 60
    var cellHeightConstraint: Constraint?
        
    let item_lbl: UILabel = {
        
        let label = UILabel()
        label.text = nil
        label.textColor = MyColors.text.getUIColor()
        label.font = MyFonts.getInstance.bold_m
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let divider = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        self.selectionStyle = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.bringSubviewToFront(item_lbl)
    }
    
    override func prepareForReuse()
    {
        self.item_lbl.text = nil

        super.prepareForReuse()
    }
    
    func setupViews()
    {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(item_lbl)
        self.contentView.addSubview(divider)
        
        divider.backgroundColor = MyColors.gray.getUIColor()
        
        item_lbl.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            cellHeightConstraint = make.height.equalTo(itemDefaultHeight).constraint
        })
        
        divider.snp.makeConstraints({ make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-0.5)
            make.height.equalTo(0.5)
        })
    }
    
    func bindData(item: String)
    {
        self.item_lbl.text = item
        
        item_lbl.sizeToFit()
        
        if item_lbl.intrinsicContentSize.height > itemDefaultHeight {
            cellHeightConstraint?.layoutConstraints.first?.constant = item_lbl.intrinsicContentSize.height
        } else {
            cellHeightConstraint?.layoutConstraints.first?.constant = itemDefaultHeight
        }
        
        item_lbl.setNeedsLayout()
    }
}
