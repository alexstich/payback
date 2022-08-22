import Foundation
import UIKit

enum MyColors: String
{
    case feed_background
    case text
    case tile_background
    
    case black
    case gray
    case gray_light
    case white
    
    case alert_background
    case warning_background
    case info_background
    
    func getUIColor() -> UIColor
    {
        guard let color = UIColor(named: self.rawValue) else {
            fatalError("**** Error cant create Font ****")
        }
        
        return color
    }
    
    func getCGColor() -> CGColor
    {
        guard let color = UIColor(named: self.rawValue)?.cgColor else {
            fatalError("**** Error cant create Font ****")
        }
        
        return color
    }
}
