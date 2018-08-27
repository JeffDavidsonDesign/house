//
//  HPExtensions.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HPExtensions: NSObject {
    static let shared = HPExtensions()
    let sharedUserDefault =
        UserDefaults(suiteName: "group.com.pa.HouseParti")
    //MARK: Device Token
    var deviceToken: String {
        get {
            if let token =  UserDefaults.standard.string(forKey: "deviceToken") {
                return token
            } else {
                return ""
            }
        } set {
            UserDefaults.standard.set(newValue, forKey: "deviceToken")
            UserDefaults.standard.synchronize()
        }
    }
    //MARK: USERID
    var userId: String {
        get {
            if let user_Id =  UserDefaults.standard.string(forKey: "userId") {
                return user_Id
            } else {
                return ""
            }
        } set {
            UserDefaults.standard.set(newValue, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: LOGIN STATUS
    var loginStatus: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "loginStatus")
        } set {
            UserDefaults.standard.set(newValue, forKey: "loginStatus")
            UserDefaults.standard.synchronize()
        }
    }
}
extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    var RemoveWhiteSpace : String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
}
//MARK:- UIViewController extensions -
extension UIViewController: NVActivityIndicatorViewable {
  
    func showShadowInView(view:UIView){
        view.layer.shadowOpacity = 0.5
    }
    func showShadowInButton(button:UIButton){
        button.layer.shadowOpacity = 0.5
    }
    @objc func showTabBar() {
        self.stopAnimating()
        let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = tabBar
    }
    func showAlertWithMesssage(message:String, VC: UIViewController) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(action1)
        VC.present(alertController, animated: true, completion: nil)
    }
}
