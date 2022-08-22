import UIKit
import SnapKit
import AVKit

protocol CellFeatureDelegate: AnyObject
{
    func clickedTile(index: Int)
}

class CellFeature: UITableViewCell
{
    static let image_reuse_id = "CellImage"
    static let video_reuse_id = "CellVideo"
    static let website_reuse_id = "CellWebsite"
    static let shopping_list_reuse_id = "CellShoppingList"
    
    weak var delegate: CellFeatureDelegate? = nil
    
    let tiledefaultHeight: CGFloat = 250
    let headerdefaultHeight: CGFloat = 50
    let sublinedefaultHeight: CGFloat = 50
    var headerHeightConstraint: Constraint!
    var sublineHeightConstraint: Constraint!
    
    var feature: ModelFeature!
    var index: Int!
    
    let btn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleLabel?.text = ""
        btn.backgroundColor = MyColors.tile_background.getUIColor()
        return btn
    }()
    
    let header: UILabel = {
        
        let label = UILabel()
        label.text = nil
        label.textColor = MyColors.text.getUIColor()
        label.font = MyFonts.getInstance.bold_m
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let top_divider: UIView = {
        let view = UIView()
        view.backgroundColor = MyColors.gray.getUIColor()
        return view
    }()
    
    let subline: UILabel = {
        
        let label = UILabel()
        label.text = nil
        label.textColor = MyColors.text.getUIColor()
        label.font = MyFonts.getInstance.reg_s
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let bottom_divider: UIView = {
        let view = UIView()
        view.backgroundColor = MyColors.gray.getUIColor()
        return view
    }()

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
        self.bringSubviewToFront(btn)
    }
    
    override func prepareForReuse()
    {
        self.header.text = nil
        self.subline.text = nil

        super.prepareForReuse()
    }
    
    func setupViews()
    {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(btn)
        
        btn.addSubview(header)
        btn.addSubview(top_divider)
        btn.addSubview(subline)
        btn.addSubview(bottom_divider)
        
        btn.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.bottom.equalTo(subline.snp.bottom)
            make.height.equalTo(320)
        })
        
        header.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.top.equalToSuperview()
            headerHeightConstraint = make.height.equalTo(headerdefaultHeight).constraint
        })
        
        top_divider.snp.makeConstraints({ make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(header.snp.bottom)
            make.height.equalTo(0.5)
        })
        
        subline.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview()
            sublineHeightConstraint = make.height.equalTo(sublinedefaultHeight).constraint
        })
        
        bottom_divider.snp.makeConstraints({ make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(subline.snp.top)
            make.height.equalTo(0.5)
        })
    }
    
    func bindData(feature: ModelFeature, index: Int)
    {
        self.feature = feature
        self.index = index
        
        if feature.headline != nil && feature.headline != "" {
            header.text = feature.headline
            top_divider.isHidden = false
            headerHeightConstraint.layoutConstraints.first?.constant = 50
        } else {
            top_divider.isHidden = true
            headerHeightConstraint.layoutConstraints.first?.constant = 0
        }
        
        if feature.subline != nil && feature.subline != "" {
            subline.text = feature.subline
            bottom_divider.isHidden = false
            headerHeightConstraint.layoutConstraints.first?.constant = 50
        } else {
            bottom_divider.isHidden = true
            sublineHeightConstraint.layoutConstraints.first?.constant = 0
        }
        
        btn.removeTarget(self, action: #selector(clickedTile), for: .touchUpInside)
        btn.addTarget(self, action: #selector(clickedTile), for: .touchUpInside)
    }
    
    @objc func clickedTile()
    {
        delegate?.clickedTile(index: index)
    }
}
