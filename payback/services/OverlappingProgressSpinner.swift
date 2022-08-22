import UIKit

class OverlappingProgressSpinner: UIView
{
    let indicator: UIActivityIndicatorView  = BaseBlueIndicator()
    
    init()
    {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = MyColors.black.getUIColor().withAlphaComponent(0.3)
        self.addSubview(indicator)
        
        self.snp.makeConstraints({ make in
            make.width.equalTo(GlobalHelper.getScreenWidth())
            make.height.equalTo(GlobalHelper.getScreenHeight())
        })
        
        indicator.snp.remakeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        })
        
        indicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BaseBlueIndicator: UIActivityIndicatorView
{
    init()
    {
        super.init(frame: CGRect.zero)
        
        self.style = .large
        self.color = MyColors.text.getUIColor()
        
        self.snp.makeConstraints({ make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
