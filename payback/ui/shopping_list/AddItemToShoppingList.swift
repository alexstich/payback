
import Foundation
import UIKit

class AddItemToShoppingList: UIView
{
    var selected_items: [String] = []
    {
        didSet{
            tb_items.reloadData()
        }
    }

    let text_view: UITextView = {
        let view = UITextView()
        view.textColor = MyColors.black.getUIColor()
        view.font = MyFonts.getInstance.reg_m
        view.textAlignment = .left
        view.contentInset = UIEdgeInsets(top: 3, left: 5, bottom: 0, right: 0)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = MyColors.gray_light.getCGColor()
        view.showsVerticalScrollIndicator = true
        
        return view
    }()
    
    let btn_add_item: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(MyColors.text.getUIColor(), for: .normal)
        btn.setTitle("Add item", for: .normal)
        btn.layer.borderColor = MyColors.text.getCGColor()
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.white.getUIColor()
        return btn
    }()
    
    let tb_items: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = MyColors.white.getUIColor()
        tb.showsVerticalScrollIndicator = false
        tb.register(CellItem.self, forCellReuseIdentifier: CellItem.reuse_id)
        tb.separatorStyle = .none
        tb.estimatedRowHeight = 300
        
        return tb
    }()
    
    
    init()
    {
        super.init(frame: .zero)
        
        tb_items.dataSource = self
        
        setupViews()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.backgroundColor = .clear
        
        self.addSubview(text_view)
        self.addSubview(btn_add_item)
        self.addSubview(tb_items)

        text_view.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(25)
            make.height.equalTo(50)
        })
        
        btn_add_item.snp.makeConstraints({ make in
            make.top.equalTo(text_view.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        })

        tb_items.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(btn_add_item.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
        })
    }
    
    private func addActions()
    {
        btn_add_item.removeTarget(self, action: #selector(addItem), for: .touchUpInside)
        btn_add_item.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    }
    
    @objc func addItem()
    {
        if text_view.text != nil && text_view.text != "" {
            selected_items.insert(text_view.text, at: 0)
            text_view.text = nil
            
            LocalData.saveToShoppingList(items: selected_items)
        }
    }
}

extension AddItemToShoppingList: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let item = selected_items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellItem.reuse_id) as! CellItem
        cell.bindData(item: item)
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return selected_items.count
    }
}
