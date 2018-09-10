//
//  HPPartyCell.swift
//  HouseParti
//
//  Created by Developer on 14/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class HPPartyCell: UITableViewCell {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAttendingCount: UILabel!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lbAdd: UILabel!

    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
       
        detailView.backgroundColor = .white
        detailView.layer.cornerRadius = 3
        detailView.layer.shadowOffset = CGSize(width: 0, height: 0)
        detailView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        detailView.layer.shadowOpacity = 1
        detailView.layer.shadowRadius = 3
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
