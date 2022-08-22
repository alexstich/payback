import Foundation

enum NetworkRequestMethod: String
{
    case GET, POST
}

protocol NetworkRequestProtocol: AnyObject
{
    associatedtype Response
    
    func decode(_ data: Data) -> Response?
    func execute(showErrorAlert: Bool, showProgress: Bool, onSuccess: @escaping (Response?) -> Void, onError: ((Error)->Void)?)
}

extension NetworkRequestProtocol
{
    public func send(_ urlRequest: URLRequest, onSuccess: @escaping (Response?) -> Void, onError: ((Error)->Void)? = nil)
    {
        print("**** Will make request to url \(String(describing: urlRequest.url?.absoluteURL))")
        print("**** Body \(String(describing: urlRequest.httpBody))")
        
        var urlRequest = urlRequest
        
        urlRequest.addValue("ios", forHTTPHeaderField: "App-Client")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) -> Void in
            
            // Terminal Log
            print("**** Get response! url - \(String(describing: urlRequest.url?.absoluteURL)) ****")
            
            if error != nil {
                let errorString = String(error!.localizedDescription)
                print("***** Error \n \(errorString)")
                DispatchQueue.main.async {
                    if onError != nil {
                        onError!(error!)
                    } else {
                        onSuccess(nil)
                    }
                }
                return
            }

            guard let data_ = data, let result = self.decode(data_) else {
                let error = NSError(domain: "Load error occured", code: 422)
                DispatchQueue.main.async {
                    if onError != nil {
                        onError!(error)
                    } else {
                        onSuccess(nil)
                    }
                }
                return
            }
            
            DispatchQueue.main.async { onSuccess(result) }
        }
        task.resume()
    }
}
