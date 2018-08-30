//
//  HomeVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,GetMapLocationProtocol {
    
    @IBOutlet weak var leftViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnWeekend: UIButton!
    @IBOutlet weak var btnToday: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var ListViewtype = "Today"
    var statusValue : GetStatus?
    var partList:[HouseMusic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "HouseParti"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPartyList()
        
    }
    func getPartyList() {
        let parameters :[String:Any] = ["music":"","filterby":"today","location":""]
        self.startAnimating()
        ConnectionManager.shared.getMusic(methodName:filterbyApi, parameters: parameters, completionHandler: { (response, error) in
            if((error == nil)) {
                self.statusValue = response!
                if self.statusValue?.status == 1 {
                    self.partList  = (self.statusValue?.party_info)!
                    self.stopAnimating()
                    self.tableView.reloadData()
                }else{
                    self.showAlertWithMesssage(message: (self.statusValue?.messege)!, VC: self);
                    self.stopAnimating()
                }
            } else {
                self.showAlertWithMesssage(message: (error?.localizedDescription)!, VC: self)
                self.stopAnimating()
                return
            }
        })
    }
    @IBAction func actnBtnToday(_ sender: UIButton) {
       
        btnToday .setTitleColor(UIColor.black, for: .normal)
        btnUpcoming .setTitleColor(UIColor.lightGray, for: .normal)
        btnWeekend .setTitleColor(UIColor.lightGray, for: .normal)
        leftViewConstraint.constant = sender.frame.origin.x
        ListViewtype = "Today"
        self.tableView.reloadData()
    }
    
    @IBAction func actnBtnWeekend(_ sender: UIButton) {
        btnToday .setTitleColor(UIColor.lightGray, for: .normal)
        btnUpcoming .setTitleColor(UIColor.lightGray, for: .normal)
        btnWeekend .setTitleColor(UIColor.black, for: .normal)
        leftViewConstraint.constant = sender.frame.origin.x
        ListViewtype = "Weekend"
         self.tableView.reloadData()
    }
    
    @IBAction func actnBtnUpcoming(_ sender: UIButton) {
        btnToday .setTitleColor(UIColor.lightGray, for: .normal)
        btnUpcoming .setTitleColor(UIColor.black, for: .normal)
        btnWeekend .setTitleColor(UIColor.lightGray, for: .normal)
        
         leftViewConstraint.constant = sender.frame.origin.x
         ListViewtype = "Upcoming"
         self.tableView.reloadData()
    }
    
    @IBAction func actnBtnLocation(_ sender: Any) {
        if #available(iOS 9.3, *) {
            let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
            mapVC.delegate =  self 
            self.navigationController?.pushViewController(mapVC, animated: true)
        } else {
            
        }
        
    }
    func GetUserLocation(selectedLocation:String)
    {
        print(selectedLocation)
        
    }
    @IBAction func actnBtnFilter(_ sender: Any) {
    }
    
}
//Mark:-UITableView Delegate and Datasouce
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.ListViewtype == "Today") {
            return  self.partList.count
        }
        else if (self.ListViewtype == "Upcoming" )
        {
            return 2
        }
        else
        {
        return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPPartyCell") as! HPPartyCell
        cell.selectionStyle = .none
      if (self.ListViewtype == "Today") {
        
         let getData = self.partList[indexPath.row]
         cell.lblTitle.text = getData.partyTitle
         cell.lblDate.text = (getData.start_time ?? "") + " " + (getData.partyAddress ?? "")
        if getData.tickets_sold == ""{
            cell.lblAttendingCount.text = ("0") + " " + "attending"
        }else{
            cell.lblAttendingCount.text = (getData.tickets_sold ?? "") + " " + "attending"
        }
        if getData.tickets_sold == ""{
            cell.lblPrice.text = "Free"
        }else{
            cell.lblPrice.text =  "$" + " " + (getData.ticket_price ?? "")
        }
      }
     
        return cell
    }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let partyDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PartyDetailVC") as! PartyDetailVC
        self.navigationController?.pushViewController(partyDetailVC, animated: true)
    }

}
