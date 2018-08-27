//
//  LoginVC.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class LoginVC: AutenticationVC, UITextFieldDelegate {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtFieldPassword: HPTextField!
    @IBOutlet weak var txtFieldEmail: HPTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "LOG IN"
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func actionLogin(_ sender: Any) {
        if self.txtFieldEmail?.text == "" || self.txtFieldPassword?.text == "" {
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }
        if (txtFieldEmail.text?.isValidEmail) == false {
            showAlertWithMesssage(message: NSLocalizedString("Please enter a valid email address.", comment: ""), VC: self)
            return
        }
        else{
            let parameters:[String: Any] = ["email": (self.txtFieldEmail?.text)!,
                                            "password": (self.txtFieldPassword?.text)!]
            self.startAnimating()
            ConnectionManager.shared.postRequest(methodName:login, parameters: parameters, onCompletion: { (response, error) in
                if((error == nil)) {
                    let status = response["status"] as! Int
                    if status == 1 {
                        self.stopAnimating()
                        let dict = response["info"] as? [String:Any]
                        let getUserId = dict?["user_id"]
                        HPExtensions.shared.userId  = getUserId as! String
                        self.showAlertWithMesssage(message: response["message"] as! String, VC: self)
                        self.perform(#selector(self.showTabBar), with: nil, afterDelay: 0.5)
                        
                    } else {
                        self.showAlertWithMesssage(message: response["message"] as! String, VC: self)
                        self.stopAnimating()
                        return
                    }
                } else {
                    self.showAlertWithMesssage(message: (error?.localizedDescription)!, VC: self)
                    self.stopAnimating()
                    return
                }
            })
        }
    }
    //Pragma Mark - TextField Delegate -
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var email: String = txtFieldEmail.text!
        var password: String = txtFieldPassword.text!
        if textField == txtFieldEmail {
            email = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        } else {
            password = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        }
        
        if email != "" && password != "" && email.isValidEmail {
            self.btnLogin.isEnabled = true
            self.btnLogin.alpha = 1.0
        } else {
            self.btnLogin.isEnabled = false
            self.btnLogin.alpha = 0.6
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if txtFieldEmail.text != "" && txtFieldPassword.text != "" && (txtFieldEmail.text?.isValidEmail)! {
            self.btnLogin.isEnabled = true
            self.btnLogin.alpha = 1.0
        } else {
            self.btnLogin.isEnabled = false
            self.btnLogin.alpha = 0.6
        }
        return true
    }
    
}
