//
//  SignUpStep2VC.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SignUpStep2VC: AutenticationVC, UITextFieldDelegate {
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtFieldAge: HPTextField!
    @IBOutlet var genderSelection: [UIButton]!
    var getParameter : [String: Any] = [:]
    var genderStr:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SIGN UP"
        //Do any additional setup after loading the view.
        print(self.getParameter)
    }
    @IBOutlet weak var maleBtn: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBAction func genderSelection(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            (self.view.viewWithTag(1) as? UIButton)?.setTitleColor(ThemePinkColor, for: .normal)
            (self.view.viewWithTag(2) as? UIButton)?.setTitleColor(ThemeGreyColor, for: .normal)
            (self.view.viewWithTag(3) as? UIButton)?.setTitleColor(ThemeGreyColor, for: .normal)
            self.genderStr = sender.titleLabel?.text
            
            break
        case 2:
            (self.view.viewWithTag(2) as? UIButton)?.setTitleColor(ThemePinkColor, for: .normal)
            (self.view.viewWithTag(1) as? UIButton)?.setTitleColor(ThemeGreyColor, for: .normal)
            (self.view.viewWithTag(3) as? UIButton)?.setTitleColor(ThemeGreyColor, for: .normal)
            self.genderStr = sender.titleLabel?.text

            break
        default:
            (self.view.viewWithTag(3) as? UIButton)?.setTitleColor(ThemePinkColor, for: .normal)
            (self.view.viewWithTag(2) as? UIButton)?.setTitleColor(ThemeGreyColor, for: .normal)
            (self.view.viewWithTag(1) as? UIButton)?.setTitleColor(ThemeGreyColor, for: .normal)
            self.genderStr = sender.titleLabel?.text
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {

        if self.txtFieldAge?.text == "" {
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }else{
         self.getParameter.updateValue(self.txtFieldAge.text ?? "", forKey:"age")
         self.getParameter.updateValue(self.genderStr ?? "", forKey:"gender")
         self.startAnimating()
         ConnectionManager.shared.postRequest(methodName:register, parameters: self.getParameter, onCompletion: { (response, error) in
            if((error == nil)) {
                let status = response["status"] as! Int
                if status == 1 {
                    self.stopAnimating()
                    let dict = response["user_info"] as? [String:Any]
                    let getUserId = dict?["user_id"]
                    HPExtensions.shared.userId  = getUserId as! String
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let age = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if age != "" {
            self.btnSignUp.isEnabled = true
            self.btnSignUp.alpha = 1.0
        } else {
            self.btnSignUp.isEnabled = false
            self.btnSignUp.alpha = 0.6
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
       
        if textField.text != "" {
            self.btnSignUp.isEnabled = true
            self.btnSignUp.alpha = 1.0
        } else {
            self.btnSignUp.isEnabled = false
            self.btnSignUp.alpha = 0.6
        }
        return true
    }

}
