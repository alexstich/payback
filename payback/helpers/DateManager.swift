import Foundation

class DateManager
{
    static let FORMAT_AS_SERVER = "yyyy-MM-dd HH:mm:ss"
    static let FORMAT_EXIF = "yyyy:MM:dd HH:mm:ss"
    static let FORMAT_SHORT = "yyyy-MM-dd"
    static let FORMAT_SHORT_DOT = "d.MM.yyyy"
    static let FORMAT_SHORT_DOT_ = "dd.MM.yyyy"
    static let FORMAT_FOR_DISPLAY = "dd MMMM yyyy"
    static let FORMAT_FOR_DISPLAY_SHORT_MONTH = "dd MMM yyyy"
    static let FORMAT_MONTH_YEAR = "MMMM yyyy"
    static let FORMAT_YEAR = "yyyy"
    static let FORMAT_HOUR = "H:mm"
    
    static let ALL_FORMATS =
        [
            FORMAT_AS_SERVER,
            FORMAT_EXIF,
            FORMAT_SHORT,
            FORMAT_SHORT_DOT,
            FORMAT_SHORT_DOT_,
            FORMAT_FOR_DISPLAY,
            FORMAT_FOR_DISPLAY_SHORT_MONTH,
            FORMAT_MONTH_YEAR,
            FORMAT_YEAR,
            FORMAT_HOUR
    ]
}
