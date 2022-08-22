
import Foundation
import UIKit

struct FileDownloadResource: ResourceProtocol
{
    typealias ResponseType = Data

    var url: String
    var method = NetworkRequestMethod.GET
    var parameters: [String: String?]  = [:]
    var files: [FileUploadable]  = [FileUploadable]()
    var cachePolicy: URLRequest.CachePolicy? = .returnCacheDataElseLoad
    
    init(url: String)
    {
        self.url = url
    }
    
    func decode(_ data: Data) -> Data? {
        return data
    }
}
