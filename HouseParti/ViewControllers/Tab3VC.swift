//
//  Tab3VC.swift
//  Tabbar
//
//  Created by Ketan on 7/26/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit

class Tab3VC: UIViewController {

    @IBOutlet weak var tableViewFood: UITableView!
    var switchGetValue :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchGetValue = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
//Mark:-UITableView Delegate and Datasouce
extension Tab3VC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HPInfoHeader") as! HPInfoHeader
//        headerCell.titileLbl.font = UIFont(name:"WhitneyHTF-SemiBold", size: 15.0)
//        headerCell.titileLbl.textColor  = UIColor(red: 0.26, green: 0.26, blue: 0.27, alpha: 1)
//        headerView.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.96, alpha: 1)
//
//        headerCell.titileLbl.text = "DRINKS";
        headerCell.titileLbl.frame = CGRect(x: 22, y: 10, width: tableView.frame.size.width, height: 30)
        headerCell.titileLbl.textColor  = UIColor(red: 0.26, green: 0.26, blue: 0.27, alpha: 1)
        headerView.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.96, alpha: 1)
        headerCell.switchDrinks.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)

        headerView.addSubview(headerCell)
        
        return headerView
    }
    @objc func switchChanged(sender: UISwitch) {
        if sender.isOn {
            self.switchGetValue = "1"
        }else{
            self.switchGetValue = "0"
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPMusicCell") as! HPMusicCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
