//
//  ProfileVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Kingfisher
class ProfileVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var btnPartiesAttending: UIButton!
    @IBOutlet weak var btnPartiesHosting: UIButton!
    @IBOutlet weak var leftViewConstraint: NSLayoutConstraint!
    
    var tableListType = "Hosting"
    var statusValue : GetStatus?
    var partyHost:[HouseMusic] = []
    var partyAttend:[HouseMusic] = []
    var user_Info:UserInfo?
    var userDetail:userData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "HouseParti"
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.borderColor = UIColor.black.cgColor
        getMusicMethod()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actnBtnPartiesAttending(_ sender: UIButton) {
        btnPartiesAttending .setTitleColor(UIColor.lightGray, for: .normal)
        btnPartiesHosting .setTitleColor(UIColor.black, for: .normal)
        leftViewConstraint.constant = sender.frame.origin.x+24
        self.tableListType = "Attending"
        self.tableView.reloadData()
    }
    
    @IBAction func actnBtnPartiesHosting(_ sender: UIButton) {
        btnPartiesHosting .setTitleColor(UIColor.lightGray, for: .normal)
        btnPartiesAttending .setTitleColor(UIColor.black, for: .normal)
        leftViewConstraint.constant = sender.frame.origin.x+24
        self.tableListType = "Hosting"
        self.tableView.reloadData()
    }
    func getMusicMethod() {
        let parameters :[String:Any] = ["user_id":HPExtensions.shared.userId]
        self.startAnimating()
        ConnectionManager.shared.getMusic(methodName:getUserDetails, parameters: parameters, completionHandler: { (response, error) in
            if((error == nil)) {
                self.statusValue = response!
                if self.statusValue?.status == 1 {
                    self.user_Info  = (self.statusValue?.getUserInfo)!
                    self.partyHost  = (self.user_Info?.parties_hosted)!
                    self.partyAttend  = (self.user_Info?.parties_attending)!
                    self.userDetail  = (self.user_Info?.user)!
                    let imgUrl = self.userDetail?.profile_image
                    let url = URL(string: imgUrl ?? "")
                    let image = UIImage(named:"ic_placeholder")
                    self.profileImageView.kf.setImage(with: url, placeholder: image)
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
extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tableListType == "Hosting"
        {
           return self.partyHost.count
        }
        else
        {
        return self.partyAttend.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPPartyCell") as! HPPartyCell
        cell.selectionStyle = .none
        if self.tableListType == "Hosting"
        {
            let getData = self.partyHost[indexPath.row]
            cell.lblTitle.text = getData.partyTitle
            cell.lblDate.text = getData.start_time
            cell.lblPrice.text = "Free"
            
        }else{
            let getData = self.partyAttend[indexPath.row]
            cell.lblTitle.text = getData.partyTitle
            cell.lblDate.text = getData.start_time
            cell.lblPrice.text =  "$" + getData.ticket_price!
        }
        
        return cell
    }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tableListType == "Hosting"
        {
            let alert = UIAlertController(title: nil, message: "What would you ike to do with this party?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Scan QR Code Ticket", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button")
            }))
            
            alert.addAction(UIAlertAction(title: "Edit party", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
            }))
            
            alert.addAction(UIAlertAction(title: "Remove Party", style: .destructive , handler:{ (UIAlertAction)in
                print("User click Delete button")
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
        else
        {
            let alert = UIAlertController(title:nil, message: "What would you ike to view?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "QR code Ticket", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button")
            }))
            
            alert.addAction(UIAlertAction(title: "Party Info", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
            }))
            
           
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
        
    }
    
}
