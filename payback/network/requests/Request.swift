
import Foundation
import UIKit

class Request<Resource: ResourceProtocol>
{
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension Request: NetworkRequestProtocol
{
    typealias Response = Resource.ResponseType

    func execute(
        showErrorAlert: Bool,
        showProgress: Bool,
        onSuccess: @escaping (Resource.ResponseType?) -> Void,
        onError: ((Error)->Void)?
    ) {
        if let request = resource.urlRequest {
            self.send(request, onSuccess: onSuccess, onError: onError)
        }
    }

    func decode(_ data: Data) -> Response?
    {
        return self.resource.decode(data)
    }
    
    func getError(response: Resource.ResponseType) -> Error?
    {
        return nil
    }
}
