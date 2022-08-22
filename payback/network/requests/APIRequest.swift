
import Foundation

class APIRequest<Resource: APIResourceProtocol>
{
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}
 
extension APIRequest: NetworkRequestProtocol  
{
    typealias Response = Resource.ResponseType
    
    func execute(showErrorAlert: Bool = true, showProgress: Bool = true, onSuccess: @escaping (Resource.ResponseType?) -> Void, onError: ((Error)->Void)? = nil) {
        if showProgress {
            GlobalHelper.runWithDelay(1, completion: { [weak self] in
                if self != nil {
                    AlertsManager.getInstance.showProgressSpinner()
                }
            })
        }
        
        if let urlRequest = resource.urlRequest {
            send(
                urlRequest,
                onSuccess: { response in
                    if showProgress {
                        AlertsManager.getInstance.dismissProgressSpinner()
                    }
                    onSuccess(response)
                },
                onError: { error in

                    let error_ = error as NSError
                    
                    if NetworkProvider.isNetworkReachabilityError(error: error) {
                        DispatchQueue.main.async {
                            AlertsManager.getInstance.showTipAlert(text: "Connection lost...", name: AlertStandartTypeName.network_is_absent.rawValue, duration: 3)
                        }
                    } else if showErrorAlert {
                        DispatchQueue.main.async {
                            AlertsManager.getInstance.show(text: error_.domain, type: .alert, image: nil, name: AlertStandartTypeName.connection_error.rawValue)
                        }
                    }
                    
                    onError?(error)
                }
            )
        }
    }
        
    func decode(_ data: Data) -> Resource.ResponseType?
    {
        let decoder = GlobalHelper.globalJsonDecoder

        guard let response: Resource.ResponseType = try? decoder.decode(Resource.ResponseType.self, from: data) else {
            return nil
        }
        
        return response
    }
    
    private func showAlert(text: String, name: String)
    {
        DispatchQueue.main.async {
            AlertsManager.getInstance.show(text: text, type: .alert, image: nil, name: name)
        }
    }
}
