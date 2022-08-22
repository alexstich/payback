import Foundation
import LightboxV2

class ImageViewer
{
    weak var presented_vc: UIViewController?
    
    var images_: [LightboxImage] = [LightboxImage]()
    var first_page: Int? = nil
    
    init(presented_vc: UIViewController, images_urls: [URL], image_index_to_show: Int?)
    {
        self.presented_vc = presented_vc
        
        for url_ in images_urls {
            images_.append(LightboxImage(imageURL: url_))
        }
        
        if image_index_to_show != nil && image_index_to_show! < images_urls.count {
            first_page = image_index_to_show
        }
    }
    
    init(presented_vc: UIViewController, images: [UIImage], image_index_to_show: Int?)
    {
        self.presented_vc = presented_vc
        
        for image in images {
            images_.append(LightboxImage(image: image))
        }
        if image_index_to_show != nil && image_index_to_show! < images_.count {
            first_page = image_index_to_show
        }
    }
    
    public func showViewer()
    {
        guard images_.count > 0, presented_vc != nil else { return }
              
        LightboxConfig.DeleteButton.enabled = false
        LightboxConfig.EditButton.enabled = false
        
        LightboxConfig.DeleteButton.size = CGSize(width: 0, height: 0)
        LightboxConfig.EditButton.size = CGSize(width: 0, height: 0)
        LightboxConfig.DeleteButton.text = ""
        LightboxConfig.EditButton.text = ""
        LightboxConfig.CloseButton.text = "Close"
        
        let controller = LightboxController(images: images_)

        controller.modalPresentationStyle = .fullScreen
        controller.dynamicBackground = true
        
        if first_page != nil {
            controller.goTo(first_page!)
        }

        presented_vc?.present(controller, animated: true, completion: nil)
    }
}
