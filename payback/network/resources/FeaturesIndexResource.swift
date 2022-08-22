import Foundation

struct FeaturesIndexResource: APIResourceProtocol
{
    typealias ResponseType = RespFeatures

    var url = NetworkConstants.Urls.TASK_EXAMPLE
    var method = NetworkRequestMethod.GET
    var parameters: [String: String?]  = [:]
    var files: [FileUploadable] = [FileUploadable]()
}
