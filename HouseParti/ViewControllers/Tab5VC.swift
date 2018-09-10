//
//  Tab5VC.swift
//  HouseParti
//
//  Created by Developer on 17/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class Tab5VC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var ticketPriceTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let data = defaults.value(forKey: "ticket")
         self.ticketPriceTxt.text = data as? String
        self.ticketPriceTxt.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Pragma Mark - TextField Delegate -
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var ticketPrice: String = self.ticketPriceTxt.text!
        if textField == ticketPriceTxt {
            ticketPrice = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        }
        if ticketPrice != ""{
            UserDefaults.standard.set(ticketPrice, forKey: "ticket")
        }
        else {
          //  TimeVC.btnNext.isEnabled = false
          //  TimeVC.btnNext.alpha = 0.6
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if ticketPriceTxt.text != "" {
          //  TimeVC.btnNext.isEnabled = true
           // TimeVC.btnNext.alpha = 1.0
        } else {
           // TimeVC.btnNext.isEnabled = false
           // TimeVC.btnNext.alpha = 0.6
        }
        return true
    }
}
