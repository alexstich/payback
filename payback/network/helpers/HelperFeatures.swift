
import Foundation

extension NetworkProvider
{
    public func getFeatures(onSuccess: ((RespFeatures?)->())?, onError: ((Error)->())? = nil)
    {
        let resource = FeaturesIndexResource()
        self.makeAPIRequest(resource: resource, onSuccess: onSuccess, onError: onError)
    }
}
