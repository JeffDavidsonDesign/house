//
//  ProfileVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit
import MobileCoreServices
import Photos

class ProfileVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var btnPartiesAttending: UIButton!
    @IBOutlet weak var btnPartiesHosting: UIButton!
    @IBOutlet weak var leftViewConstraint: NSLayoutConstraint!
    var imagePickerController = UIImagePickerController()
    
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
    @IBAction func selectPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "Select Option", message: "", preferredStyle: .actionSheet)
        for i in ["Select Photo", "Take Photo" ] {
            alert.addAction(UIAlertAction(title: i, style: UIAlertActionStyle.default, handler: actionHandle))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: actionHandle))
        self.present(alert, animated: true, completion: nil)
    }
    
    func actionHandle(action: UIAlertAction){
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        if action.title == "Select Photo" {
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.mediaTypes = [kUTTypeImage as String]
            self.navigationController?.present(imagePickerController, animated: true, completion: nil)
        } else if action.title == "Take Photo" {
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeImage as String]
            imagePickerController.videoMaximumDuration = 30.0
            self.navigationController?.present(imagePickerController, animated: true, completion: nil)
        }
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
            cell.lblDate.text = (getData.start_time ?? "") + " " + (getData.partyAddress ?? "")
            cell.lblPrice.text = "Free"
            if getData.tickets_sold == ""{
                 cell.lblAttendingCount.text = ("0") + " " + "attending"
            }else{
            cell.lblAttendingCount.text = (getData.tickets_sold ?? "") + " " + "attending"
            }
            
        }else{
            let getData = self.partyAttend[indexPath.row]
            cell.lblTitle.text = getData.partyTitle
            cell.lblDate.text = (getData.start_time ?? "") + " " + (getData.partyAddress ?? "")
            cell.lblPrice.text =  "$" + getData.ticket_price!
            if getData.tickets_sold == ""{
                cell.lblAttendingCount.text = ("0") + " " + "attending"
            }
            else{
            cell.lblAttendingCount.text = (getData.tickets_sold ?? "") + " " + "attending"
            }
        }
        
        return cell
    }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getData = self.partyHost[indexPath.row]

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
                let parameters :[String:Any] = ["party_id":getData.party_hostedId ?? ""]
                self.startAnimating()
                ConnectionManager.shared.getMusic(methodName:removeParty, parameters: parameters, completionHandler: { (response, error) in
                    if((error == nil)) {
                        self.statusValue = response!
                        if self.statusValue?.status == 1 {
                            self.showAlertWithMesssage(message: (self.statusValue?.messege)!, VC: self);
                            self.stopAnimating()
                            self.getMusicMethod()
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
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
        else{
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
//    func addMediaApi(image:UIImage){
//        if let eventId = CommonMethod.shared.eventId {
//            let imgData1 = UIImageJPEGRepresentation(image, 0.6) as NSData?
//            let parameters:[String: String] = ["user_id":CommonMethod.shared.userId,"event_id":eventId,"media_type":"0","is_private": self.isprivateStr!]
//            self.startAnimating()
//            ConnectionManager.shared.postMediaRequest(methodName:addMedia , image: (imgData1! as Data), video: nil,videoExt:nil,parameters:parameters, onCompletion: { (response, error) in
//                if((error == nil)) {
//                    let status = response["status"] as! Int
//                    if status == 1{
//                        let media_id = response["media_id"] as! NSString
//                        print(media_id)
//                        self.stopAnimating()
//                        self.showAlertWithMesssage(message: response["message"] as! String, VC: self)
//                        self.getMediaMethod()
//                    } else {
//                        self.showAlertWithMesssage(message: response["message"] as! String, VC: self)
//                        self.stopAnimating()
//                        return
//                    }
//
//                } else {
//                    self.showAlertWithMesssage(message: (error?.localizedDescription)!, VC: self)
//                    self.stopAnimating()
//                    return
//                }
//            })
//        }
 //   }

}
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.navigationController?.dismiss(animated: true) {
            if let mediaType = info[UIImagePickerControllerMediaType] as? String {
                if mediaType == (kUTTypeImage as String) {
                    print("Image Selected")
                    var url = ""
                    if #available(iOS 11.0, *) {
                        if let URL =  info[UIImagePickerControllerImageURL] {
                            url = (URL as AnyObject).absoluteString!!
                        }
                    } else {
                    }
                    let image = info[UIImagePickerControllerEditedImage] as! UIImage
                    self.profileImageView.image = image
                   // self.addMediaApi(image: image)
                }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
