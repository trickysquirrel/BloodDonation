//
//  Copyright © 2017 Richard Moult. All rights reserved.
//
// https://medium.com/ios-os-x-development/ios-remote-notification-with-firebase-tutorial-118acd3ebce1

import UserNotifications
import UIKit
import FirebaseMessaging


protocol NotificationRegisterProtocol {
    typealias ResponseBlock = (NotificationRegisterResponse)->()
    func register(completion:@escaping (NotificationRegisterResponse)->())
}


protocol PushNotificationRegisterResponse {
    func systemSuccessfullyRegistered()
    func systemFailedToRegister(error: Error)
}


enum NotificationRegisterResponse {
    case success
    case error(Error?)
}


fileprivate class Registering {
    
    private var pushNotificationRegistered = false
    private var firebaseRegistered = false
    
    func hasCompletedRegistration(applePushCompleted: Bool) -> Bool {
        pushNotificationRegistered = true
        if pushNotificationRegistered == true && firebaseRegistered == true {
            return true
        }
        return false
    }
    
    func hasCompletedRegistration(fireBaseCompleted: Bool) -> Bool {
        firebaseRegistered = true
        if pushNotificationRegistered == true && firebaseRegistered == true {
            return true
        }
        return false
    }
}


class MessagingRegister: NSObject, NotificationRegisterProtocol {
    
    private weak var application: UIApplication?
    private var completionBlock: ResponseBlock?
    private var registering: Registering?
    
    init(application: UIApplication) {
        self.application = application
    }
    
    func register(completion:@escaping ResponseBlock) {
        self.completionBlock = completion
        registering = Registering()
        if Messaging.messaging().apnsToken != nil {
            _ = registering?.hasCompletedRegistration(fireBaseCompleted: true)
        }
        requestPushNotificationAuthorization()
    }
        
    func requestPushNotificationAuthorization() {
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        
        // This causes the appDelegate push notification methods to be call which in turn use PushNotificationRegisterResponse methods
        // to call the completionBlock
        application?.registerForRemoteNotifications()
    }
    
}

// MARK: Called as a result of calling registerForRemoteNotifications

extension MessagingRegister: PushNotificationRegisterResponse {
    
    func systemSuccessfullyRegistered() {
        guard let registering = self.registering else { return }
        if registering.hasCompletedRegistration(applePushCompleted: true) {
            completionBlock?(.success)
        }
    }
    
    func systemFailedToRegister(error: Error) {
        completionBlock?(.error(error))
    }
    
}

// MARK: Firebase message delegate

extension MessagingRegister: MessagingDelegate {
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
        guard let registering = self.registering else { return }
        if registering.hasCompletedRegistration(fireBaseCompleted: true) {
            completionBlock?(.success)
        }
    }
}







extension MessagingRegister : UNUserNotificationCenterDelegate {
    
    var applicationStateString: String {
        if UIApplication.shared.applicationState == .active {
            return "active"
        } else if UIApplication.shared.applicationState == .background {
            return "background"
        }else {
            return "inactive"
        }
    }

    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }
    
    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
        //TODO: Handle background notification
        completionHandler()
    }
}
