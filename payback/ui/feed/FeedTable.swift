
import UIKit

protocol FeedTableDelegate: AnyObject
{
    func clickedTile(feature: ModelFeature)
}

class FeedTable: UIView
{
    weak var delegate: FeedTableDelegate?
    weak var parentController : UIViewController?
        
    var features: [ModelFeature] = [ModelFeature]()
    {
        didSet{
            tb_features.reloadData()
            showViews()
        }
    }
    
    var title: UILabel = {
        let lbl = UILabel()
        lbl.textColor = MyColors.text.getUIColor()
        lbl.numberOfLines = 0
        lbl.text = "Features"
        lbl.font = MyFonts.getInstance.reg_m
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let tb_features: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = MyColors.feed_background.getUIColor()
        tb.showsVerticalScrollIndicator = false
        tb.register(CellImage.self, forCellReuseIdentifier: CellFeature.image_reuse_id)
        tb.register(CellVideo.self, forCellReuseIdentifier: CellFeature.video_reuse_id)
        tb.register(CellWebsite.self, forCellReuseIdentifier: CellFeature.website_reuse_id)
        tb.register(CellShoppingList.self, forCellReuseIdentifier: CellFeature.shopping_list_reuse_id)
        tb.separatorColor = .none
        tb.estimatedRowHeight = 300
        
        return tb
    }()
    
    let lbl_nothing_find: UILabel = {
        let lbl = UILabel()
        lbl.textColor = MyColors.text.getUIColor()
        lbl.numberOfLines = 0
        lbl.text = "There are no features now"
        lbl.font = MyFonts.getInstance.reg_s
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    init(vc: UIViewController? = nil)
    {
        self.parentController = vc
        
        super.init(frame: .zero)
        
        setupViews()
        
        tb_features.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.backgroundColor = .clear
        
        self.addSubview(title)
        self.addSubview(tb_features)
        self.addSubview(lbl_nothing_find)
        
        title.snp.makeConstraints({ make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        })
        
        tb_features.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
            make.top.equalTo(title.snp.bottom)
        })

        lbl_nothing_find.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        })
        
        lbl_nothing_find.isHidden = true
    }
    
    public func showViews()
    {
        if features.count > 0 {
            tb_features.isHidden = false
            lbl_nothing_find.isHidden = true
        } else {
            tb_features.isHidden = true
            lbl_nothing_find.isHidden = false
        }
    }
}

extension FeedTable: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let feature = features[indexPath.row]
        
        var cell: CellFeature!
        
        if feature.isImage() {
            cell = tableView.dequeueReusableCell(withIdentifier: CellFeature.image_reuse_id) as! CellImage
            cell.bindData(feature: feature, index: indexPath.row)
        } else if feature.isVideo() {
            cell = tableView.dequeueReusableCell(withIdentifier: CellFeature.video_reuse_id) as! CellVideo
            if let cell = (cell as? CellVideo), cell.playerController == nil, self.parentController != nil {
                addPlayer(cell: cell, recipient_view: cell.video_layout, recipient_vc: self.parentController!)
            }
            cell.bindData(feature: feature, index: indexPath.row)
        } else if feature.isWebsite() {
            cell = tableView.dequeueReusableCell(withIdentifier: CellFeature.website_reuse_id) as! CellWebsite
            cell.bindData(feature: feature, index: indexPath.row)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: CellFeature.shopping_list_reuse_id) as! CellShoppingList
            cell.bindData(feature: feature, index: indexPath.row)
        }
        
        cell.delegate = self
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return features.count
    }
    
    private func addPlayer(cell: CellVideo, recipient_view: UIView, recipient_vc: UIViewController)
    {
        cell.playerController = PlayerVc()
            
        recipient_view.addSubview(cell.playerController!.view)
            
        recipient_vc.addChild(cell.playerController!)
        cell.playerController!.didMove(toParent: recipient_vc)
        
        cell.playerController!.view.snp.makeConstraints({
            make in make.edges.equalToSuperview()
        })
    }
}

extension FeedTable: CellFeatureDelegate
{
    func clickedTile(index: Int)
    {
        delegate?.clickedTile(feature: features[index])
    }
}
