//
//  AppDelegate.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/8/29.
//

// com.avatarpro.morepries
// com.xx.test.888888
 
import UIKit

let purchaseUrl = ""
let PrivacyPolicyURLStr = "http://obedient-noise.surge.sh/Facial_Privacy_Policy.html"
let TermsofuseURLStr = "https://www.app-privacy-policy.com/live.php?token=m8Ym9PLa4Ogjgh74OkJjR02Vs3Qt6rTG"
let AppName: String = "AWA® AVATAR"

let AppStoreID: String = "1635885343"
let feedbackEmail: String = "anthonygri38@gmail.com"
 


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerNotifications(application)
        
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
 
        
         
    }
    
    // MARK: UISceneSession Lifecycle

    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
       
       return .portrait;
   }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
         
    }

}




extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let body = notification.request.content.body
        notification.request.content.userInfo
        print(body)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("")
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
    }
    
   
}

extension AppDelegate {
    // 注册远程推送通知
    func registerNotifications(_ application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.badge,.sound,.alert]) { (result, error) in
                    if (result) {
                        if !(error != nil) {
                            // 注册成功
                            DispatchQueue.main.async {
                                application.registerForRemoteNotifications()
                            }
                        }
                    } else {
                        //用户不允许推送
                    }
                }
            } else if (setting.authorizationStatus == .denied){
                // 申请用户权限被拒
            } else if (setting.authorizationStatus == .authorized){
                // 用户已授权（再次获取dt）
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                // 未知错误
            }
        }
    }
}

