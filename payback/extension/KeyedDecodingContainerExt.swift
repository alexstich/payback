
extension KeyedDecodingContainer where Key: CodingKey
{
    func decodeObject<T: Codable>(type: T.Type, from key: Key) throws -> T?
    {
        let object = try decode(T.self, forKey: key)
        
        return object
    }
    
    func decodeArray<T: Codable>(type: T.Type, from key: Key) throws -> [T]?
    {
        let arr = try decode([T].self, forKey: key)
        
        return arr
    }
    
    func decodeInt(from key: Key) throws -> Int?
    {
        let num = try? decode(Int.self, forKey: key)
        
        if num != nil {
            return num
        } else {
            let num_as_str = try? decode(String.self, forKey: key)
            
            if num_as_str != nil {
                return Int(num_as_str!)
            }
        }
        
        return nil
    }
    
    func decodeDouble(from key: Key) throws -> Double?
    {
        return try decode(Double.self, forKey: key)
    }
    
    func decodeFloat(from key: Key) throws -> Float?
    {
        return try decode(Float.self, forKey: key)
    }
    
    func decodeString(from key: Key) throws -> String?
    {
        return try decode(String.self, forKey: key)
    }
    
    func decodeBool(from key: Key) throws -> Bool?
    {
        return try decode(Bool.self, forKey: key)
    }
}
