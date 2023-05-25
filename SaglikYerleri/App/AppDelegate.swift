//
//  AppDelegate.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import Firebase
import GoogleSignIn
import RevenueCat
import FirebaseAuth
import FirebaseAnalytics
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()
        googleSingInFlow()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: IAPConstants.revenueCatApiKey.rawValue)
            
        //MARK: - Revenuecat in app purchase with firebase
        Auth.auth().addStateDidChangeListener { auth, user in
            if let uid = user?.uid {
                
                // yeni firebase kullanıcısıyla satın alma sdksi tanımla
                Purchases.shared.logIn(uid) { customerInfo, created, error in
                    if let error = error {
                        print("Giriş hatası: \(error.localizedDescription)")
                    } else {
                        print("Kullanıcı \(uid) giriş yaptı")
                    }
                }
            }
        }
        
        let instanceID = Analytics.appInstanceID()
        
        if let unwrappedID = instanceID {
            print("Instance ID -> " + unwrappedID);
                 print("Setting Attributes");
               Purchases.shared.attribution.setFirebaseAppInstanceID(unwrappedID)
        } else {
            print("Instance ID -> NOT FOUND!");
         }
        
        Purchases.shared.attribution.setFirebaseAppInstanceID(Analytics.appInstanceID())
        
        //MARK: - Configure Push Notification
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { isSuccess, error in
            guard isSuccess, error == nil else { return }
            if isSuccess {
                print("Success in APNS registry")

            } else {
                print("Unsuccess in APNS registry")
            }
            
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, error in
            guard let token, error == nil else { return }
            print("Token\(token)")
        }
    }
    
    private func googleSingInFlow() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
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

