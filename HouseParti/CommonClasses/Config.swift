//
//  Config.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
let ThemePinkColor = UIColor(red: 247/255.0, green: 69/255.0, blue: 91/255.0, alpha: 1.0)
let ThemeGreyColor = UIColor(red: 0.97/255.0, green: 0.27/255.0, blue: 0.36/255.0, alpha: 1)

class Config: NSObject {
    class func customizeAppearance() {
        UINavigationBar.appearance().barTintColor = ThemePinkColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        let attributes = [NSAttributedStringKey.font: UIFont(name: "WhitneyHTF-Bold", size: 25)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
}


