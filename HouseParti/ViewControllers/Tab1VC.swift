//
//  Tab1VC.swift
//  Tabbar
//
//  Created by Ketan on 7/26/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit

class Tab1VC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    var headeCountArr = ["90" ,"317"]
    var countriesinEurope = ["Salsa Party"]
    var countriesInSouthAmerica = ["Spice up your life and come dance with your friends. Let’s relax, drink, and dance. You will feel great and have a lot of fun!"]
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var titileCountLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionCountLbl: UILabel!
    @IBOutlet weak var titileLbl: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var namePartyTxt: HPTextField!
    var infoDict :[String:Any] = [:]
    override func viewDidLoad() {
      super.viewDidLoad()
       print(self.infoDict)
        namePartyTxt.delegate = self
        txtView.delegate = self
        let defaults = UserDefaults.standard
        let data = defaults.value(forKey: "partyName")
        let partyDetaiil = defaults.value(forKey: "detial")
        self.namePartyTxt.text = data as? String
        self.txtView.text = partyDetaiil as? String

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Pragma Mark - TextField Delegate -
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var nameParty: String = namePartyTxt.text!
        if textField == namePartyTxt {
            nameParty = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        }
        if nameParty != ""{
            UserDefaults.standard.set(nameParty, forKey: "partyName")
        }
        else {
           
        }
        return true
    }
  func textViewDidEndEditing(_ textView: UITextView) {
    let txtView: String = self.txtView.text!
    UserDefaults.standard.set(txtView, forKey: "detial")
  }
    
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
////        if txtFieldEmail.text != "" && txtFieldPassword.text != "" && (txtFieldEmail.text?.isValidEmail)! {
//////            self.btnLogin.isEnabled = true
//////            self.btnLogin.alpha = 1.0
////        } else {
//////            self.btnLogin.isEnabled = false
//////            self.btnLogin.alpha = 0.6
////        }
//        return true
//    }
}

