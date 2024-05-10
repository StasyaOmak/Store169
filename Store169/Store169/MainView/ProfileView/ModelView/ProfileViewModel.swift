//
//  ProfileViewModel.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    public var settings: [Setting] = [
        Setting(name: "Messages", iconName: "envelope", badge: "notificationMessage"),
        Setting(name: "Notifications", iconName: "bell", badge: "notificationNotification"),
        Setting(name: "Accounts Details", iconName: "person", badge: nil),
        Setting(name: "My purchases", iconName: "basket", badge: nil),
        Setting(name: "Settings", iconName: "gearshape", badge: nil)
    ]
    
}
