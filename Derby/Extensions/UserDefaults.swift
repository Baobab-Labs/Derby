//
//  UserDefaults.swift
//  Derby
//
//  Created by Ben Hollar on 7/15/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    /// Check for the application's first launch
    ///
    /// This function returns true only on the first invocation for the given `userDefaults`. Consider storing this value accessible if it will need referenced in
    /// multiple locations.
    ///
    /// - Parameter userDefaults: The UserDefaults instance to use.
    static func isFirstLaunch(userDefaults: UserDefaults = .standard) -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !userDefaults.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            userDefaults.set(true, forKey: hasBeenLaunchedBeforeFlag)
        }
        return isFirstLaunch
    }
    
}
