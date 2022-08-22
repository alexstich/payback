
import Foundation
import UIKit

struct ImageDownloadResource: ResourceProtocol 
{
    typealias ResponseType = UIImage

    var url: String
    var method = NetworkRequestMethod.GET
    var parameters: [String: String?]  = [:]
    var files: [FileUploadable]  = [FileUploadable]()
    var cachePolicy: URLRequest.CachePolicy? = .returnCacheDataElseLoad
    
    init(url: String)
    {
        self.url = url
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
