import Foundation

extension Date
{
    func formatToString(format: String = DateManager.FORMAT_FOR_DISPLAY_SHORT_MONTH, timeZone: TimeZone? = nil) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        
        if timeZone == nil {
            dateFormatter.timeZone = .current
        } else {
            dateFormatter.timeZone = timeZone
        }
        
        return dateFormatter.string(from: self)
    }
    
    func addDays(days: Int) -> Date
    {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func addMonth(months: Int) -> Date
    {
        return Calendar.current.date(byAdding: .month, value: months, to: self)!
    }
    
    static func get_milliseconds_since1970()->UInt64
    {
        let timestamp = UInt64(floor(Date().timeIntervalSince1970 * 1000))
        return timestamp
    }
    
    func currentTimeMillis() -> Int64
    {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
