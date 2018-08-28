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
        self.startLbl.isHidden = false
        self.endLbl.isHidden = true
        print(self.infoParameter)
        selectCheck = true
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        self.startDateLbl.text = dateString
        self.endDateLbl.text = dateString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:UIButton Action
    @IBAction func startTimeACtion(_ sender: UIButton) {
       // self.startTimeBtn.isSelected = true
        self.endTimeBtn.titleLabel?.textColor = UIColor.gray
        sender.titleLabel?.textColor = UIColor.black
        self.startLbl.isHidden = false
        self.endLbl.isHidden = true
        selectCheck = true
    }
    @IBAction func endTimeAction(_ sender: UIButton) {
        //self.endTimeBtn.isSelected = true
        sender.titleLabel?.textColor = UIColor.black
        self.startTimeBtn.titleLabel?.textColor = UIColor.gray
        self.startLbl.isHidden = true
        self.endLbl.isHidden = false
        selectCheck = false
    }
    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
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
/*
//Mark:-UITableView Delegate and Datasouce
extension TimeVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  selectCheck == true {
            return startTime.count
        }else{
            return endTime.count

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPInfoHeader") as! HPInfoHeader
        cell.selectionStyle = .none
        if selectCheck == true {
         cell.titileLbl.text  = String(format:"July 25%d",indexPath.row+1)
         cell.numberLbl.text  = startTime[indexPath.row]
        }
        else{
            cell.titileLbl.text  = String(format:"July 25%d",indexPath.row+1)
            cell.numberLbl.text  = endTime[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)! as! HPInfoHeader
        self.btnNext.isEnabled = true
        self.btnNext.alpha = 1.0
        cell.backgroundColor = UIColor.init(red: 255/255.0, green: 194/255.0, blue: 50/255.0, alpha: 1.0)
        cell.titileLbl.textColor = UIColor.white
        cell.numberLbl.textColor = UIColor.white
         if selectCheck == true {
            self.selectStartTimeStr = startTime[indexPath.row]
            self.infoParameter.updateValue(self.selectStartTimeStr ?? "", forKey: "start_time")
            print( self.infoParameter)
        }
         else{
            self.selectEndTimeStr = endTime[indexPath.row]
            self.infoParameter.updateValue(self.selectEndTimeStr ?? "", forKey: "end_time")
            print( self.infoParameter)

        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)! as! HPInfoHeader
        cell.backgroundColor = UIColor.white
        cell.titileLbl.textColor = UIColor.black
        cell.numberLbl.textColor = UIColor.black
//        if  self.startTimeBtn.isSelected == true {
//      //  self.selectStartTimeStr?.remove(at: indexPath.row)
//        }else{
//       // self.selectEndTimeStr?.remove(at: indexPath.row)
//
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
*/
