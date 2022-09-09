//
//  SceneDelegate.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/8/29.
//

import UIKit
import AppTrackingTransparency

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainVC: AHaniHomeVC = AHaniHomeVC()

    func initMainVC() {
        let nav = UINavigationController.init(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        #if DEBUG
        for fy in UIFont.familyNames {
            let fts = UIFont.fontNames(forFamilyName: fy)
            for ft in fts {
                debugPrint("***fontName = \(ft)")
            }
        }
        #endif
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         
        guard let _ = (scene as? UIWindowScene) else { return }
        initMainVC()
     
    }
    
      func appTrackingPermission() {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              if #available(iOS 14, *) {
                  ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                      
                  })
              } else {
                  
              }
          }
      }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
 
        
        appTrackingPermission()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
         
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
         
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
         
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
         
    }
}


