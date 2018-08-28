//
//  NewPostBaseVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class NewPostBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Host a party"
        let closeButton = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(closeButtonPressed))
        self.navigationItem.rightBarButtonItem = closeButton
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func closeButtonPressed() {
        let tabBar = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
        tabBar.selectedIndex = 0
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
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
