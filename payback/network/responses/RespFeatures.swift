
import Foundation

class RespFeatures: Decodable, Encodable
{
    var features: [ModelFeature]?
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        features = try? values.decodeArray(type: ModelFeature.self, from: .features)
    }

    private enum CodingKeys: String, CodingKey
    {
        case features = "tiles"
    }
}
