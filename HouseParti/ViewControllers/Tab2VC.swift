//
//  Tab2VC.swift
//  Tabbar
//
//  Created by Ketan on 7/26/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit

class Tab2VC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var musicArr = ["Indie","Hip-Hop","Jazz","Pop","Country","Salsa","Bachata"]
    var selectedCells:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
//Mark:-UITableView Delegate and Datasouce
extension Tab2VC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y:10, width: tableView.frame.size.width, height: 30))
        let menuHeaderLabel = UILabel(frame: CGRect(x: 22, y: 10, width: tableView.frame.size.width, height: 30))
        menuHeaderLabel.font = UIFont(name:"WhitneyHTF-SemiBold", size: 17.0)
        
        menuHeaderLabel.text = "MUSIC"
        menuHeaderLabel.textColor  = UIColor(red: 0.26, green: 0.26, blue: 0.27, alpha: 1)
        headerView.backgroundColor = UIColor(red: 0.89, green: 0.91, blue: 0.96, alpha: 1)
        headerView.addSubview(menuHeaderLabel)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musicArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPMusicCell") as! HPMusicCell
        cell.musicLbl.text = musicArr[indexPath.row]
        cell.accessoryType = self.selectedCells.contains(indexPath.row) ? .checkmark : .none

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if self.selectedCells.contains(indexPath.row) {
            self.selectedCells.remove(at: self.selectedCells.index(of: indexPath.row)!)
//            self.selectedCells.removeAtIndex(self.selectedCells.indexOf(indexPath.row)!)

        } else {
            self.selectedCells.append(indexPath.row)
        }
      self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
