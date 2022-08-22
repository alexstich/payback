import Foundation
import UIKit

class AlertView: UIView 
{
    let color_bg:   UIColor
    let image:      UIImage?
    let text:       String
    
    static let image_size:      CGFloat = 32
    static let bottom_offset:   CGFloat = 15
    static let top_offset:      CGFloat = 15
    static let side_offset:     CGFloat = 15
    
    let imageView: UIImageView =
    {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    
    let lbl_text: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.white.getUIColor()
        lbl.numberOfLines = 0
        lbl.font = MyFonts.getInstance.reg_s
        return lbl
    }()
    
    init(image: UIImage? = nil, text: String, type: AlertType)
    {
        self.image = image
        self.text = text
        self.color_bg = type.getBackgroundColor()
        
        super.init(frame: CGRect.zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()
    {
        self.addSubview(lbl_text)
        self.addSubview(imageView)
        
        lbl_text.snp.makeConstraints({ make in
            
            if self.image != nil {
                let lbl_width = UIScreen.main.bounds.width - (AlertView.image_size + AlertView.side_offset * 2 + 10)
                make.width.equalTo(lbl_width)
                make.left.equalToSuperview().offset(AlertView.image_size + AlertView.side_offset + 10)
            } else {
                let lbl_width = UIScreen.main.bounds.width - (AlertView.side_offset * 2 + 10)
                make.width.equalTo(lbl_width)
                make.centerX.equalToSuperview()
            }
            
            make.bottom.equalToSuperview().offset(-AlertView.bottom_offset)
        })
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        lbl_text.attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor: MyColors.white.getUIColor(),
                NSAttributedString.Key.font: MyFonts.getInstance.reg_s
            ]
        )
        lbl_text.sizeToFit()
        
        if self.image != nil {
            
            imageView.isHidden = false
            
            imageView.image = image
            
            imageView.snp.makeConstraints({ make in
                make.width.height.equalTo(AlertView.image_size)
                make.centerY.equalTo(lbl_text.snp.centerY)
                make.left.equalToSuperview().offset(AlertView.side_offset)
            })
            
            imageView.layoutIfNeeded()
            
            UIView.animate(
                withDuration: 0.0,
                animations: {},
                completion: { [weak self] _ in
                    UIView.animate(
                        withDuration: 0.8,
                        delay: 0.0,
                        options: [.autoreverse, .repeat],
                        animations: { [weak self] in
                            let scale = CGAffineTransform(scaleX: 1.3, y: 1.3)
                            self?.imageView.transform = scale
                        },
                        completion: nil
                    )
                }
            )
        } else {
            imageView.isHidden = true
        }
    }
    
    func getAlertViewHeight() -> CGFloat
    {
        lbl_text.layoutIfNeeded()
        lbl_text.sizeToFit()
        lbl_text.layoutIfNeeded()
        
        return lbl_text.frame.height + AlertView.bottom_offset + AlertView.top_offset + GlobalHelper.statusBarHeight
    }
}
