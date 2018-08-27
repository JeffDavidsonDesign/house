//
//  SignUpStep1VC.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SignUpStep1VC: AutenticationVC, UITextFieldDelegate {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtFieldPassword: HPTextField!
    @IBOutlet weak var txtFieldEmail: HPTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SIGN UP"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionNext(_ sender: Any) {
       
      if self.txtFieldEmail?.text == "" || self.txtFieldEmail?.text == "" || self.txtFieldPassword?.text == "" {
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }
        if (txtFieldEmail.text?.isValidEmail) == false {
            showAlertWithMesssage(message: NSLocalizedString("Please enter a valid email address.", comment: ""), VC: self)
            return
        }
        else {
            let parameters:[String: Any] = ["first_name": "",
                                            "last_name":"",
                                            "email": (self.txtFieldEmail?.text)!,
                                            "password": (self.txtFieldPassword?.text)!,
                                            "device_token": HPExtensions.shared.deviceToken,
                                            "status": 1,
                                            "dob":"",
                                            "phone_number":""]
            let step2VC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpStep2VC") as! SignUpStep2VC
            step2VC.getParameter = parameters
            self.navigationController?.pushViewController(step2VC, animated: true)
        }
            
        
    }
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var email: String = txtFieldEmail.text!
    var password: String = txtFieldPassword.text!
    if textField == txtFieldEmail {
        email = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    } else {
        password = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    }
        if email != "" && password != "" && email.isValidEmail {
            self.btnNext.isEnabled = true
            self.btnNext.alpha = 1.0
        } else {
            self.btnNext.isEnabled = false
            self.btnNext.alpha = 0.6
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if txtFieldEmail.text != "" && txtFieldPassword.text != "" && (txtFieldEmail.text?.isValidEmail)! {
            self.btnNext.isEnabled = true
            self.btnNext.alpha = 1.0
        } else {
            self.btnNext.isEnabled = false
            self.btnNext.alpha = 0.6
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
