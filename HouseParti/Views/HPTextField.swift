//
//  HPTextField.swift
//  HouseParti
//
//  Created by developer on 13/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class HPTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 16, height: self.frame.size.height))
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
}
