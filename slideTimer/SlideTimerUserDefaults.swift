//
//  SlideTimerUserDefaults.swift
//  slideTimer
//
//  Created by LARRY COMBS on 3/8/18.
//  Copyright © 2018 LARRY COMBS. All rights reserved.
//

import UIKit

struct SlideTimerUserDefaults {

    let timeEntriesArrayKey = "timeEntriesArrayKey"
    
    func add(entry: String) {
        let defaults = UserDefaults.standard
        if var array = defaults.array(forKey: timeEntriesArrayKey) {
            array.append(entry)
            defaults.set(array, forKey: timeEntriesArrayKey)
        } else {
            defaults.set([entry], forKey: timeEntriesArrayKey)
        }
        
        defaults.synchronize()
    }
    
    func getAllEntries() -> [String] {
        let defaults = UserDefaults.standard
        if let array = defaults.array(forKey: timeEntriesArrayKey) as? [String] {
            return array
        } else {
            return [String]()
        }
    }
}
