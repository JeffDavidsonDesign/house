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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.title = "Host a party"
        self.btnNext.isEnabled = true
        self.btnNext.alpha = 0.6
        self.startLbl.isHidden = false
        self.endLbl.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:UIButton Action
    @IBAction func startTimeACtion(_ sender: UIButton) {
        self.endTimeBtn.titleLabel?.textColor = UIColor.gray
        self.tableView.reloadData()
        sender.titleLabel?.textColor = UIColor.black
        self.startLbl.isHidden = false
        self.endLbl.isHidden = true
    }
    @IBAction func endTimeAction(_ sender: UIButton) {
        sender.titleLabel?.textColor = UIColor.black
        self.startTimeBtn.titleLabel?.textColor = UIColor.gray
        self.startLbl.isHidden = true
        self.endLbl.isHidden = false
        self.tableView.reloadData()

    }
    @IBAction func nextAction(_ sender: Any) {
        
    }
    @IBAction func detailAction(_ sender: Any) {
        
    }
    @IBAction func timeAction(_ sender: Any) {
        
    }
    @IBAction func finishAction(_ sender: Any) {
        
    }
}
//Mark:-UITableView Delegate and Datasouce
extension TimeVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPInfoHeader") as! HPInfoHeader
        cell.selectionStyle = .none
        cell.titileLbl.text  = String(format:"July 25%d",indexPath.row+1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)! as! HPInfoHeader
        self.btnNext.isEnabled = true
        self.btnNext.alpha = 1.0
        cell.backgroundColor = UIColor.init(red: 255/255.0, green: 194/255.0, blue: 50/255.0, alpha: 1.0)
        cell.titileLbl.textColor = UIColor.white
        cell.numberLbl.textColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)! as! HPInfoHeader
        cell.backgroundColor = UIColor.white
        cell.titileLbl.textColor = UIColor.black
        cell.numberLbl.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
