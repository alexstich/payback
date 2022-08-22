import Foundation

extension UserDefaults
{
    func hasKey(key: String) -> Bool
    {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
