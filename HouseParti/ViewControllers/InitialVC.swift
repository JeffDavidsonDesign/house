//
//  InitialVC.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtFldPassword: HPTextField!
    @IBOutlet weak var txtFldEmail: HPTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actnBtnLogin(_ sender: Any) {
        if self.txtFldEmail?.text == "" || self.txtFldPassword?.text == "" {
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }
        if (self.txtFldEmail.text?.isValidEmail) == false {
            showAlertWithMesssage(message: NSLocalizedString("Please enter a valid email address.", comment: ""), VC: self)
            return
        }
        else{
            let parameters:[String: Any] = ["email": (self.txtFldEmail?.text)!,
                                            "password": (self.txtFldPassword?.text)!]
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
    
}
