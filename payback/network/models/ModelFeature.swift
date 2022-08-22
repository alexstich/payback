
struct ModelFeature: Decodable, Encodable
{
    enum FeatureType: String
    {
        case shopping_list
        case image
        case video
        case website
    }
        
    var score: Int?
    var name: String?
    var headline: String?
    var subline: String?
    var data: String?

    
    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try? container.decodeString(from: .name)
        headline = try? container.decodeString(from: .headline)
        subline = try? container.decodeString(from: .subline)
        data = try? container.decodeString(from: .data)
        score = try? container.decodeInt(from: .score)
    }

    enum CodingKeys: String, CodingKey
    {
        case name
        case headline
        case subline
        case data
        case score
    }
    
    public func isImage() -> Bool
    {
        return name == FeatureType.image.rawValue
    }
    
    public func isVideo() -> Bool
    {
        return name == FeatureType.video.rawValue
    }
    
    public func isWebsite() -> Bool
    {
        return name == FeatureType.website.rawValue
    }
    
    public func isShoppingList() -> Bool
    {
        return name == FeatureType.shopping_list.rawValue
    }
}
