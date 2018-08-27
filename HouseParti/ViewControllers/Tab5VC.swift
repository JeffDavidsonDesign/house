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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
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
