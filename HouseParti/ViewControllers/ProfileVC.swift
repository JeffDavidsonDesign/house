//
//  ProfileVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var btnPartiesAttending: UIButton!
    @IBOutlet weak var btnPartiesHosting: UIButton!
    @IBOutlet weak var leftViewConstraint: NSLayoutConstraint!
    
    var tableListType = "Hosting"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.navigationItem.title = "HouseParti"
         self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.borderColor = UIColor.black.cgColor
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
    
}

//Mark:-UITableView Delegate and Datasouce
extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tableListType == "Hosting"
        {
           return 3
        }
        else
        {
        return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HPPartyCell") as! HPPartyCell
        cell.selectionStyle = .none
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
