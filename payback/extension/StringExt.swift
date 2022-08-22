import Foundation

extension String
{
    func convertToDate(format: String = DateManager.FORMAT_AS_SERVER) throws -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            return date
        }
        
        for i in 0..<DateManager.ALL_FORMATS.count {
            let format = DateManager.ALL_FORMATS[i]
            dateFormatter.dateFormat = format
            
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }
        
        return nil
    }
}
