
import UIKit
import MobileCoreServices

class GlobalHelper: NSObject
{    
    static var statusBarHeight: CGFloat
    {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static func runWithDelay(_ delayInSeconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            completion()
        }
    }
    
    static var actionOpenUrl: (String) -> Void = { url_str in
        
        if let url = URL(string: url_str) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func getNavBarHeight() -> CGFloat
    {
        if let nav_vc =  UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            let navbar = nav_vc.navigationBar
            return navbar.frame.height
        }
        
        return 0
    }
    
    static func hasBottomButton() -> Bool
    {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.keyWindow!.safeAreaInsets.bottom > CGFloat(0) {
                return false
            }
            
            return true
        }
        
        return true
    }
    
    static func getMimeTypeForPath(path: String) -> String
    {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        
        return "application/octet-stream"
    }
    
    static func moveControllerOnTop<T>(type: T.Type) -> UIViewController?
    {
        var resultController: UIViewController? = nil
        var index: Int? = nil
        
        let topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        
        if let _navController = topController as? UINavigationController, _navController.viewControllers.count > 0 {
            
            for (index_, controller) in _navController.viewControllers.enumerated() {
                if controller is T {
                    index = index_
                    resultController = controller
                }
            }
            
            if index != nil {
                _navController.popToViewController(resultController!, animated: false)
            }
        }
        
        return resultController
    }
    
    static func getStackOfControllers() -> [UIViewController]?
    {
        var controllers: [UIViewController]? = nil
        
        let topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        
        if let _navController = topController as? UINavigationController {
            controllers = _navController.viewControllers
        }
        
        return controllers
    }
    
    static func getTopController() -> UIViewController
    {
        var topController: UIViewController?
        
        if #available(iOS 15.0, *) {
            topController = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController
        } else {
            topController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        
        if let _navController = topController as? UINavigationController {
            topController = _navController.viewControllers.last
        }
        
        return topController!
    }
    
    static func topControllerIs<T>(type: T.Type) -> Bool
    {
        var topController: UIViewController?
        
        if #available(iOS 15.0, *) {
            topController = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController
        } else {
            topController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        
        if let _navController = topController as? UINavigationController {
            topController = _navController.viewControllers.last
        }
        
        return topController! is T
    }
    
    static var isDeviceIpad:Bool
    {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        } else {
            return false
        }
    }
    
    static var globalJsonDecoder: JSONDecoder =
    {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }()
    
    static var globalJsonEncoder : JSONEncoder =
    {
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        return encoder
    }()
    
    static func getFileCreationDate(url: URL) -> Date?
    {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            
            return attr[FileAttributeKey.creationDate] as? Date
        } catch {
            
            return nil
        }
    }
    
    static func getScreenWidth() -> CGFloat
    {
        return UIScreen.main.bounds.width
    }

    static func getScreenHeight() -> CGFloat
    {
        return UIScreen.main.bounds.height
    }
}

