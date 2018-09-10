//
//  SignUpStep1VC.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SignUpStep1VC: AutenticationVC, UITextFieldDelegate {

    @IBOutlet weak var txtFldGender: HPTextField!
    @IBOutlet weak var txtFldAge: HPTextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtFieldPassword: HPTextField!
    @IBOutlet weak var txtFieldEmail: HPTextField!
    var pickerLanguageData = [Int](0...48)
    var genderName = ["Male","Female","Other"]
    var fisrtStr:String = ""
    var secStr:String = ""
    var activeTextField = 0
    var activeTF : UITextField!
    var activeValue = ""
    var myPickerView:UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SIGN UP"
        //Do any additional setup after loading the view.
        txtFldAge.delegate = self
        txtFldGender.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actnBtnSignup(_ sender: Any) {
        if self.txtFldAge?.text == ""  || self.txtFldGender?.text == "" || self.txtFieldEmail?.text == "" || self.txtFieldPassword?.text == ""{
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }
        if (txtFieldEmail.text?.isValidEmail) == false {
            showAlertWithMesssage(message: NSLocalizedString("Please enter a valid email address.", comment: ""), VC: self)
            return
        }
        else{
            let parameter : [String:Any] = ["email":self.txtFieldEmail.text ?? "","password":self.txtFieldPassword.text ?? "","gender":self.txtFldGender.text ?? "" ,"age":self.txtFldAge.text ?? "" ,"status":1]
            self.startAnimating()
            ConnectionManager.shared.postRequest(methodName:register, parameters:parameter, onCompletion: { (response, error) in
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
    func pickUp(textField : UITextField){
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        //Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SignUpStep1VC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(SignUpStep1VC.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
}
extension SignUpStep1VC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch activeTextField {
        case 1:
            return pickerLanguageData.count
        case 2:
            return genderName.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch activeTextField {
        case 1:
            let myString = String(pickerLanguageData[row])
            return myString
        case 2:
            return genderName[row]
            
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch activeTextField {
        case 1:
            let myString = String(pickerLanguageData[myPickerView.selectedRow(inComponent: component)])
            activeValue = myString
        case 2:
            activeValue = genderName[myPickerView.selectedRow(inComponent: component)]

        default:
            activeValue = ""
        }
        print(activeValue)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.txtFldAge:
            activeTextField = 1
            activeTF = textField
            self.pickUp(textField:textField)
        case self.txtFldGender:
            activeTextField = 2
            activeTF = textField
            self.pickUp(textField:textField)
        default:
            activeTextField = 0
        }
    }
    @objc func doneClick() {
        activeTF.text = activeValue
        txtFldAge.resignFirstResponder()
        txtFldGender.resignFirstResponder()
        
    }
    @objc func cancelClick() {
        txtFldAge.resignFirstResponder()
        txtFldGender.resignFirstResponder()    }
}
