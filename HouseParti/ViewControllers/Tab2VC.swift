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
    var selectedCells:[Int] = []
    var statusValue : GetStatus?
    var musicData:[HouseMusic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
          getMusicMethod()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   func getMusicMethod() {
    let parameters :[String:Any] = [:]
    self.startAnimating()
      ConnectionManager.shared.getMusic(methodName:getMusicList, parameters: parameters, completionHandler: { (response, error) in
        if((error == nil)) {
            self.statusValue = response!
            if self.statusValue?.status == 1 {
                print((self.statusValue?.music_info)!)
                 self.musicData  = (self.statusValue?.music_info)!
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
}
//Mark:-UITableView Delegate and Datasouce
extension Tab2VC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let menuHeaderLabel = UILabel(frame: CGRect(x: 22, y: 10, width: tableView.frame.size.width, height: 30))
        menuHeaderLabel.font = UIFont(name:"WhitneyHTF-SemiBold", size: 15.0)
        menuHeaderLabel.text = "MUSIC"
        menuHeaderLabel.textColor  = .white
        headerView.backgroundColor = .red
        headerView.addSubview(menuHeaderLabel)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.musicData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPMusicCell") as! HPMusicCell
        let getData = self.musicData[indexPath.row]
        cell.musicLbl.text = getData.musicName
//      cell.accessoryType = self.selectedCells.contains(indexPath.row) ? .checkmark : .none
        let defaults = UserDefaults.standard
        let musicCheck = defaults.value(forKey: "muic")
        if cell.isSelected || (musicCheck != nil)
        {
            cell.isSelected = false
            if cell.accessoryType == UITableViewCellAccessoryType.none
            {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getData = self.musicData[indexPath.row]
        let getId = Int(getData.musicId!)
        let cell = tableView.cellForRow(at: indexPath)
        if cell!.isSelected
        {
            cell!.isSelected = false
            if cell!.accessoryType == UITableViewCellAccessoryType.none
            {
                cell!.accessoryType = UITableViewCellAccessoryType.checkmark
                self.selectedCells.append(getId!)
                print(self.selectedCells)
                UserDefaults.standard.set(self.selectedCells, forKey: "music")
            }
            else
            {
                cell!.accessoryType = UITableViewCellAccessoryType.none
                self.selectedCells.remove(at: self.selectedCells.index(of:getId!)!)
                print(self.selectedCells)
               UserDefaults.standard.removeObject(forKey: "music")

            }
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
