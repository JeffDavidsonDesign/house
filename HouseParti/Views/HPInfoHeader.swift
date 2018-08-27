//
//  HPInfoHeader.swift
//  HouseParti
//
//  Created by Developer on 16/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class HPInfoHeader: UITableViewCell {

    @IBOutlet weak var switchDrinks: UISwitch!
    @IBOutlet weak var titileLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
