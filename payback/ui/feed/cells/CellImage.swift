
import UIKit
import Kingfisher
import SnapKit

class CellImage: CellFeature
{
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = MyColors.gray_light.getUIColor()
        return image
    }()

    override func prepareForReuse()
    {
        self.image.image = nil
        
        super.prepareForReuse()
    }
    
    override func setupViews()
    {
        super.setupViews()
        
        btn.addSubview(image)
        
        image.snp.makeConstraints({ make in
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(subline.snp.top)
            make.left.right.equalToSuperview()
        })
    }
    
    override func bindData(feature: ModelFeature, index: Int)
    {
        super.bindData(feature: feature, index: index)
        
        image.download(
            url_string: feature.data!,
            show_indicator: true,
            onSuccess: nil,
            onError: nil
        )
    }
}
