//
//  Tab5VC.swift
//  HouseParti
//
//  Created by Developer on 17/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class Tab5VC: UIViewController {

    @IBOutlet weak var tableViewPrice: UITableView!
    
    @IBOutlet weak var ticketPriceTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Pragma Mark - TextField Delegate -
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var ticket: String = self.ticketPriceTxt.text!
        
        if textField == self.ticketPriceTxt {
            ticket = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        }
        if ticket != ""{
           // TimeVC.btnNext.isEnabled = true
          //  TimeVC.btnNext.alpha = 1.0
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
/*
//Mark:-UITableView Delegate and Datasouce
extension Tab5VC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HPInfoHeader") as! HPInfoHeader
       
        headerCell.titileLbl.font = UIFont(name:"WhitneyHTF-SemiBold", size: 17.0)
        
        headerCell.titileLbl.textColor  = UIColor(red: 0.26, green: 0.26, blue: 0.27, alpha: 1)
        headerView.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.96, alpha: 1)
        
        headerCell.titileLbl.text = "TICKET PRICE";
            
        
        headerView.addSubview(headerCell)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPInfoCell") as! HPInfoCell
        cell.selectionStyle = .none
        
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
