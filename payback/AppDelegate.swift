
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window:             UIWindow?
    var appCoordinator:     AppCoordinator!

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        appCoordinator = AppCoordinator(window: window!, launch_options: launchOptions)
        appCoordinator.start()

        return true
    }

}

//MARK: -Foreground Background
extension AppDelegate
{
    func applicationDidBecomeActive(_ application: UIApplication)
    {

    }
}

//MARK: -Get AppDelegate instance
extension AppDelegate {
    static var getInstance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

//MARK: -Get App version
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}


