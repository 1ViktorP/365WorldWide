//
//  AppDelegate.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit
import OneSignal
import FirebaseCore
import AppsFlyerLib
import AppTrackingTransparency


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        OneSignal.initWithLaunchOptions(launchOptions)
         OneSignal.setAppId("YOUR_ONESIGNAL_APP_ID")
        
      //  FirebaseApp.configure()
         
         // promptForPushNotifications will show the native iOS notification permission prompt.
         // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
         OneSignal.promptForPushNotifications(userResponse: { accepted in
           print("User accepted notifications: \(accepted)")
         })
        
        //AppsFlyer
               AppsFlyerLib.shared().appsFlyerDevKey = "devKey"
               AppsFlyerLib.shared().appleAppID = "appID"
               AppsFlyerLib.shared().isDebug = true
               AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
               AppsFlyerLib.shared().delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendLaunch),name: UIApplication.didBecomeActiveNotification, object: nil)

        return true
    }
    
    @objc func sendLaunch(app:Any) {
           
           if #available(iOS 14, *) {
               ATTrackingManager.requestTrackingAuthorization { (status) in
                   switch status {
                   case .denied:
                       print("AuthorizationSatus is denied")
                   case .notDetermined:
                       print("AuthorizationSatus is notDetermined")
                   case .restricted:
                       print("AuthorizationSatus is restricted")
                   case .authorized:
                       print("AuthorizationSatus is authorized")
                   @unknown default:
                       fatalError("Invalid authorization status")
                   }
               }
           
           AppsFlyerLib.shared().start()
       }
       
   }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: AppsFlyerLibDelegate {
        
                
    
        // Handle Organic/Non-organic installation
        func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
    
                let appsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()

        print("onConversionDataSuccess data:")
             for (key, value) in data {
                print(key, ":", value)
            }
    
            if let status = data["af_status"] as? String {
            if (status == "Non-organic") {
                    if let sourceID = data["media_source"],
                        let campaign = data["campaign"] {
                        print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                    }
                
                } else {
                    print("This is an organic install.")
                }

            }
                               
        }
    
        func onConversionDataFail(_ error: Error) {
            print("\(error)")
        }
    
}

