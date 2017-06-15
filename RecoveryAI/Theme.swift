//
//  Theme.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/12/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//

import Foundation
import UIKit

let SelectedThemeKey = "SelectedTheme"

enum Theme {
    case Default, Dark, Graphical
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Graphical:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
    
    struct ThemeManager {
        static func currentTheme() -> Theme {
            if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey)? as AnyObject).integerValue {
                return Theme(rawValue: storedTheme)!
            } else {
                return .Default
            }
        }
        
        static func applyTheme(theme: Theme) {
            // 1
            NSUserDefaults.standardUserDefaults().setValue(theme.rawValue, forKey: SelectedThemeKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // 2
            let sharedApplication = UIApplication.sharedApplication()
            sharedApplication.delegate?.window??.tintColor = theme.mainColor
        }
        
        
    }
    
    
    
}
