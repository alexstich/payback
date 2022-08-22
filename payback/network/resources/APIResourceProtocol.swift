import Foundation

protocol APIResourceProtocol
{
    associatedtype ResponseType: Codable
    
    var url:               String { get set }
    var method:             NetworkRequestMethod { get set }
    var parameters:         [String: String?] { get set }
    var files:              [FileUploadable] { get set }
}
 
extension APIResourceProtocol
{
    var urlRequest: URLRequest?
    {
        return getUrlRequest()
    }
    
    private func getUrlRequest() -> URLRequest?
    {
        guard let url = URL(string: url) else { return nil }
        
        var request: URLRequest
        
        if method == .GET {
            
            request = URLRequest(url: url)
            self.setGetParams(request: &request)
            
        } else {
            
            request = URLRequest(
                multipartFormData: { (formData) in
    
                    for file in files {
                        formData.append(file: file.data, name: file.name, fileName: file.fileName , mimeType: file.mimeType)
                    }
                        
                    var parametersFiltered: [String: String] = [:]
                    self.parameters.forEach{ if $1 != nil { parametersFiltered[$0] = $1! } }
                    for (key, parameter) in parametersFiltered {
                        formData.append(value: parameter, name: key)
                    }
                },
                url: url,
                method: .post,
                headers: [:]
            )
        }
        
        request.httpMethod = method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    private func setGetParams(request: inout URLRequest)
    {
        var parametersFiltered: [String: String] = [:]
        
        parameters.forEach{ if $1 != nil { parametersFiltered[$0] = $1! } }
        
        let queryParams = parameters.map {
            URLQueryItem(name: String($0), value: String($1!))
        }
        
        var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
        components.queryItems = []
        components.queryItems!.append(contentsOf: queryParams)
        
        request.url = components.url
    }
}
