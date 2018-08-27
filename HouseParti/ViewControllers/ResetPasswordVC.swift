//
//  ResetPasswordVC.swift
//  HouseParti
//
//  Created by Developer on 25/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitAction(_ sender: Any) {
        if self.emailTxt?.text == ""  {
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }
        if (emailTxt.text?.isValidEmail) == false {
            showAlertWithMesssage(message: NSLocalizedString("Please enter a valid email address.", comment: ""), VC: self)
            return
        }
        else{
            let parameters:[String: Any] = ["email": (self.emailTxt?.text)!]
            self.startAnimating()
            ConnectionManager.shared.postRequest(methodName:resetPassword, parameters: parameters, onCompletion: { (response, error) in
                if((error == nil)) {
                    let status = response["status"] as! Int
                    if status == 1 {
                        self.stopAnimating()
                        let alertView = UIAlertController(title: "", message: response["message"] as? String, preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alertView, animated: true, completion: nil)
                        
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
}
