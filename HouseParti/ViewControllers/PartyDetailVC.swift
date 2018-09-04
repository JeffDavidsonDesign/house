//
//  PartyDetailVC.swift
//  HouseParti
//
//  Created by Developer on 21/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class PartyDetailVC: UIViewController {

    @IBOutlet weak var viewFood: UIView!
    @IBOutlet weak var viewMusic: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "Details"
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actnBtnfood(_ sender: Any) {
        viewMusic.isHidden = true
        viewFood.isHidden = false
    }
    @IBAction func actnBtnMusic(_ sender: Any) {
        viewMusic.isHidden = false
        viewFood.isHidden = true
    }
}
