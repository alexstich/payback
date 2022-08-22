import UIKit

enum FontName: String
{
    case regular = "OpenSans-Regular"
    case bold = "OpenSans-Bold"
}

enum FontSize: CGFloat
{
    case xxxs = 9.5
    case xxs = 10.5
    case xs = 14
    case s = 16
    case m = 18
    case l = 22
    case xl = 25
    case xxl = 28
    case xxxl = 36
}

class MyFonts
{
    static let getInstance = MyFonts()
    
    func getFont(font_name: FontName, font_size: FontSize) -> UIFont
    {
        guard let font = UIFont(name: font_name.rawValue, size: font_size.rawValue) else {
            fatalError("**** Error cant create Font ****")
        }
        return font
    }
    
    let reg_xxxs = UIFont(name: FontName.regular.rawValue, size: FontSize.xxxs.rawValue)!
    let reg_xxs = UIFont(name: FontName.regular.rawValue, size: FontSize.xxs.rawValue)!
    let reg_xs = UIFont(name: FontName.regular.rawValue, size: FontSize.xs.rawValue)!
    let reg_s = UIFont(name: FontName.regular.rawValue, size: FontSize.s.rawValue)!
    let reg_m = UIFont(name: FontName.regular.rawValue, size: FontSize.m.rawValue)!
    let reg_l = UIFont(name: FontName.regular.rawValue, size: FontSize.l.rawValue)!
    let reg_xl = UIFont(name: FontName.regular.rawValue, size: FontSize.xl.rawValue)!
    let reg_xxl = UIFont(name: FontName.regular.rawValue, size: FontSize.xxl.rawValue)!
    let reg_xxxl = UIFont(name: FontName.regular.rawValue, size: FontSize.xxxl.rawValue)!
    
    let bold_xxxs = UIFont(name: FontName.bold.rawValue, size: FontSize.xxxs.rawValue)!
    let bold_xxs = UIFont(name: FontName.bold.rawValue, size: FontSize.xxs.rawValue)!
    let bold_xs = UIFont(name: FontName.bold.rawValue, size: FontSize.xs.rawValue)!
    let bold_s = UIFont(name: FontName.bold.rawValue, size: FontSize.s.rawValue)!
    let bold_m = UIFont(name: FontName.bold.rawValue, size: FontSize.m.rawValue)!
    let bold_l = UIFont(name: FontName.bold.rawValue, size: FontSize.l.rawValue)!
    let bold_xl = UIFont(name: FontName.bold.rawValue, size: FontSize.xl.rawValue)!
    let bold_xxl = UIFont(name: FontName.bold.rawValue, size: FontSize.xxl.rawValue)!
    let bold_xxxl = UIFont(name: FontName.bold.rawValue, size: FontSize.xxxl.rawValue)!
}
