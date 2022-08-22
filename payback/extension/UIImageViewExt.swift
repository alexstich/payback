import UIKit
import Kingfisher

extension UIImageView
{
    func download(
        url_string: String,
        show_indicator: Bool,
        onSuccess: (()->Void)?,
        onError: (()->Void)?
    )
    {
        let url = URL(string: url_string)
    
        if show_indicator {
            self.kf.indicatorType = .activity
        }

        self.kf.setImage(
            with: url,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage,
                .memoryCacheExpiration(.never),
            ], completionHandler:
                {
                    result in
                    switch result {
                    case .success(_):
                        onSuccess?()
                    case .failure(_):
                        onError?()
                    }
                }
        )
    }
}

