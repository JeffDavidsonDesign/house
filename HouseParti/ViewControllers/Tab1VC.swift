//
//  Tab1VC.swift
//  Tabbar
//
//  Created by Ketan on 7/26/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit

class Tab1VC: UIViewController {
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
    var getParamter :[String:Any] = [:]
    override func viewDidLoad() {
      super.viewDidLoad()
        
        print(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Pragma Mark - TextField Delegate -
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var email: String = namePartyTxt.text!
//        if textField == txtFieldEmail {
//            email = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        }
//        if email != "" {
//            self.btnLogin.isEnabled = true
//            self.btnLogin.alpha = 1.0
//        } else {
//            self.btnLogin.isEnabled = false
//            self.btnLogin.alpha = 0.6
//        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        if txtFieldEmail.text != "" && txtFieldPassword.text != "" && (txtFieldEmail.text?.isValidEmail)! {
////            self.btnLogin.isEnabled = true
////            self.btnLogin.alpha = 1.0
//        } else {
////            self.btnLogin.isEnabled = false
////            self.btnLogin.alpha = 0.6
//        }
        return true
    }
}
/*
//Mark:-UITableView Delegate and Datasouce
extension Tab1VC:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HPInfoHeader") as! HPInfoHeader
        headerCell.numberLbl.text = headeCountArr[section]
        headerCell.titileLbl.font = UIFont(name:"WhitneyHTF-SemiBold", size: 17.0)
        
        headerCell.titileLbl.textColor  = UIColor(red: 0.26, green: 0.26, blue: 0.27, alpha: 1)
        headerView.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.96, alpha: 1)
        switch (section) {
        case 0:
            headerCell.titileLbl.text = "TITLE";
            
            
            
        case 1:
            headerCell.titileLbl.text = "DESCRIPTION";
            
        default:
            headerCell.titileLbl.text = "";
        }
        headerView.addSubview(headerCell)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPInfoCell") as! HPInfoCell
        cell.selectionStyle = .none
        switch (indexPath.section) {
        case 0:
            cell.disLbl?.text = countriesinEurope[indexPath.row]
            
        case 1:
            cell.disLbl?.text = countriesInSouthAmerica[indexPath.row]
            
        default:
            cell.textLabel?.text = "Other"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
 */
