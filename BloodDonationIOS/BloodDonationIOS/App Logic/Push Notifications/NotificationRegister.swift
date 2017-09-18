//
//  Copyright © 2017 Richard Moult. All rights reserved.
//
import UserNotifications
import UIKit


protocol NotificationRegesterProtocol {
    func register(completion:(Bool)->())
}


class NotificationRegister: NotificationRegesterProtocol {
    
    private weak var application: UIApplication?
    
    init(application: UIApplication) {
        self.application = application
    }
    
    func register(completion:(Bool)->()) {
        completion(true)
    }
    
}
