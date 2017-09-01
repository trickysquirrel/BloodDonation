//
//  Copyright © 2017 Richard Moult. All rights reserved.
//
import UserNotifications
import UIKit

class NotificationRegister {
    
    func registerApplication(application: UIApplication) {
        
        // iOS 10 + support
        if #available(iOS 10, *) {
            
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
        // iOS 9 support
        else {
            
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
}
