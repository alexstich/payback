
import Foundation
import UIKit

class NetworkProvider
{
    var showProgress: Bool!
    var showErrorAlert: Bool!
    var repeatWhenAvailable: Bool!
    
    required init(showProgress: Bool = true, showErrorAlert: Bool = true)
    {
        self.showProgress = showProgress
        self.showErrorAlert = showErrorAlert
    }
    
    public func downloadImage(
        urlString: String,
        onSuccess: ((UIImage?)->())?,
        onError: ((Error)->Void)? = nil
    )
    {
        let resource = ImageDownloadResource(url: urlString)
        self.makeRequest(resource: resource, onSuccess: onSuccess, onError: onError)
    }
    
    public func downloadFile(
        urlString: String,
        onSuccess: ((Data?)->())?,
        onError: ((Error)->Void)? = nil
    )
    {
        let resource = FileDownloadResource(url: urlString)
        self.makeRequest(resource: resource, onSuccess: onSuccess, onError: onError)
    }
    
    public func makeAPIRequest<Resource: APIResourceProtocol>(
        resource: Resource,
        onSuccess: ((Resource.ResponseType?)->Void)?,
        onError: ((Error)->Void)? = nil
    )
    {
        let request = APIRequest(resource: resource)
        
        request.execute(
            showErrorAlert: showErrorAlert,
            showProgress: showProgress,
            onSuccess: { response in
                onSuccess?(response)
            },
            onError: { error in
                onError?(error)
            }
        )
    }
    
    public func makeRequest<Resource: ResourceProtocol>(
        resource: Resource,
        onSuccess: ((Resource.ResponseType?)->Void)?,
        onError: ((Error)->Void)? = nil
    )
    {
        let request = Request(resource: resource)

        request.execute(
            showErrorAlert: showErrorAlert,
            showProgress: showProgress,
            onSuccess: { response in
                onSuccess?(response)
            },
            onError: { error in
                onError?(error)
            }
        )
    }
    
    static public func isNetworkReachabilityError(error: Error) -> Bool
    {
        let error_ = error as NSError
        
        return error_.code == 421 ||
            error_.code == NSURLErrorNotConnectedToInternet ||
            error_.code == NSURLErrorCannotFindHost ||
            error_.code == NSURLErrorCannotConnectToHost ||
            error_.code == NSURLErrorNetworkConnectionLost
    }
}

