//
//  TimeVC.swift
//  HouseParti
//
//  Created by Developer on 16/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class TimeVC:NewPostBaseVC {

    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var julyiLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var loactionAction: UIButton!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var startLbl: UILabel!
    var infoParameter :[String:Any] = [:]
    var selectStartTimeStr :String?
    var selectEndTimeStr :String?
    var startTime = ["7:00 PM","7:30 PM","8:00 PM","8:30 PM","9:00 PM"]
    var endTime = ["1:00 AM","1:30 AM","2:00 AM","2:30 AM","3:00 3M"]
    var selectCheck = Bool()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Host a party"
        self.btnNext.isEnabled = false
        self.btnNext.alpha = 0.6
       // self.startLbl.isHidden = false
      //  self.endLbl.isHidden = true
        print(self.infoParameter)
        selectCheck = true
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        self.startDateLbl.text = dateString
        self.endDateLbl.text = dateString
//        self.datePicker.backgroundColor = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        self.headerView.layer.borderWidth = 0.5
        self.headerView.layer.borderColor = UIColor.red.cgColor

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:UIButton Action
    @IBAction func startTimeACtion(_ sender: UIButton) {
       // self.startTimeBtn.isSelected = true
        self.endTimeBtn.titleLabel?.textColor = .black
        sender.titleLabel?.textColor = .white
        selectCheck = true
        self.endTimeBtn.backgroundColor = .clear
        self.startTimeBtn.backgroundColor = .red
    }
    @IBAction func endTimeAction(_ sender: UIButton) {
        sender.titleLabel?.textColor = UIColor.white
        self.startTimeBtn.titleLabel?.textColor = UIColor.black
        self.endTimeBtn.backgroundColor = .red
        self.startTimeBtn.backgroundColor = .clear
        selectCheck = false
    }
    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss"
      //  dateFormatter.dateStyle = DateFormatter.Style.short
     //   dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        if selectCheck == true{
        self.startDateLbl.text = strDate
        self.selectStartTimeStr = strDate
        self.infoParameter.updateValue(self.selectStartTimeStr ?? "", forKey: "start_time")

        }else{
        self.endDateLbl.text = strDate
        self.selectEndTimeStr = strDate
        self.infoParameter.updateValue(self.selectEndTimeStr ?? "", forKey: "end_time")
      }
        self.btnNext.isEnabled = true
        self.btnNext.alpha = 1.0
    }
    @IBAction func nextAction(_ sender: Any) {
        print( self.infoParameter)
        self.startAnimating()
        ConnectionManager.shared.postRequest(methodName:addParty, parameters: self.infoParameter, onCompletion: { (response, error) in
            if((error == nil)) {
                let status = response["status"] as! Int
                if status == 1 {
                    self.stopAnimating()
                    self.showAlertWithMesssage(message: response["message"] as! String, VC: self)
                    self.navigationController?.popViewController(animated: true)
                    UserDefaults.standard.removeObject(forKey: "partyName")
                    UserDefaults.standard.removeObject(forKey: "detial")
                    UserDefaults.standard.removeObject(forKey: "music")
                    UserDefaults.standard.removeObject(forKey: "ticket")

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
    @IBAction func detailAction(_ sender: Any) {
        
    }
    @IBAction func timeAction(_ sender: Any) {
        
    }
    @IBAction func finishAction(_ sender: Any) {
        
    }
}
