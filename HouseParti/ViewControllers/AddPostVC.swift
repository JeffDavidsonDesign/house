//
//  AddPostVC.swift
//  HouseParti
//
//  Created by developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewPostNav") as! UINavigationController
        self.present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
