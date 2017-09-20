//
//  AppDelegate.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 5/8/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
//import FirebaseInstanceID
//import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router?
    var pushNotificationRegisterResponse: PushNotificationRegisterResponse?
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let notificationRegister = NotificationRegister(application: application)
        pushNotificationRegisterResponse = notificationRegister
        
        guard let window = window else {
            return true
        }

        let viewControllerFactory = ViewControllerFactory(notificationRegister: notificationRegister)
        router = Router(window: window, viewControllerFactory: viewControllerFactory)
        router?.displayBloodTypeSeletion()
        

        
        
        // Override point for customization after application launch.
                
        
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            // For iOS 10 data message (sent via FCM
//            Messaging.messaging().delegate = self
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()
//
//        FirebaseApp.configure()
//
//        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
//            // 2
//            let aps = notification["aps"] as! [String: AnyObject]
//            print(">>> \(notification)")
//            print(">>> \(aps)")
//            sendLocalNotification()
//        }
//
//
        
        return true
    }
}

// MARK - notification registration

extension AppDelegate {
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        guard let pushRegisterResponse = self.pushNotificationRegisterResponse else { return }
        pushRegisterResponse.systemSuccessfullyRegistered()
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        guard let pushRegisterResponse = self.pushNotificationRegisterResponse else { return }
        pushRegisterResponse.systemFailedToRegister(error: error)
    }

}



/*
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print(">>> token did refresh \(fcmToken)")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(">>> remote message \(remoteMessage.appData)")
    }
    
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(">>>> \(remoteMessage.appData)")
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        Messaging.messaging().subscribe(toTopic: "alldevices")
        // Check to see if its a new one, if so send it to the backend
    }

    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
        // display error to user
    }
    
    // Called when app is in the foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        print(notification.request.content.userInfo)
        completionHandler([.alert, .badge, .sound])
    }

    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print(">>>> Push notification received: \(data)")
        
        if application.applicationState != .active {
            sendLocalNotification()
        }

    }
    
    // Triggered when you open the app from a push notification
    // or recived silent notification
    func application(_ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let aps = userInfo["aps"] as! [String: AnyObject]
        print(">>> got remote notification userInfo \(userInfo)")
        print(">>> got remote notification \(aps)")
        
        if application.applicationState != .active {
            sendLocalNotification()
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        print("got some stuff  \(userInfo) seconds.")
        completionHandler(.noData)
    }
    
    
    
    
    func reinstateBackgroundTask() {
        if backgroundTask == UIBackgroundTaskInvalid {
            registerBackgroundTask()
        }
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            [unowned self] in
            self.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }

    
    
    
    fileprivate func sendLocalNotification() {
        
        registerBackgroundTask()
        
        DispatchQueue.global().async {

            UIApplication.shared.applicationIconBadgeNumber = (UIApplication.shared.applicationIconBadgeNumber+1)
            
            let localNotification = UILocalNotification()
            localNotification.fireDate = Date().addingTimeInterval(1)
            localNotification.alertBody = "Your alert message"
            localNotification.timeZone = NSTimeZone.default
            UIApplication.shared.scheduleLocalNotification(localNotification)

            self.endBackgroundTask()
        }
        
    }

}
*/
    
extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

