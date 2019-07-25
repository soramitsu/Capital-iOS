import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])

        let demoListViewController = DemoListViewController(nibName: "DemoListViewController", bundle: nil)
        demoListViewController.title = "Demo List"
        demoListViewController.demoList = [DefaultDemo()]

        let navigationController = UINavigationController(rootViewController: demoListViewController)

        window = UIWindow()
        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()

        return true
    }
}
