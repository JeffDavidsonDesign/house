//
//  LocationVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class LocationVC: NewPostBaseVC ,UITextFieldDelegate,GetMapLocationProtocol{

    @IBOutlet weak var txtUnit: HPTextField!
    @IBOutlet weak var txtStreet: HPTextField!
    @IBOutlet weak var txtZipCode: HPTextField!
    @IBOutlet weak var txtCity: HPTextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var viewDetail: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:UIButtonAction
    @IBAction func nextAction(_ sender: Any) {
        if self.txtCity?.text == "" {
            showAlertWithMesssage(message: NSLocalizedString("Please fill all required informations.", comment: ""), VC: self)
            return
        }
        else {
            let parameters:[String: Any] = ["address": " ",
                                            "zipcode": " ",
                                            "city": self.txtCity?.text ?? "",
                                            "guest_limit":" ",
                                            "preferred_guest":" ",
                                            "hosted_by":"2"

                                            ]
            let cont = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
          //  self.viewDetail.addSubview((cont.view)!)
            print(parameters)
            cont.getParamter = parameters
            print(cont.getParamter)
            self.navigationController?.pushViewController(cont, animated: true)
        }
    }
    @IBAction func detailoAction(_ sender: Any) {
        
    }
    @IBAction func timeAction(_ sender: Any) {
        
    }
    
    @IBAction func finishAction(_ sender: Any) {
        
    }
    
    //Pragma Mark - TextField Delegate -
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //var unit: String = self.txtUnit.text!
       // var street: String = txtStreet.text!
       // var zipCode: String = txtZipCode.text!
         var cityStr: String = txtCity.text!

//        if textField == self.txtUnit {
//            unit = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        } else if textField == self.txtStreet {
//            street = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        }
        if textField == self.txtCity {
            cityStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        }
        if cityStr != "" {
            self.btnNext.isEnabled = true
            self.btnNext.alpha = 1.0
        }
        else {
            self.btnNext.isEnabled = false
            self.btnNext.alpha = 0.6
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if txtCity.text != ""  {
            self.btnNext.isEnabled = true
            self.btnNext.alpha = 1.0
        } else {
            self.btnNext.isEnabled = false
            self.btnNext.alpha = 0.6
        }
        return true
    }

    @IBAction func actnBtnLocation(_ sender: Any) {
        if #available(iOS 9.3, *) {
            let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
            mapVC.delegate =  self as?GetMapLocationProtocol
             self.navigationController?.pushViewController(mapVC, animated: true)
        } else {
            
        }
    }
    
    func GetUserLocation(selectedLocation:String)
    {
        print(selectedLocation)
        self.txtCity.text = selectedLocation
        if self.txtCity.text != "" {
            self.btnNext.isEnabled = true
            self.btnNext.alpha = 1.0
        }
        else {
            self.btnNext.isEnabled = false
            self.btnNext.alpha = 0.6
        }
        
    }
}
