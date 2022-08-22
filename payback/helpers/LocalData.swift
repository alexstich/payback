import Foundation

enum LocalKeys: String
{
    case ShoppingList
    case LastUpdatingDate
}

class LocalData
{
    static func saveToShoppingList(items: [String])
    {
        UserDefaults.standard.set(items, forKey: LocalKeys.ShoppingList.rawValue)
    }
    
    static func getShoppingList() -> [String]?
    {
        guard UserDefaults.standard.hasKey(key: LocalKeys.ShoppingList.rawValue)  else { return nil }
        
        return UserDefaults.standard.stringArray(forKey: LocalKeys.ShoppingList.rawValue)
    }
    
    static func saveLastUpdatingDate(date: String)
    {
        UserDefaults.standard.set(date, forKey: LocalKeys.LastUpdatingDate.rawValue)
    }
    
    static func getLastUpdatingDate() -> String?
    {
        guard UserDefaults.standard.hasKey(key: LocalKeys.LastUpdatingDate.rawValue)  else { return nil }
        
        return UserDefaults.standard.string(forKey: LocalKeys.LastUpdatingDate.rawValue)
    }
    
    static func clear_user_data()
    {
        UserDefaults.standard.removeObject(forKey: LocalKeys.ShoppingList.rawValue)
    }
}
